#! /usr/bin/env bash
A=($(< "${1:-3.txt}")); l=${#A[0]}; k=0; j=3; total=1; x=""
for i in "${A[@]}"; do x+=${i:k:1}; ((k=(k+j)%l)); done; x=${x//\.}
echo "3A: ${#x}"
idx2=$(seq 0 2 $((${#A[@]}-1)))
for j in 1 3 5 7; do x=""; k=0; for i in "${A[@]}"; do x+=${i:k:1}; ((k=(k+j)%l)); done; x=${x//\.}; total+="*${#x}"; done
x=""; k=0; for i in $idx2; do x+=${A[i]:k:1}; ((k=(k+2)%l)); done ; x=${x//\.}; total+="*${#x}"
echo "3B: ${total:2} = $((total))"
