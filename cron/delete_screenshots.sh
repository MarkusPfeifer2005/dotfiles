#!/bin/bash

SCREENSHOT_DIR="/home/markus/Pictures/Screenshots"

# Delete .png and .jpg files older than 48 hours
find "$SCREENSHOT_DIR" -type f \( -name "*.png" -o -name "*.jpg" \) -mtime +1 -delete

