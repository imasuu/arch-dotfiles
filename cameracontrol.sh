#!/bin/bash

if pgrep -l . | grep -q "ffmpeg"; then
  kill $(pgrep -f "ffmpeg -f v4l2 -i /dev/video0 -vf hflip,format=yuv420p -f v4l2 /dev/video9")
else
  ffmpeg -f v4l2 -i /dev/video0 -vf "hflip,format=yuv420p" -f v4l2 /dev/video9
fi
