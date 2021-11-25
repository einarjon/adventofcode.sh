#! /usr/bin/env bash
IFS=$'\n'
set -o noglob
A=($(< "${1:-18.txt}"))
c() {
    local i sum=0 op='+'
    # shellcheck disable=SC2048
    for i in $*; do
        if [[ $i == [+*] ]]; then
            op=$i
        else
            ((sum$op=i))
        fi
    done
    #echo "c: ${*//[()]} = $sum " >&2
    echo ${sum}
}

IFS=$' \t\n'
regex="\(([^()]*)\)"
sum=""
for line in "${A[@]}"; do
    while [[ "$line" =~ $regex ]]; do
        n=$(c "${BASH_REMATCH[1]}")
        line="${line/${BASH_REMATCH[0]//\*/\\*}/$n}" # stupid globbing
    done
    sum+=+$(c "$line")
done
echo "18A: $((sum))"
echo "18B: $(($(printf "+(%s)" "${A[@]//\*/)*(}")))"
