#!/usr/bin/env bash
IFS=$'\n' input="${1:-16.txt}"
declare -A AUNTS=(
["children:"]=3
["cats:"]=7
["samoyeds:"]=2
["pomeranians:"]=3
["akitas:"]=0
["vizslas:"]=0
["goldfish:"]=5
["trees:"]=3
["cars:"]=2
["perfumes:"]=1
)
morethan() { local -n aunt=$1; aunt="([$(($1+1))-9]|1[0-9])"; }
# shellcheck disable=SC2034
lessthan() { local -n aunt=$1; aunt="[0-$(($1-1))]"; }

solve() {
    local A=($(< "$input"))
    for i in "${!AUNTS[@]}"; do
    drop=($(grep -n "$i" "$input" | grep -E -v "$i ${AUNTS[$i]}"))
    for k in ${drop[*]/:*}; do unset "A[$k-1]"; done
    done
    sue=${A[*]/:*}
}
solve
echo "16A: ${sue/Sue }"

morethan 'AUNTS["cats:"]'
morethan 'AUNTS["trees:"]'
lessthan 'AUNTS["pomeranians:"]'
lessthan 'AUNTS["goldfish:"]'
solve
echo "16B: ${sue/Sue }"
