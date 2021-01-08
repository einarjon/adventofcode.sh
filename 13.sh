#! /usr/bin/env bash
IFS=$',\n'
input=${1:-13.txt}
A=($(sed s/x,//g $input))
time=$A; min=($A 0)
for i in "${A[@]:1}"; do
    w=$((i-time%i))
    [ $w -lt $min ] && min=($w $i)
done
echo "13A: $min*${min[1]} = $((min*${min[1]}))"

A=($(tail -1 $input))
for i in ${!A[@]}; do [ ${A[i]} != x ] && B[$i]=${A[i]} ; done
N=0; step=1
#echo "${!B[@]} => "${B[@]}""
for i in "${!B[@]}"; do
    while [ $(( (N+i) % ${B[$i]})) != 0 ]; do N=$((N+step)); done
    step=$((step*${B[$i]}))
done
echo "13B: $N"
