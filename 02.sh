#! /usr/bin/env bash
ans=0
IFS=$'-:\ \n'
while read m M b c; do x=${c//[^$b]}; [[ ${#x} -ge $m && ${#x} -le $M ]] && ans=$((ans+1)); done < ${1:-2.txt}
echo "2A: $ans"
ans=0
while read m M b c; do x=${c:$((m-1)):1}; y=${c:$((M-1)):1}; [[ $x != $y ]] && [[ $b == $x || $b == $y ]] && ans=$((ans+1)); done < ${1:-2.txt}
echo "2B: $ans"
