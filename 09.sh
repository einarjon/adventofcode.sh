#! /usr/bin/env bash
A=($(< "${1:-9.txt}"))
idx=(${!A[@]})
for i in "${idx[@]:25}"; do
    for j in "${idx[@]:i-25:25-1}"; do
        ((A[j] >= A[i])) && continue
        for k in "${idx[@]:j+1:i-j-1}"; do
            ((A[j]+A[k] == A[i])) && break 2
        done
    done
    ((A[j]+A[k] != A[i])) && break
done
echo "9A: line $i = ${A[i]}"

k=0; j=0; sum=${A[j++]}
while [ "$sum" != "${A[i]}" ]; do
    if   ((sum < A[i])); then ((sum+=A[j++]))
    elif ((sum > A[i])); then ((sum-=A[k++]))
    fi
    ((j >= i)) && echo NOT FOUND && break
done
B=($(printf "%s\n" "${A[@]:k:j-k}" | sort -n))
echo "9B: $k..$j = $((B[0]+B[-1]))"
