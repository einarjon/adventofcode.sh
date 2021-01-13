#! /usr/bin/env bash
A=($(sed -e "s/\([ew]\)\([ew]*\)/\1\2\2/g;s/^\([ew]\)/\1\1/" ${1:-24.txt} ))
#A=($(< ${1:-24.txt}))
declare -A B
sum=0
for i in ${A[@]}; do
    s=${i//[^s]}
    n=${i//[^n]}
    e=${i//[^e]}
    w=${i//[^w]}
    idx="N$((${#n}-${#s}))E$((${#e}-${#w}))"
    B[${idx//-/_}]+=1
done
for i in ${B[*]}; do sum+="+${#i}%2"; done
echo "24A: $((sum))"
#echo "24B: ??"
