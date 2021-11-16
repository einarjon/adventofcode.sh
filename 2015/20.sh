#! /usr/bin/env bash
A=$(< "${1:-20.txt}")

solve20A() {
    local -i i j=$1 max=1000
    n=$((1+j))
    for ((i=2;i<max;i++)); do
        if ((j%i == 0)); then
            max=$((j/i))
            ((n+=max+i))
        fi
        (( i == 20 && n < j*3 )) && break # skip unliklies
    done
    ((i > max)) && ((n-= max)) # square
}

solve20B() {
    local -i i j=$1
    n=$j
    for ((i=2;i<=50;i++)); do
        ((j%i == 0)) && ((n+=j/i))
        (( i == 20 && n < j*3 )) && break # skip unliklies
    done
}

solve() {
    local part=$1; shift
    for s in "$@"; do
        for ((k=k+s;k<1000000;k+=s)); do
            "solve20$part" "$k"
            #((k%10000 == 0)) && echo "$k%$s: $SECONDS: $n - $((A/n))"
            (( n*STEP["$s"] >= A )) && break
        done
        #echo "$k%$s: $SECONDS: $n - $A/$n*${STEP[$s]}"
    done
}

# Zoom in a bit - totally arbitrary numbers
# The [10000]=13 may miss the lowest house number, but it's fast on my input
declare -A STEP=([100000]=20 [10000]=13 [5000]=14 [1]=10)
declare -i k=0 n
solve A 100000 10000 1
echo "20A: $k"
STEP[1]=11
solve B 5000 1
echo "20B: $k"
