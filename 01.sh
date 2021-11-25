#! /usr/bin/env bash
A=($(sort -n "${1:-1.txt}"))
for i in "${A[@]}"; do B[i]=1; done
for a in "${A[@]}"; do ((b=2020-a, B[b] > 0)) && break; done
echo "1A: $b + $a = $((b*a))"
for i in "${!A[@]}";do for b in "${A[@]:i+1}"; do
    ((a=A[i], c=2020-a-b, c > 0 && B[c] > 0)) && break 2;
done; done
echo "1B: $c + $a + $b = $((c*a*b))"
