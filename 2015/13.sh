#!/usr/bin/env bash
declare -A H D Name
max=0
while read -r a _ w c _ _ _ _ _ _ b; do
    Name[$a]=1
    b=${b%.}
    [[ $w == lose ]] && c=-$c
    H[$a$b]=$c
    if [ -v "H[$b$a]" ]; then
        D[$a$b]=$((H[$b$a]+H[$a$b]))
        D[$b$a]=${D[$a$b]}
        ((max < D[$a$b] )) && max=${D[$a$b]}
    fi
done < "${1:-13.txt}"

max3=$((3*max))
MAX=0
places=(${!Name[@]})
idx=(${!places[@]})
N=${#places[@]}
#echo ${places[@]}  ${#places[@]}
r() {
    local dist=$1 min=$2 remaining=("${idx[@]}") curr n k
    shift 2
    if (( $# > 1 )); then
        curr=${D[${places[$1]}${places[$2]}]}
        ((dist+=curr))
        ((min>curr)) && min=$curr
    fi
    if (( $# == N )); then
        n=${*:N}
        ((++round))
        # close the circle
        curr=${D[${places[$1]}${places[n]}]}
        ((dist+=curr))
        ((min>curr)) && min=$curr
        if ((dist > MAX)); then
            MAX=($dist "$@")
        fi
        if ((dist-min > MAX2)); then
            MAX2=($((dist-min)) "$@")
        fi
    else
        (($# >= N-3 && dist+max3 < MAX)) && return # Unhappy setup
        for k in "$@"; do unset "remaining[k]"; done
        for k in "${remaining[@]}"; do
            r "$dist" "$min" "$k" "$@"
        done
    fi
}

r 0 9999 0
echo "13A: ${MAX[0]}"
echo "13B: ${MAX2[0]}"
