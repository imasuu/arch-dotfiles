#!/bin/bash

border_output=$(hyprctl getoption general:border_size)
rounding_output=$(hyprctl getoption decoration:rounding)
gaps_out_output=$(hyprctl getoption general:gaps_out)
gaps_in_output=$(hyprctl getoption general:gaps_in)

border_size=$(echo "$border_output" | awk '/int:/ {print $2}')
rounding_size=$(echo "$rounding_output" | awk '/int:/ {print $2}')

gaps_out=$(echo "$gaps_out_output" | awk '/custom type:/ {print $3,$4,$5,$6}')
gaps_in=$(echo "$gaps_in_output" | awk '/custom type:/ {print $3,$4,$5,$6}')

if [ "$border_size" -eq 0 ] && [ "$rounding_size" -eq 0 ] && [ "$gaps_out" == "0 0 0 0" ] && [ "$gaps_in" == "0 0 0 0" ]; then
     hyprctl --batch "keyword general:gaps_out 15 ; keyword general:gaps_in 5 ; keyword general:border_size 2 ; keyword decoration:rounding 0"
else
     hyprctl --batch "keyword general:gaps_out 0 ; keyword general:gaps_in 0 ; keyword general:border_size 0 ; keyword decoration:rounding 0"
fi
