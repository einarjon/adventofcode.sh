#!/usr/bin/env bash
A=($(sort -nr 17.txt))
idx=("${!A[@]}") B=()

declare -i min=0 max=${#A[@]} sum1=${A[0]} sum2=${A[--max]} N=150
while (( sum1 < N )); do sum1+=${A[++min]}; done
while (( sum2 < N )); do sum2+=${A[--max]}; done; max+=1
r() {
    local j=$1 k numbers=(${A[$1]} "${@:2}")
    if (( $# > min )); then
        local list="${numbers[*]}" sum
        sum=$((${list// /+}))
        if ((sum == N)); then
            B+=("${list}")
            return
        elif ((sum > N)); then
            return
        fi
    fi
    for k in "${idx[@]:$j+1}"; do
        r "$k" "${numbers[@]}"
    done
}

for i in "${idx[@]:0:max}"; do r "$i"; done
echo "17A: ${#B[@]}"
# Sort by number of spaces. The combos with fewest buckets are on top.
ans=($(printf "%s\n" "${B[@]//[0-9]}" | sort | uniq -c))
echo "17B: ${ans[0]// }"
