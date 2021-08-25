#! /usr/bin/env bash
A=($(sed -e "s/\([ew]\)\([ew]*\)/\1\2\2/g;s/^\([ew]\)/\1\1/" "${1:-24.txt}" ))
declare -A B
for i in "${A[@]}"; do
    s=${i//[^s]}
    n=${i//[^n]}
    e=${i//[^e]}
    w=${i//[^w]}
    hash="$((${#e}-${#w})).$((${#n}-${#s}))"
    if [[ -n "${B[${hash}]}" ]]; then
        unset "B[${hash}]"
    else
        B[${hash}]=1
    fi
done
echo "24A: ${#B[@]}"

solve24() {
    local -A C=()
    for i in "${!B[@]}"; do
        x=${i/.*}
        y=${i/*.}
        C[$i]+=''
        C[$((x-1)).$((y-1))]+=1
        C[$((x+1)).$((y-1))]+=1
        C[$((x-2)).$y]+=1
        C[$((x+2)).$y]+=1
        C[$((x-1)).$((y+1))]+=1
        C[$((x+1)).$((y+1))]+=1
    done
    for i in "${!C[@]}"; do
        if [[ -n "${B[$i]}" ]]; then
            [[ ${#C[$i]} == [12] ]] || unset "B[$i]"
        else
            [[ ${#C[$i]} == 2 ]] && B[$i]=1
        fi
    done
}
for _ in {1..100}; do
    solve24
done
echo "24B: ${#B[@]}"
