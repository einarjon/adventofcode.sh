#!/usr/bin/env bash
regex=''
printf -v abc %s {a..z}
A=(${abc//[iol]/ })
ABC=($(echo "${A[*]}" | grep -o .))
declare -A B=() C=()
for a in "${A[@]}"; do
    for ((i=0; i<${#a}-2;++i)); do
        regex+="|${a:i:3}"
        B[${a:i:1}]=${a:i:3}${a:i+2:1}
    done
done
for a in "${!ABC[@]}"; do C[${ABC[a]}]=${ABC[a+1]}; done
regex1="(${regex:1})"
regex2="([a-z])\1.*([a-z])\2"
verify(){
    echo "$1" | grep -E "$regex1" | grep -E "$regex2" | grep -v "$2"
}
next(){
    old=$1; len=${#old}
    new=${old:0:len-4}; n=${new: -1}
    until verify "$new${B[$n]}" "$old"; do
        n=${C[$n]}
        if [[ -z ${n} ]]; then
            n="a"; new=${new:0: -2}${C[${new: -2:1}]}$n
        else
            new=${new:0: -1}$n
        fi
    done
}
P=$(< "${1:-11.txt}")
P1=$(next "$P")
echo "11A: $P1"
P2=$(next "$P1")
echo "11B: $P2"
