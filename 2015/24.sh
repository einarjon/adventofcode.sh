#!/usr/bin/env bash
#echo   1 89 101 107 109 113 | tr ' ' '*' | bc
#echo   61 107 109 113 | tr ' ' '*' | bc

A=($(sort -nr "${1:-24.txt}"))
printf -v sum "+%s" "${A[@]}"
idx=(${!A[@]})

r(){
    local i=$1 k sum
    shift
    ((n++))
    (($# > LEGROOM)) && return  # too many
    printf -v sum "+%s" "${@}"
    if (( sum == TOTAL )); then
        ((LEGROOM > $#)) && MATCHES=() LEGROOM=$#
        printf -v mul "%s*" "$@"; mul+=1
        #echo $LEGROOM: $* : $((mul))
        MATCHES+=($((mul)))
    elif ((sum < TOTAL && ${#MATCHES[@]} < 4)); then
        for k in "${idx[@]:i+1}"; do
            r "$k" "$@" "${A[k]}"
        done
    fi
}

TOTAL=$(((sum)/3)) LEGROOM=10; MATCHES=()
r 0 "${A[0]}"
ans=${MATCHES[0]}; for i in "${MATCHES[@]:1}"; do ((ans > i)) && ans=$i; done
echo "24A: ${ans[0]}"

TOTAL=$(((sum)/4)) LEGROOM=10 MATCHES=()
r 0 "${A[0]}"
ans=${MATCHES[0]}; for i in "${MATCHES[@]:1}"; do ((ans > i)) && ans=$i; done
echo "24B: ${ans[0]}"
