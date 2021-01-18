#! /usr/bin/env bash
A=($(sort -n "${1:-10.txt}"))
DIFF=(0 0 0 1) # add 3 for the built-in
j=0; for i in "${A[@]}"; do ((DIFF[i-j]+=1)); j=$i; done
echo "10A: ${DIFF[1]}*${DIFF[3]}=$((DIFF[1]*DIFF[3]))"
B=; j=0; for i in "${A[@]}"; do B+=$((i-j)); j=$i; done; B+=3;
C=(${B//3/ }) # only works because there are nothing but 1s and 3s
D=(0 1 2 4 7)
total=1; for i in "${C[@]}"; do total+="*${D[${#i}]}"; done
echo "10B: ${total:2} = $((total))"
