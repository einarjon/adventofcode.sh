#! /usr/bin/env bash
IFS=$'\n'
input=${1:-7.txt}
NEW=($(grep " shiny gold" "$input"))
FOUND=("${NEW[@]// bag*}")
BAGS=("${NEW[@]}")
while [ ${#FOUND[@]} != 0 ]; do
    NEW=($(grep -F "${FOUND[*]}" "$input" | grep -v -F "${BAGS[*]}" | sort -u))
    BAGS+=("${NEW[@]}")
    FOUND=("${NEW[@]// bag*}")
done
echo "7A: ${#BAGS[@]}"
r(){
    local A=() a=${1// *} b=0 c=0
    A=($(grep "^${1:2}" "$input" | grep -o "[0-9] [a-z]* [a-z]*"))
    for i in "${A[@]}"; do c=$(r "$i"); ((b+=c)); done
    echo $((a+a*b))
}
total=$(r "1 shiny gold")
echo "7B: $((total-1))" # minus 1 shiny gold bag
