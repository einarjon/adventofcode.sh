#! /usr/bin/env bash
IFS=$'\n'
input=${1:-19.txt}
A=($(grep : "$input"))
for i in "${A[@]}"; do
    n=${i/:*}
    RULE[n]="${i/*: }"
    RULE[n]="${RULE[n]//\"}"
done

IFS=$' \n'
REGEX=() regex=""
# shellcheck disable=SC2034,SC2048
r(){
    local -n rx=$1; local x="" i
    for i in ${*:2}; do
        if [ -z "${i/[ab|]}" ]; then
            x+=$i
        else
            [[ -z "${REGEX[i]}" ]] && r "REGEX[$i]" "${RULE[i]}"
            x+=${REGEX[i]}
        fi
    done
    [[ ${x} == *\|* ]] && x="($x)" # Only brackets if needed
    rx=$x
}
r regex 0
printf "19A: "; grep -E -c "^${regex}$" "$input"

#RULE[8]="42 8"
#RULE[11]="42 31 | 42 11 31"
REGEX[8]="(${REGEX[42]}{1,5})"
REGEX[11]="${REGEX[42]}${REGEX[31]}"
for n in {2..5}; do REGEX[11]+="|${REGEX[42]}{$n}${REGEX[31]}{$n}"; done
REGEX[11]="(${REGEX[11]})"
REGEX[0]="" regex=""
r regex 0
printf "19B: "; grep -E -c "^${regex}$" "$input"
