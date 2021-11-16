#!/usr/bin/env bash
IFS=$'\n' A=($(< "${1:-23.txt}"))
declare -A reg
solve() {
    reg=(); reg["a"]=$1; reg["b"]=$2; local i=0 n=${#A[@]}
    while (( i < n )); do
        x=${A[i++]}; y=${x:4};
        case "$x" in
            jmp*) ((i+=y-1));;
            jio*) ((reg[${y/,*}]==1)) && ((i+=${y/*, }-1));;
            jie*) (((reg[${y/,*}]&1)==0)) && ((i+=${y/*, }-1));;
            inc*) ((++reg["$y"]));;
            hlf*) ((reg["$y"]/=2));;
            tpl*) ((reg["$y"]*=3));;
        esac
    done
}
solve 0 0
echo "23A: ${reg["b"]}"
solve 1 0
echo "23B: ${reg["b"]}"
