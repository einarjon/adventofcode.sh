#! /usr/bin/env bash
ans=0 ans2=0
IFS=$' -:\n'
while read -r m M b c; do
    x=${c//[^$b]}; y=${c:m-1:1}; z=${c:M-1:1};
    (( ${#x} >= m && ${#x} <= M && ++ans ))
    [[ $y != "$z" ]] && [[ $b == "$y" || $b == "$z" ]] && ((++ans2))
done < "${1:-2.txt}"
echo "2A: $ans"
echo "2B: $ans2"
