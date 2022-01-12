#!/usr/bin/env bash
A=($(tr '()[]{}<>' '1a2b3c4d' < "${1:-10.txt}"))
while [[ ${A[*]} =~ (1a|2b|3c|4d) ]]; do
    A=(${A[@]//1a}); A=(${A[@]//2b}); A=(${A[@]//3c}); A=(${A[@]//4d})
    echo $((++i))
done
# P1 only contains closing brackets. P2 only contains lines with no closing brackets
# shellcheck disable=SC2034
a=3 b=57 c=1197 d=25137 P1=(${A[@]//[1234]}) P2=(${A[@]/*[^1234]*}) C=()
printf -v sum "+%.1s" "${P1[@]}" # Only print first char
echo "10A: $((sum))"
while read -r -a B; do
    sum=0
    for i in "${B[@]}"; do sum=$((sum*5+i)); done
    C+=($sum)
done < <(printf "%s\n" "${P2[@]}" | rev | sed 's/./ &/g')
C=($(printf "%s\n" "${C[@]}" | sort -n ))
N=${#C[@]}
echo "10B: ${C[N/2]}"
