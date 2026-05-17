#!/bin/bash
choice=$(echo -e " Выключить\n Перезагрузить\n Спать\n Выйти" | wofi --dmenu --prompt "Power Menu")

case $choice in
    " Выключить") systemctl poweroff ;;
    " Перезагрузить") systemctl reboot ;;
    " Спать") systemctl suspend ;;
    " Выйти") hyprctl dispatch exit ;;
esac
