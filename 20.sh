#! /usr/bin/env bash
IFS=$'\n'
A=($(tr '.' '_' < "${1:-20.txt}")) # . is a wildcard
IFS=$' \t\n'
NUM=($(printf "%s\n" "${A[@]}" | grep -o "[0-9]*" ))
ENDS=() N=${#NUM[@]} n=${#A[1]}; A90=() # rotated 90deg counterclockwise
for ((i=n;i>0;i--));do A90+=($(printf "%s\n" "${A[@]}" | cut -c$i | tr -d '\n')); done
U=($(printf "%s\n" "${A[@]}" | grep -A1 Tile | grep -E "[_#]" ))
D=($(printf "%s\n" "${A[@]}" Tile | grep -B1 Tile | grep -E "[_#]" ))
L=(${A90[-1]//[^_#]/ })
R=(${A90[0]//[^_#]/ })
Ur=($(printf "%s\n" "${U[@]}" | rev))
Dr=($(printf "%s\n" "${D[@]}" | rev))
Lr=($(printf "%s\n" "${L[@]}" | rev))
Rr=($(printf "%s\n" "${R[@]}" | rev))
printf -v ALL "%s\n" "${U[@]}" "${R[@]}" "${Dr[@]}" "${Lr[@]}" "${Ur[@]}" "${Rr[@]}" "${D[@]}" "${L[@]}"
for i in "${!U[@]}"; do
    x=($(echo "$ALL" | grep -n -E -x "(${U[i]}|${R[i]}|${Dr[i]}|${Lr[i]})" | cut -d: -f1 | \
        while read k; do (( --k >= 4*N || (k%N)!=i )) && echo "$((k/N)):$((k%N))"; done))
    case ${#x[*]} in
        2) ENDS[i]="${NUM[i]}"; CORNERS[i]="${x[*]}";;
        3) SIDES[i]="${x[*]}";;
        4) MIDDLE[i]="${x[*]}";;
        *) echo "ERROR($i): ${x[*]}"; break;;
    esac
done
printf -v sum "*%s" "${ENDS[@]}"; sum=${sum:1}
echo "20A: $sum=$((sum))"

all="${A[*]}"; all=${all//[^#]}; echo total=${#all}
edges=$(for i in "${!U[@]}"; do
    printf "%s" "${U[i]:1}" "${Dr[i]:1}" "${L[i]:1}" "${Rr[i]:1}"
done |  tr -cd '#' | wc -c)
monster=\
"..................#.
#....##....##....###
.#..#..#..#..#..#..."
monsterlen=${monster//[^\#]}; monsterlen=${#monsterlen}
regex=${monster/................../[.\#]\{18\}} # no newline at start
regex=${regex//$'\n'/.\{76\}}                   # newline can be anywhere
