#!/usr/bin/env bash
input=$(< "${1:-7.txt}")
A=($(echo -e "${input//,/\\n}" | sort -n))
N=${#A[@]} n=""
declare -i avg=$(((${input//,/+})/N)) sum2=0
for k in "${A[@]}"; do
    n+=+$((k-A[N/2]));
    dist=$((k-avg)); dist=${dist/-}
    sum2+=$((dist*(dist+1)/2))
done
sum=${n//-} # lazy abs()
echo "7A: $((sum))"
echo "7B: $sum2"
