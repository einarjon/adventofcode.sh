#!/usr/bin/env bash
IFS=$'\n'
A=($(< "${1:-21.txt}"))
WRINGS=(0 25 50 100)
ARINGS=(0 20 40 80)
ARMOR=(0 13 31 53 75 102 1000 1000 1000)
WEAPON=(1000 1000 1000 1000 8 10 25 40 74 1000 1000 1000)
ARMOR2=(0 13 31 53 75 102)
WEAPON2=(-99 -99 -99 -99 8 10 25 40 74 -99 -99 -99)
MIN=9999 MAX=0
H2=${A[0]/*: }
d2=${A[1]/*: }
a2=${A[2]/*: }

for d in {4..11}; do
  for a in {0..8}; do
    h1=100 h2=$H2
    while (( h1 > 0 && h2 > 0)); do
        ((h2-=(d-a2),h1-=(d2-a)))
    done
    if ((h2 <= 0)); then
        cost=999 cost2=999
        for i in {0..3}; do
            p=$((WEAPON[d-i]+WRINGS[i]))
            ((p<cost)) && cost=$p
        done
        for i in {0..3}; do
            ((a < i)) && break
            p=$((ARMOR[a-i]+ARINGS[i]))
            ((p<cost2)) && cost2=$p
        done
        #echo "$d Damage + $a Armor wins: $cost+$cost2 => $((cost+cost2))"
        TOTAL=$((cost+cost2))
        ((MIN>TOTAL)) && MIN=$TOTAL
        cost=0 cost2=0
        ((--a >= 0)) || break # find the loser
        for i in {0..3}; do
            p=$((WEAPON2[d-i]+WRINGS[i]))
            ((p>cost)) && cost=$p
        done
        for i in {0..3}; do
            ((a < i)) && break
            p=$((ARMOR2[a-i]+ARINGS[i]))
            ((p>cost2)) && cost2=$p
        done
        TOTAL=$((cost+cost2))
        #echo "$d Damage + $a Armor loses: $cost+$cost2 => $TOTAL"
        ((MAX<TOTAL)) && MAX=$TOTAL
        break
    fi
  done
done
echo "21A: $MIN"
echo "21A: $MAX"
