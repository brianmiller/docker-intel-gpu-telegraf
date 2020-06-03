#!/bin/bash

#This is so messy...

#Beat intel_gpu_top into submission
JSON=$(/usr/bin/timeout -k 3 3 /usr/bin/intel_gpu_top -J)
VIDEO_UTIL=$(echo "$JSON"|grep Video/0 -A 1|tail -1|grep busy|cut -d ":" -f2|cut -d "," -f1|cut -d " " -f2)

#Spit out something telegraf can work with
echo "[{\"time\": `date +%s`, \"intel_gpu_util\": "$VIDEO_UTIL"}]"

#Exit cleanly
exit 0
