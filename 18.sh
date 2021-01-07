#! /usr/bin/env bash
IFS=$'\n'
set -f # globbing off
A=($(< ${1:-18.txt}))
c() {
    local i sum=0 op='+'
    for i in ${*//[()]}; do
        if [[ $i = '+' || $i = '*' ]]; then
            op=$i
        else
            sum=$((sum$op$i))
        fi
    done
    #echo "c:  ${@//[()]} =  $sum " >&2
    echo ${sum}
}

r() { # TODO: Try bash regex for speed
    local line="$1" k n total
    local inner=($(echo "$line"| grep -o  "([^()]*)"))
    while [[ "${#inner[@]}" != 0 ]]; do
        for k in "${inner[@]}"; do
            n=$(c "$k")
            line="${line/$k/$n}"
        done
        line=$(r "$line")
        inner=($(echo "$line"| grep -o  "([^()]*)"))
    done
    total=$(c "$line")
    echo $total
}
B=()
for i in "${A[@]}"; do
    B+=($(r "$i"))
done
sum=$(echo ${B[*]} | tr ' ' '+')
echo "18A: $((sum))"
sum=""
for i in "${A[@]}"; do
    k="(${i//\*/)*(})"
    sum+="+$((k))"
done
IFS='+'
echo "18B: $(($sum))"
