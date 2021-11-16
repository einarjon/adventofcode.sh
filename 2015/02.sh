#!/usr/bin/env bash
swap(){
    declare -n x=$1 y=$2
    tmp=$x; x=$y; y=$tmp
}

A=($(<"${1:-2.txt}"))
for i in "${A[@]}"; do
    d=(${i//x/ })
    (( d[0] > d[1] )) && swap "d[0]" "d[1]"
    (( d[1] > d[2] )) && swap "d[1]" "d[2]"
    (( d[0] > d[1] )) && swap "d[0]" "d[1]"
    #d=($(sort -n <<< "${i//x/$'\n'}")) # 40x slower
    ((sumA+=3*d[0]*d[1]+2*d[1]*d[2]+2*d[0]*d[2]))
    ((sumB+=2*(d[0]+d[1])+d[0]*d[1]*d[2]))
done
echo "2A: $sumA"
echo "2B: $sumB"
