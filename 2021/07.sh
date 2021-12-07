#!/usr/bin/env bash
A=($(tr , '\n' < "${1:-7.txt}" | sort -n ))
MIN=(99999999 0) MIN2=(9999999999999 0)
N=${#A[@]}
for ((i=A[N/4]; i<A[-N/4]; i++)); do
    n=''; for k in ${A[@]};do n+=+$((k-i)); done;
    sum=$((${n//-})) # lazy abs()
    ((MIN>sum)) && MIN=($sum $i)
done
echo "7A: ${MIN[0]}"

for ((i=A[N/4]; i<A[-N/4]; i++)); do
    declare -i sum2=0;
    for k in ${A[@]}; do
        dist=$((k-i)); dist=${dist/-}
        sum2+=$((dist*(dist+1)/2))
    done;
    ((MIN2>sum2)) && MIN2=($sum2 $i)
done
echo "7B: ${MIN2[0]}"
