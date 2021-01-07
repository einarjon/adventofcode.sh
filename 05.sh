#! /usr/bin/env bash
A=($(cat ${1:-5.txt} | tr 'FBLR' '0101' | sort -nr))
echo "5A: $((2#$A))"
j=; for i in ${A[@]}; do [[ ${j: -1} == ${i: -1} ]] && echo "5B: $((2#$j-1))=$((2#$i+1))"; j=$i; done
