#!/bin/bash

BASE_DIR="$(dirname "$0")"

mapfile -t IMAGES < <(find "$BASE_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.gif" \))

if [ ${#IMAGES[@]} -eq 0 ]; then
    echo "No images found in the directory."
    exit 1
fi

RANDOM_IMAGE=${IMAGES[RANDOM % ${#IMAGES[@]}]}

img2sixel "$RANDOM_IMAGE" -w 512
