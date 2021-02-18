#! /usr/bin/env bash
input=${1:-1.txt}
A=($(sort -n "$input"));
for a in "${A[@]}"; do grep -q -- ^$((2020-a))$ "$input" && break; done
echo "1A: $((2020-a)) + $a = $(((2020-a)*a))"
b=:; for a in "${A[@]}";do for i in "${A[@]}"; do grep -q -- ^$((2020-a-i))$ "$input" && b=break; $b; done; $b; done
echo "1B: $((2020-a-i)) + $a + $i = $(((2020-a-i)*a*i))"
