#!/bin/bash

kill $(pidof waybar)
/usr/bin/waybar -c $HOME/.config/hypr/waybarconfig/config.jsonc -s $HOME/.config/hypr/waybarconfig/style.css &

