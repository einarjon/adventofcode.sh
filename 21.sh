#! /usr/bin/env bash
IFS=$' \n' input=${1:-21.txt}
A=($(grep -o "contains.*" "$input" | grep -o "[a-z]*" | grep -v contains| sort | uniq -c))
i=0;
while read -r a b; do
   C[i++]=$(grep -w "$b" "$input" | grep -o ".*(" | grep -o "[a-z]*" | sort | uniq -c | grep -w "$a" | tr -ds '0-9\n' ' ')
done < <(printf "%s %s\n" "${A[@]}")

space="^[[:space:]]+$"
one="^[[:space:]]*[a-z]+[[:space:]]*$"
until [[ ${C[*]} =~ $space ]]; do
  for i in "${!C[@]}"; do
    if [[ ${C[i]} =~ $one ]]; then
      B[i]=${C[i]// }
      C=("${C[@]//${B[i]}}")
    fi
  done
done

IFS=$'\n'
ans=$(grep -o ".*(" "$input" | grep -o "[a-z]*" | grep -v -c -F "${B[*]}")
echo "21A: $ans"
IFS=$','
echo "21B: ${B[*]}"
