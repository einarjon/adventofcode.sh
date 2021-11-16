#!/usr/bin/env bash
A=($(tr -dc '0-9 ' < "${1:-25.txt}"))

if [[ -n ${2:-$PUREBASH} ]]; then
    # 1+2+3+...N = N*(N+1)/2
    ROW=${A[0]}; COL=${A[1]}
    declare -i code=20151125 i=$(((COL+ROW)*(COL+ROW-1)/2-ROW))
    while ((i--)); do ((code=(code * 252533) % 33554393 )); done
    echo "25A: $code"
else
    echo "${A[@]}" | awk '{
        ROW=$1; COL=$2; code=20151125
        i=(COL+ROW)*(COL+ROW-1)/2-ROW
        while ( i-- ) { code=(code * 252533) % 33554393 }
        print "25A(awk):", code
    }'
fi
