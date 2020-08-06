#!/bin/bash

mkdir -p /root/wpa
cd /root/wpa

for i in {01..18}; do curl --connect-timeout 5 -JO "92.223.93.168/w1.$i.7z"; done

for i in {01..02}; do curl --connect-timeout 5 -JO "92.223.93.168/w1_21+.$i.7z"; done
