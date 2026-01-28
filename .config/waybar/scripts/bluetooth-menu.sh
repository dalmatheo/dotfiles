#!/usr/bin/env bash
# Hyprland-friendly Bluetooth menu using fuzzel
# Works reliably by querying bluetoothctl synchronously

# Dependencies
for cmd in bluetoothctl fuzzel; do
    command -v $cmd >/dev/null 2>&1 || { echo "$cmd required"; exit 1; }
done

# Scan for available devices
scan_devices() {
    bluetoothctl scan on &
    sleep 5
    bluetoothctl scan off
    bluetoothctl devices | awk '{$1=""; print substr($0,2)}'  # MAC NAME
}

# List paired devices
list_paired() {
    bluetoothctl paired-devices | awk '{$1=""; print substr($0,2)}'  # MAC NAME
}

# Get device status
get_device_status() {
    local mac=$1
    info=$(bluetoothctl info "$mac")
    connected=$(echo "$info" | grep "Connected: yes" &>/dev/null && echo "Connected" || echo "Disconnected")
    paired=$(echo "$info" | grep "Paired: yes" &>/dev/null && echo "Paired" || echo "Not paired")
    echo "$paired | $connected"
}

# Build menu
build_menu() {
    local devices=("$@")
    menu=""
    for dev in "${devices[@]}"; do
        mac=$(echo "$dev" | awk '{print $1}')
        name=$(echo "$dev" | awk '{for(i=2;i<=NF;i++) printf $i " "; print ""}' | sed 's/ $//')
        status=$(get_device_status "$mac")
        menu+="$mac - $name [$status]\n"
    done
    echo -e "$menu"
}

# Device action menu
device_action_menu() {
    local mac=$1
    status=$(get_device_status "$mac")
    actions=""
    [[ "$status" == *Connected* ]] && actions+="Disconnect\n" || actions+="Connect\n"
    [[ "$status" == *Paired* ]] && actions+="Remove\n" || actions+="Pair\n"
    actions+="Back"
    echo -e "$actions" | fuzzel --prompt "Device $mac > "
}

# Main loop
while true; do
    paired=$(list_paired)
    scanned=$(scan_devices)
    mapfile -t all_devices < <(echo -e "$paired\n$scanned" | sort -u)
    [[ ${#all_devices[@]} -eq 0 ]] && { notify-send "No Bluetooth devices found"; exit; }

    # Show device menu
    menu=$(build_menu "${all_devices[@]}")
    selection=$(echo -e "$menu" | fuzzel --prompt "Bluetooth > ")
    [[ -z "$selection" ]] && exit 0  # Exit on ESC
    mac=$(echo "$selection" | awk '{print $1}')

    # Device action menu
    action=$(device_action_menu "$mac")
    [[ -z "$action" ]] && continue
    case "$action" in
        Connect) bluetoothctl connect "$mac" ;;
        Disconnect) bluetoothctl disconnect "$mac" ;;
        Pair) bluetoothctl pair "$mac" ;;
        Remove) bluetoothctl remove "$mac" ;;
        Back) continue ;;
    esac
done

