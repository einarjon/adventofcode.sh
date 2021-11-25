#! /usr/bin/env bash
A=($(< "${1:-3.txt}")); l=${#A[0]}; N=${#A[@]}; k=0; j=3; x=""
for i in "${A[@]}"; do x+=${i:k:1}; ((k=(k+j)%l)); done; x=${x//\.}; total=${#x}
echo "3A: $total"
for j in 1 5 7; do x=""; k=0; for i in "${A[@]}"; do x+=${i:k:1}; ((k=(k+j)%l)); done; x=${x//\.}; total+="*${#x}"; done
x=""; k=0; for ((i=0;i<N;i+=2)); do x+=${A[i]:k:1}; ((k=(k+1)%l)); done ; x=${x//\.}; total+="*${#x}"
echo "3B: ${total} = $((total))"
