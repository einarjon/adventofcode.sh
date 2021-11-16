#!/usr/bin/env bash
A=$(sed 's/(/+1 /g;s/)/-1 /g;' "${1:-1.txt}")
echo "1A: $((A))"
n=0;sum=0
#for i in $A; do n=$((++n)); sum=$((i+sum)); [ $sum = -1 ] && break; done
for i in $A; do ((++n, sum+=i)); ((sum < 0)) && break; done
echo "1B: $n"
