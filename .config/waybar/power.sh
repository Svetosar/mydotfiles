#!/bin/bash

choice=$(printf " Выключить\n Перезагрузить\n Выйти" | fuzzel --dmenu --prompt "Power > ")

case "$choice" in
" Выключить")
    systemctl poweroff
    ;;
" Перезагрузить")
    systemctl reboot
    ;;
" Выйти")
    niri msg action quit
    ;;
esac

