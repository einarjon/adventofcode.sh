#!/usr/bin/env bash
IFS=$'\n' A=($(tr -dc '0-9- \n' < "${1:-15.txt}"))
IFS=$' \t\n' a=(${A[0]}) b=(${A[1]}) c=(${A[2]}) d=(${A[3]})
idx=({0..99}) N=100 MAX=0 MAX2=0 CAL=500
for i in "${idx[@]:1:90}"; do
    for j in "${idx[@]:1:90-i}"; do
        for k in "${idx[@]:1:90-i-j}"; do
            l=$((N-i-j-k))
            s0=$((a[0]*i+b[0]*j+c[0]*k+d[0]*l))
            (( s0 <= 0)) && break
            s1=$((a[1]*i+b[1]*j+c[1]*k+d[1]*l))
            (( s1 <= 0)) && break
            s2=$((a[2]*i+b[2]*j+c[2]*k+d[2]*l))
            s3=$((a[3]*i+b[3]*j+c[3]*k+d[3]*l))
            cal=$((a[4]*i+b[4]*j+c[4]*k+d[4]*l))
            score=$((s0 * s1 * s2 * s3))
            ((MAX < score)) && MAX=($score $i $j $k $l)
            ((cal==CAL && MAX2 < score)) && MAX2=($score $i $j $k $l)
            ((++scored))
        done
    done
done
echo "15A: ${MAX[0]}"
echo "15B: ${MAX2[0]}"
