#!/usr/bin/env bash
declare -i A=(0 0 0 0 0 0 0 0 0) n=0
while read -r freq age; do A[age]=$freq; done < <(grep -o "[0-9]" "${1:-6.txt}" | sort | uniq -c)
solve() {
    while ((n < $1)); do
        i=$((n++%9))
        A[i-2]+=${A[i]}
    done
    sum=0; for i in "${!A[@]}"; do ((sum+=A[i])); done
}
solve 80
echo "6A: $sum"
solve 256
echo "6B: $sum"
