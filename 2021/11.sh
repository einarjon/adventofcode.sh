#!/usr/bin/env bash

A=($(sed -e 's/^/X/;s/./& /g'  "${1:-11.txt}"))
flashes=0 last=0 idx=(${!A[@]})
A+=(X X X X X X X X X X X X)
A=(${A[@]//X/-999999999})
flash(){
    local n=$1 j cur
    ((++flashes))
    # hardcoded neighbours. There's an X on one side, so Y-offset is cols+1
    for j in -12 -11 -10 -1 1 10 11 12; do
        cur=$((n+j))
        ((++A[cur] >= 10 && FLASHED[cur]++ == 0 )) && flash $cur
    done
}
round(){
    FLASHED=()
    for i in "${idx[@]}"; do ((++A[i] >= 10 && FLASHED[i]++ == 0)) && flash "$i"; done
    #A=(${A[@]//-99??/-9999})
    A=(${A[@]//1?/0})
}
for rounds in {1..100}; do
    round
done
echo "11A: $flashes"
while ((flashes-last != 100)); do
    ((last=flashes,rounds++))
    round
done
echo "11B: $rounds"
