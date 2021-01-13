#! /usr/bin/env bash
A=($(<${1:-15.txt}))
GIVEUP=${2:-10}
#A=(0 3 6)
B=(); i=0; l=""
for a in ${A[@]}; do B[a]=$((++i)); done
while [ $i -lt 2020 ]; do
    n=$((i-${l:-$i})); l=${B[n]}; B[n]=$((++i))
done
echo "15A: $n"

sharded_swap() { # syntax: l=B[$1]; B[$1]=$2
    local x="B$(($1>>9))[$1&511]"
    #local x="B$(($1>>6))[$1&63]"
    eval "l=\${$x}; $x=$2"
}
SECONDS=0
trap 'echo "$i: $SECONDS sec $((i/300000))%"' USR1 EXIT
i=0; for a in ${A[@]}; do sharded_swap $a $((++i)); done; l="";
while [[ $i -lt 30000000 && $SECONDS -le $GIVEUP ]]; do
    n=$((i-${l:-$i})); sharded_swap $n $((++i))
done
if [ $i = 30000000 ]; then
    echo "15B: $n"
else
    # The code above is painfully slow. Switch to awk
    echo "15B(round $i): $n (Gave up after $SECONDS seconds)"
    printf "%s\n" ${A[@]} | awk '{B[$0]=++i;}
END {
    while (i<30000000) { n=l?(i-l):0; l=B[n]; B[n]=++i; }
    print "15B(awk):", n;
}'
fi
