#!/usr/bin/env bash
declare -A Next=() BIG=()
IFS=$' -\n'
while read -r a b; do
    [[ $a != start ]] && Next[$b]+="$a "
    [[ $b != start ]] && Next[$a]+="$b "
done < "${1:-12.txt}"
for i in "${!Next[@]}"; do [[ -z ${i//[A-Z]} ]] && BIG[$i]=1; done
#for i in "${!Next[@]}"; do echo "$i: '${Next[$i]}'"; done

r() {
    local route=$1 cur=$2 visited=$3 k
    if [[ $cur == end ]]; then
        PATHS+=1
    elif [[ -n ${BIG[$cur]} || $route != *:${cur}:* ]] \
        || ((visited++ == 0)); then
        for k in ${Next[$cur]}; do
            r "$route:$cur" "$k" $visited
        done
    fi
}

declare -i PATHS=0
r "" start 1
echo "12A: ${PATHS}"
PATHS=0
r "" start 0
echo "12B: ${PATHS}"
