#! /usr/bin/env bash
A=($(< ${1:-25.txt}))
declare -i k e key1 key2
k=1 e=1 key1=$A key2=${A[1]}
while [ $k != $key1 ]; do
    k=$((k*7 % 20201227))
    e=$((e*key2 % 20201227))
done
echo "25A: $e"
echo ${A[@]} | awk '{
key1=$1; key2=$2; k=1; e=1;
while (k != key1) { k = k*7 % 20201227; e = e*key2 % 20201227 }
print "25A(awk):", e
}'
