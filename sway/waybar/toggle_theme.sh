#!/usr/bin/env bash

declare -i num=3

pgrep -f "bash .*$(basename "$0")" | grep -v "^$$" | xargs -r kill

trap 'toggle_theme' SIGUSR1

function toggle_theme() {
    local -i total_available_themes=3
    local config_dir="${HOME}/.config/sway"
    local waybar_config="" waybar_styles=""

    num=$(( (num % total_available_themes) + 1 ))

    background_img="${config_dir}/waybar/$num/bg"
    waybar_config="${config_dir}/waybar/$num/config.jsonc"
    waybar_styles="${config_dir}/waybar/$num/style.css"

    pkill -x waybar
    swaymsg output '*' background "${background_img}" fill
    waybar -c "${waybar_config}" -s "${waybar_styles}" &
    notify-send -t 1000 "Started Waybar with profile: $num"
}

function main() {
    toggle_theme
    while read -r; do :; done < <(tail -f /dev/null)
}

main "$@"

