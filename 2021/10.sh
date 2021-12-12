#!/usr/bin/env bash
A=($(tr '()[]{}<>' '1a2b3c4d' < "${1:-10.txt}"))
while [[ ${A[*]} =~ (1a|2b|3c|4d) ]]; do
    A=(${A[@]//1a}); A=(${A[@]//2b}); A=(${A[@]//3c}); A=(${A[@]//4d})
done
# shellcheck disable=SC2034
a=3 b=57 c=1197 d=25137 TMP=(${A[@]//[1234]}) C=()
printf -v sum "+%.1s" "${TMP[@]}" # TMP only contains closing brackets. Print first char
echo "10A: $((sum))"
while read -r -a B; do
    sum=0
    for i in "${B[@]}"; do sum=$((sum*5+i)); done
    C+=($sum)
done < <( printf "%s\n" "${A[@]}" | grep -v -E '[a-d]' | rev | sed 's/./ &/g')
C=($(printf "%s\n" "${C[@]}" | sort -n ))
N=${#C[@]}
echo "10B: ${C[N/2]}"
