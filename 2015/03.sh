#!/usr/bin/env bash
A=$(<"${1:-3.txt}")
solve() {
    local -A X=([x0y0]=1)
    local x=(0 0) y=(0 0) n=0 N=$1
    while read -r -n1 i; do
        ((n=(n+1)&N))
        case "$i" in
            ">") ((++x[n]));;
            "<") ((--x[n]));;
            "^") ((++y[n]));;
            "v") ((--y[n]));;
        esac
        X[x${x[n]}y${y[n]}]+=1;
    done <<< "$A"
    ANS=${#X[@]}
}
solve 0
echo "3A: $ANS"
solve 1
echo "3B: $ANS"
