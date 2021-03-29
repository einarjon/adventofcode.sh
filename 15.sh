#! /usr/bin/env bash
A=($(<"${1:-15.txt}"))
PUREBASH=${2:-$PUREBASH}
declare -a B=()
i=0; l=""
for a in "${A[@]}"; do B[a]=$((++i)); done
while [ $i -lt 2020 ]; do
    n=$((i-${l:-$i})); l=${B[n]}; B[n]=$((++i))
done
echo "15A: $n"

# eval is slow, but large arrays are slower
# Split the higher numbers into smaller arrays
sharded_swap() { # syntax: l=B[$1]; B[$1]=$2
    local x="B$(($1>>8))[$(($1&255))]"
    #local x="B$(($1>>6))[$1&63]"
    eval "l=\${$x}; $x=$2"
}

if [ -n "$PUREBASH" ]; then
    trap 'echo "Giving up (i=$i, $SECONDS seconds)"; exit 1' TERM INT
    echo "This could take 15-20 minutes. Ctrl-C or 'kill $$' to stop."
    declare -a B{1..1000}
    for N in $(seq 1000000 1000000 30000000 ); do
        while ((i < N)); do
            n=$((i-${l:-$i}));
            if (( n < 2048 )); then
                l=${B[n]}; B[n]=$((++i))
            else
                sharded_swap $n $((++i))
            fi
        done
        echo "$i took $SECONDS seconds" ;
    done
    echo "15B: $n"
else
    printf "%s\n" "${A[@]}" | awk '{B[$0]=++i;}
    END {
        while (i<30000000) { n=l?(i-l):0; l=B[n]; B[n]=++i; }
        print "15B(awk):", n;
    }'
fi
