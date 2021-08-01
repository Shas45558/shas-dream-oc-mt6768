#!/system/bin/sh

#swapfile
RamStr=$(cat /proc/meminfo | grep MemTotal)
RamMB=$((${RamStr:16:8} / 1024))
file=/data/swapfile
if [ $RamMB -ge 3721 ]; then
  if ! [ -f "$file" ]; then
    fallocate -l 2G $file
    mkswap $file
    echo "swap created"
  else
    echo "swap already present"
  fi
  swapon -p 0 $file
  echo 100 > /proc/sys/vm/overcommit_ratio
else
  rm $file
fi
