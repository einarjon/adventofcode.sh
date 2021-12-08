#!/bin/bash
input=$(< "${1:-7.txt}")
A=($(echo -e "${input//,/\\n}" | sort -n))
N=${#A[@]}
avg=$(((${input//,/+})/N))
n=""; for k in "${A[@]}";do n+=+$((k-A[N/2])); done
sum=$((${n//-})) # lazy abs()
echo "7A: $sum"
declare -i sum2=0
for k in "${A[@]}"; do
    dist=$((k-avg)); dist=${dist/-}
    sum2+=$((dist*(dist+1)/2))
done
echo "7B: $sum2"
