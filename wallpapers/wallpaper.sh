#!/bin/bash

script_dir=$(dirname "$(realpath "$0")")

log_file="$script_dir/wallpaper.log"
log_size_limit=1048576
last_wallpaper="$script_dir/last_wallpaper"

log_message() {
    rotate_logs
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$log_file"
}

rotate_logs() {
    if [ -f "$log_file" ] && [ $(stat -c%s "$log_file") -ge $log_size_limit ]; then
        mv "$log_file" "$log_file.$(date '+%Y%m%d%H%M%S').log"
        touch "$log_file"
        log_message "Log file rotated."
    fi
}

refresh_wallpapers() {
    wallpapers=()
    for file in "$script_dir"/*; do
        if [ -f "$file" ] && [[ "$file" != "$0" ]] && [[ "$file" != "$log_file" ]] && [[ "$file" != "$last_wallpaper" ]]; then
            wallpapers+=("$file")
        fi
    done
}

apply_wallpaper() {
    local wallpaper="$1"
    swww img "$wallpaper" --transition-type outer --transition-pos 0.854,0.977 --transition-step 90
    if [ $? -ne 0 ]; then
        log_message "Failed to set wallpaper: $wallpaper"
        return 1
    fi

    log_message "Wallpaper changed to: $wallpaper"
    return 0
}

if [ -f "$last_wallpaper" ]; then
    old=$(cat "$last_wallpaper")
else
    old=-1
fi

refresh_wallpapers
total_wallpapers=${#wallpapers[@]}

if [ $total_wallpapers -eq 0 ]; then
    log_message "No valid wallpapers found in the directory."
    exit 1
fi

log_message "Script initialized."

selected_wallpaper=""
while true; do
    random=$(($RANDOM % total_wallpapers))
    selected_wallpaper=${wallpapers[$random]}
    file_type="${selected_wallpaper##*.}"

    if [[ "$file_type" != "gif" ]]; then
        log_message "Initial wallpaper found: $selected_wallpaper"
        apply_wallpaper "$selected_wallpaper"
        if [ $? -eq 0 ]; then
            old=$random
            echo "$random" > "$last_wallpaper"
        else
            log_message "Failed to set initial wallpaper. Retrying."
        fi
        break
    fi
done

while true; do
    refresh_wallpapers
    total_wallpapers=${#wallpapers[@]}

    if [ $total_wallpapers -eq 0 ]; then
        log_message "No valid wallpapers found. Retrying in one hour."
        sleep 3600
        continue
    fi

    random=$(($RANDOM % total_wallpapers))
    if [ "$random" -eq "$old" ] && [ $total_wallpapers -gt 1 ]; then
        random=$((($random + 1) % total_wallpapers))
    fi

    selected_wallpaper=${wallpapers[$random]}
    file_type="${selected_wallpaper##*.}"

    if [[ "$file_type" == "gif" ]]; then
        log_message "GIF detected, loading 4 minutes earlier: $selected_wallpaper"
        sleep_time=$((3600 - 240))
    else
        sleep_time=3600
    fi

    apply_wallpaper "$selected_wallpaper"
    if [ $? -eq 0 ]; then
        echo "$random" > "$last_wallpaper"
        old=$random
    else
        log_message "Retrying wallpaper change in 5 minutes."
        sleep 300
        continue
    fi

    sleep "$sleep_time"
done
