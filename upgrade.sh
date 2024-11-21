#!/bin/bash

paru -Syu
hyprpm update -v -s
cd anime-girls
echo "anime girls:"
git pull
cd
cd ~/.config/ags
echo "bar:"
git pull
cd
echo "manually update repositories with changes"
