#!/usr/bin/env bash
A=($(tr "#" "X" < "${1:-18.txt}"))
B=(.${A//?/.}.); for i in "${A[@]}"; do B+=(.$i.); done; B+=(${B[0]}); D=("${B[@]}")
J=$(seq 1 ${#A}); I=$(seq 1 ${#A[@]})
solve() {
    local C=("${B[@]}") l=
    for _ in {1..100}; do
        for i in $I; do
            for j in $J; do
                x=${B[i]:$j:1}
                if [[ $x == x ]]; then l+=x; continue; fi # corner in p2
                s=${B[i-1]:j-1:3}${B[i]:j-1:3}${B[i+1]:j-1:3}
                s=${s//.}
                if [[ ${s} == ??? ]]; then x=X;
                elif [[ ${s} != ???? ]]; then x=.; fi
                l+=$x
            done
            C[i]=.$l.; l=
        done
        B=("${C[@]}")
        #((round%10)) || echo "$round: $SECONDS"
    done
    ans="${B[*]}"; ans=${ans//[ .]}
}
solve
echo "18A: ${#ans}"
B=("${D[@]}");
B[1]=".x${B[1]:2: -2}x." # corners always on
B[-2]=".x${B[-2]:2: -2}x."
solve
echo "18B: ${#ans}"
