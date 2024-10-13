#!/bin/bash
cpu_usage (){
  echo -e "\nCpu Usage\n"
  top -n 1 | grep ^%Cpu
}

ram_usage (){
  echo -e "\nRam Usage\n"
  top -n 1 | grep ^MiB\ Mem
}

storage_usage (){
  echo -e "\nStorage Usage\n"
  df -h
}

five_cpu() {
  echo -e "\nTop 5 processes by CPU usage\n"
  ps aux --sort -%cpu | head -n 5
}

five_mem() {

  echo -e "\nTop 5 processes by memory usage\n"
  ps aux --sort -%mem
}

for i in cpu_usage ram_usage storage_usage five_cpu five_mem; do
  $i
done
