#!/bin/bash

paru -Syyu
cd nvidia-all
echo "nvidia:"
git pull
cd
cd anime-girls
echo "anime girls:"
git pull
cd
cd ~/.config/ags
echo "bar:"
git pull
cd
echo "manually update repositories with changes"
