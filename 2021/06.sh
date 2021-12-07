#!/usr/bin/env bash
A=$(< "${1:-6.txt}")
A=${A//,}
solve() {
    for ((; n < $1; ++n)); do
        #births=${A//[^0]}; births=${births//0/8}
        births=$(tr -cd 0 <<< "$A" | tr 0 8)
        B=$(echo -n "$A" | tr 876543210 765432106 )
        A[i]="${B[i]}${births}"
    done
}
n=0
solve 80
echo "6A: ${#A}"
#solve 256
#echo "6B: ${#A}"
