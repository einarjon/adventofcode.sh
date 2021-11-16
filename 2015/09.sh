#!/usr/bin/env bash
declare -A D Name
max=0
while read -r  a _ b _ c; do
    Name[$a]=1 Name[$b]=1
    D[$a$b]=$c D[$b$a]=$c
    ((max < c)) && max=$c
done < "${1:-9.txt}"

max3=$((3*max))
MIN=999999
MAX=0
places=(${!Name[@]})
idx=(${!places[@]})
N=${#places[@]}
#echo ${places[@]}  ${#places[@]}
r() {
    local dist=$1 max=$2 min=$3 remaining=("${idx[@]}") curr n k
    shift 3
    if (( $# > 1 )); then
        curr=${D[${places[$1]}${places[$2]}]}
        ((dist+=curr))
        ((min>curr)) && min=$curr
        ((max<curr)) && max=$curr
    fi
    if (( $# == N )); then
        n=${*:N}
        ((++round))
        # close the circle
        curr=${D[${places[$1]}${places[n]}]}
        ((dist+=curr))
        ((min>curr)) && min=$curr
        ((max<curr)) && max=$curr
        if ((dist-max < MIN)); then
            MIN=($((dist-max)) "$@")
        fi
        if ((dist-min > MAX)); then
            MAX=($((dist-min)) "$@")
        fi
    else
        ((dist >= MIN && ($# >= N-3 && dist+max3 < MAX))) && return
        for k in "$@"; do unset "remaining[k]"; done
        for k in "${remaining[@]}"; do
            r "$dist" "$max" "$min" "$k" "$@"
        done
    fi
}

r 0 0 9999 0

echo "9A: ${MIN[0]}"
echo "9B: ${MAX[0]}"
