#! /usr/bin/env bash
A=($(< "${1:-1.txt}")); a=${A[0]}; ANS=0
for b in "${A[@]:1}"; do ((b>a && ++ANS)); a=$b; done
echo "1A: ${ANS}"
a=$((A[0]+A[1]+A[2])); b=$a; idx=(${!A[@]}); ANS2=0
for i in "${idx[@]:3}"; do ((b+=A[i]-A[i-3], b>a && ++ANS2)); a=$b; done
echo "1B: ${ANS2}"
