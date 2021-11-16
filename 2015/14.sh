#!/usr/bin/env bash
idx=({0..200})
declare -a NAMES SPEED TIME REST DIST LEN POINTS
while read -r name _ _ speed _  _ time _ _ _ _ _ _ rest _; do
    #echo $name $speed $time $rest
    NAMES+=($name)
    SPEED+=($speed)
    TIME+=($time)
    REST+=($rest)
    printf -v move "%.s$speed " "${idx[@]:1:time}"
    printf -v stop "%.s0 " "${idx[@]:1:rest}"
    eval "$name=($move $stop)"
    LEN+=($((time+rest)))
    DIST+=(0)
    POINTS+=(0)
done < "${1:-14.txt}"
end=2503
MAX=0
IDX=(${!NAMES[@]})
for i in "${IDX[@]}"; do
    rounds=$((end/LEN[i]))
    remainder=$((end%LEN[i]))
    ((remainder>TIME[i])) && remainder=${TIME[i]}
    dist=$((SPEED[i]*(TIME[i]*rounds+remainder)))
    ((MAX<dist)) && MAX=$dist
done
echo "14A: $MAX"

maxdist(){
    local -n name=$1
    local len=$2
    ((DIST[k]+=name[i%len]))
    if ((max < DIST[k])); then
        max=(${DIST[k]} $k)
    elif ((max == DIST[k])); then
        max+=($k)
    fi
}

max=(0) MAX=0
for i in {0..2502}; do
    for k in "${IDX[@]}"; do
        maxdist "${NAMES[k]}" "${LEN[k]}"
    done
    #echo $i: ${max[*]}
    for k in "${max[@]:1}"; do ((++POINTS[k])); done
    max=(${max[0]})
done
for i in "${POINTS[@]}"; do ((MAX < i)) && MAX=$i; done
echo "14B: $MAX"
