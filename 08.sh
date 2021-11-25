#! /usr/bin/env bash
IFS=$'\n'
A=($(< "${1:-8.txt}"))
B=("${A[@]}")
solve8() {
    acc=0; i=0;
    while true; do
        x=${A[i]}; y=${x/* }; A[i]+=DONE
        case "$x" in
            *DONE) return 1;;
            acc*) ((acc+=y,++i));;
            jmp*) ((i+=y));;
            nop*) ((++i));;
            *) echo "ERROR $i: $x"; return 1;;
        esac
        [[ $i -ge ${#A[@]} ]] && return 0
    done
}
solve8 || echo "8A: $acc"

A=("${B[@]}");
for k in "${!A[@]}"; do
    if   [[ ${A[k]} = nop* ]]; then A[k]=jmp${A[k]:3};
    elif [[ ${A[k]} = jmp* ]]; then A[k]=nop${A[k]:3};
    else continue; fi
    solve8 && break
    A=("${B[@]}")
done
[[ $i -ge ${#A[@]} ]] && echo "8B: $acc"
