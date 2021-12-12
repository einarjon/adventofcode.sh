#!/usr/bin/env bash
declare -A Next=()
IFS=$' -\n'
while read -r a b; do
    [[ $a != start ]] && Next[$b]+="$a "
    [[ $b != start ]] && Next[$a]+="$b "
done < "${1:-12.txt}"
#for i in "${!Next[@]}"; do echo "$i: '${Next[$i]}'"; done

r() {
    local route=$1 cur=$2 visited=$3 k deeper=false
    if [[ $cur == end ]]; then
        PATHS+=("$route:$cur")
    elif [[ $cur != "${cur,,}" || $route != *:${cur}:*
        || ($cur == "${cur,,}" && $((visited++)) == 0) ]]; then
        for k in ${Next[$cur]}; do
            r "$route:$cur" "$k" $visited
        done
    fi
}

PATHS=()
r "" start 1
echo "12A: ${#PATHS[@]}"
PATHS=()
r "" start 0
echo "12B: ${#PATHS[@]}"
