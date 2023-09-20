#!/usr/bin/env bash

if [ true == $(pamixer --get-mute) ]; then
    echo "True"
    exit
else
    pamixer --get-volume-human
fi

