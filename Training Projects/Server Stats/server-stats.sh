#!/bin/bash
echo -e "Cpu Usage\n"
top -n 1 | grep ^%Cpu

echo -e "Ram Usage\n"
top -n 1 | grep ^MiB\ Mem

echo -e "Storage Usage\n"
df -h

echo -e "Top 5 processes by CPU usage\n"
ps aux --sort -%cpu | head -n 5
echo -e "Top 5 processes by memory usage\n"
ps aux --sort -%mem
