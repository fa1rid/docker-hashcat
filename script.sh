#!/bin/sh

mkdir -p /root/wpa
cd /root/wpa

for i in {01..18}; do curl -JO "95.217.128.40:8000/100/w1.$i.7z"; done

for i in {01..02}; do curl -JO "95.217.128.40:8000/100/w1_21+.$i.7z"; done

