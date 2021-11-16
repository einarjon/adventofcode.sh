#!/usr/bin/env bash
input=${1:-12.txt}
ans=$(($(grep -oE "[-]?[0-9]+" "$input" |sed s/^/+/)))
#echo $[`tr -sc 0-9- +<f`0] # bash golfing - 26 chars
echo "12A: $ans"

A=$(tr '[]' _ < "$input")  # stupid globbing
regex="(\{[^\{\}]*\})"
red=':"red"'
while [[ $A =~ $regex ]]; do
    n=0 match=${BASH_REMATCH[1]}
    if ! [[ $match == *$red* ]]; then
        x=(${match//[^-0-9]/ }); y=${x[*]}; n=$((${y// /+}))
    fi
    A=${A/$match/$n}
done
echo "12B: $A"
