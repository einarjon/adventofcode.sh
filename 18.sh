#! /usr/bin/env bash
IFS=$'\n'
set -o noglob
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
    #echo "c: ${*//[()]} = $sum " >&2
    echo ${sum}
}

IFS=$' \t\n'
regex="\([^()]*\)"
sum=""
for line in "${A[@]}"; do
    while [[ "$line" =~ $regex ]]; do
        k=${BASH_REMATCH[0]}
        n=$(c "$k")
        line="${line/${k//\*/\\*}/$n}" # stupid globbing
    done
    sum+=+$(c "$line")
done
echo "18A: $((sum))"
echo "18B: $(($(printf "+(%s)" "${A[@]//\*/)*(}")))"
