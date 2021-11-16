#!/usr/bin/env bash
IFS=$'\n' A=($(< "${1:-7.txt}"))
declare -A L
for K in "${!A[@]}"; do
    IFS=$' \n' I=(${A[K]})
    [[ ${#I[@]} == 0 ]] && continue
    case "${I[*]}" in
        *AND*)    L["${I[-1]}"]="${I[0]} & ${I[2]}";;
        *OR*)     L["${I[-1]}"]="${I[0]} | ${I[2]}";;
        *LSHIFT*) L["${I[-1]}"]="${I[0]} << ${I[2]}";;
        *RSHIFT*) L["${I[-1]}"]="${I[0]} >> ${I[2]}";;
        NOT*)     L["${I[-1]}"]="0xFFFF&~ ${I[1]}";;
        *)        L["${I[-1]}"]="${I[0]}";;
    esac
    unset "${I[-1]}" # No lower case variables can be defined
done

defined() {
    for I in "$@"; do
        case $I in
            [a-z]*) [[ -v "$I" ]] || return 1;;
        esac
    done
}

find_a(){
    # shellcheck disable=SC2154,SC2086
    until [[ -v 'a' ]]; do
        for K in "${!L[@]}"; do
            if defined ${L[$K]}; then
                printf -v "$K" "%d" $((${L[$K]}))
                #echo "$K is '${L[$K]}'==$((${L[$K]}))"
                unset "L[$K]"
            fi
        done
        #echo "$((++round)): ${#L[@]}: $a"
    done
    echo "$a"
}

ANS=$(find_a)
echo "7A: $ANS"

L["b"]=$ANS
printf "7B: "; find_a
