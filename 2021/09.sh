#!/usr/bin/env bash
A=($(< "${1:-9.txt}"))
B=(9${A//?/9}9); for i in "${A[@]}"; do B+=(9${i}9); done; B+=(${B[0]}); C=("${B[@]}");
n=${#A} N=${#A[@]}
declare -A LOWS
for ((y=1; y<=N; ++y)); do
    for ((x=1; x<=n; ++x)); do
        while (( ${B[y]:x:1} > ${B[y]:x+1:1} )); do ((++x)); done
        low=${B[y]:x:1}
        if (( low < ${B[y]:x-1:1} && low < ${B[y]:x+1:1}
           && low < ${B[y-1]:x:1} && low < ${B[y+1]:x:1})); then
            LOWS[$y,$x]=$low
        fi
    done
done
printf -v sum "+%s" "${LOWS[@]}"
echo "9A: $((sum + ${#LOWS[@]}))"

C=(${C[@]//[0-8]/-}) c=0
F=({a..z} {A..Z} {0..8} + _ / "=")
idx=($(printf "%s\n" "${!LOWS[@]}" | sort -n))
for i in "${idx[@]}"; do
    LOWS[$i]=${F[c]}
    x=${i/*,} y=${i/,*}
    C[y]=${C[y]:0:x}${F[c]}${C[y]:x+1}
    for k in 1 -1; do
        j=$k
        while [[ ${C[y+j]:x:1} != 9 ]]; do
            C[y+j]=${C[y+j]:0:x}${F[c]}${C[y+j]:x+1}
            ((j+=k));
        done
    done
    (( ++c >= ${#F[@]} && ++d)) && c=0
done
# Terrible "grow"
for i in {1..6}; do
   C=($(printf "%s\n" "${C[@]}" | sed -e "s/-\([^9-]\)/\1\1/g;s/\([^9-]\)-/\1\1/g"))
done
while [[ "${C[*]}" == *-* ]]; do
    #echo "round $((++round))"
    for y in "${!C[@]}"; do
        [[ ${C[y]} != *-* ]] && continue
        minus=($(sed "s/./&\n/g" <<< "${C[y]:1}" | grep -n '-'))
        for x in "${minus[@]//:*}"; do
            for j in 1 -1; do
                k=$j
                while [[ ${C[y+k]:x:1} == - ]]; do ((k+=j)); done
                p=${C[y+k]:x:1}
                if [[ $p != 9 ]]; then
                    while ((k+=-j)); do C[y+k]=${C[y+k]:0:x}$p${C[y+k]:x+1}; done
                    C[y]=${C[y]:0:x}$p${C[y]:x+1}
                    break
                fi
            done
        done
    done
    for i in {1..2}; do
        C=($(printf "%s\n" "${C[@]}" | sed -e "s/-\([^9-]\)/\1\1/g;s/\([^9-]\)-/\1\1/g"))
    done
done

AREA=()
for i in "${F[@]}"; do
    while read -r A;do
        AREA+=(${#A}:$A)
    done < <(printf "%s\n" "${C[@]}" | grep -a1 "$i" | tr -cd "$i-" | tr -s '-' '\n')
done
BIG=($(printf "%s\n" "${AREA[@]//:*}" | sort -nr))
echo "9B: $((BIG[0]*BIG[1]*BIG[2]))"
