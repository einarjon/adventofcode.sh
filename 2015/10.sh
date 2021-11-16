#!/usr/bin/env bash
A=$(< "${1:-10.txt}")
solve() {
    for ((; n < $1; ++n)); do
        local j=${A:0:1} k=0 C B=() l=0
        while read -r -n1 i; do
            if (( i == j )); then ((++k)); else B[++l>>10]+="$k$j"; j=$i; k=1; fi
        done < <( echo -n "$A")
        C="${B[*]}"
        A="${C// }$k$j"
        #echo "$n: $SECONDS: ${#A}"
    done
}
solve 40
echo "10A: ${#A}"
solve 50
echo "10B: ${#A}"
