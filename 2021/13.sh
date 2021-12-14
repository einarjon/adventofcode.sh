#!/usr/bin/env bash
# Oneliner for part 1. First fold hardcoded.
#echo "13A: $(while read x y; do ((x >655)) && x=$((2*655-x)); echo $x,$y; done < <(grep , 13.txt| tr , ' ') | sort -u | wc -l)"

fold_x() {
    local n=$1 C=(${DOTS[@]}) i
    for i in "${!C[@]}"; do
        x=${C[i]//,*}
        ((x>n)) && C[i]=$(((2*n-x))),${C[i]/*,}
    done
    DOTS=($(printf "%s\n" "${C[@]}"| sort -n | uniq))
}
fold_y() {
    local n=$1 C=(${DOTS[@]}) i
    for i in "${!C[@]}"; do
        y=${C[i]//*,}
        ((y>n)) && C[i]=${C[i]/,*},$(((2*n-y)))
    done
    DOTS=($(printf "%s\n" "${C[@]}"| sort -n | uniq))
}

DOTS=($(grep , "${1:-13.txt}"))
FOLDS=($(grep -o '.=.*' "${1:-13.txt}"))
fold_"${FOLDS[0]/=*}" "${FOLDS[0]:2}"
echo "13A: ${#DOTS[@]}"
for line in "${FOLDS[@]:1}"; do
    xy=${line/=*}
    "fold_$xy" "${line:2}"
done
TEXT=() spaces="           "
for i in "${!DOTS[@]}"; do
    x=${DOTS[i]//,*} y=${DOTS[i]//*,} len=${#TEXT[y]}
    TEXT[y]+="${spaces:0:x-len}#"
done
echo "13B:"
printf "%s\n" "${TEXT[@]}"
