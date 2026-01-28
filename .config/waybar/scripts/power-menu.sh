#!/usr/bin/env bash
#!/usr/bin/env bash

choice=$(printf '%s\n' \
  "Lock" \
  "Shutdown" \
  "Reboot" \
  "Suspend" \
  "Hibernate" \
  "Logout" \
  | fuzzel --dmenu
)

[ -z "$choice" ] && exit 0

case "$choice" in
  *Lock)
    hyprlock
    ;;
  *Shutdown)
    systemctl poweroff
    ;;
  *Reboot)
    systemctl reboot
    ;;
  *Suspend)
    systemctl suspend
    ;;
  *Hibernate)
    systemctl hibernate
    ;;
  *Logout)
    # If this misbehaves, you can instead use:
    # hyprctl dispatch exit 0
    loginctl kill-session "$XDG_SESSION_ID"
    ;;
esac

