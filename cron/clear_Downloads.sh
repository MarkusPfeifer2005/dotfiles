#!/bin/bash

DOWNLOADS_DIR="/home/markus/Downloads"

# Delete directories and files older than 48 hours
find "$DOWNLOADS_DIR" -mindepth 1 -type d -mmin +2880 -prune -exec rm -rf {} +
find "$DOWNLOADS_DIR" -mindepth 1 -type f -mmin +2880 -delete

