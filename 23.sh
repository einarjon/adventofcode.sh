#! /usr/bin/env bash
A=$(<"${1:-23.txt}")
i=0
for _ in {0..99}; do
    c=${A:i:1}
    out=${A:i+1:3}
    A2=${A/$out}
    [ ${#out} -lt 3 ] && A2=${A2:3-${#out}} && out+=${A:0:3-${#out}}
    d=${A:i:1}; ((--d)) || d=9; while [ "${out/$d}" != "${out}" ]; do ((--d)) || d=9; done
    A=${A2/$d/$d${out}}
    #echo $A : $c : $A2-$d:$out
    while [ "${A:i:1}" != "$c" ]; do ((++i==9)) && i=0; done
    ((++i==9)) && i=0
done
echo "23A: ${A/*1}${A/1*}"
A=$(<"${1:-23.txt}") a=0 b=0 c=0
#A=389125467
if [[ -n ${2:-$PUREBASH} ]]; then
getC() {
    local -n x_=$1 Cy=$2
    # shellcheck disable=SC2034
    x_=$Cy
}
swap() {
    declare -n Cc=$1 Cd=$2 Ccup=$3
    Ccup=$Cc; tmp=$Cd; Cd=$a; Cc=$tmp; cup=$Ccup
}
    trap 'echo "Giving up (i=$i, $SECONDS seconds)"; exit 1' TERM INT
    echo "Part 2 could take 15-20 minutes. Ctrl-C or 'kill $$' to stop."
    N=10000000 max=1000000
    B=($(grep -o "[1-9]" <<< "$A"))
    cup=${B[0]}
    j=0; for i in {1..1000000}; do printf -v "C$((j>>8))[j&255]" "%s" "$i"; j=$i; done
    last=$cup; for i in "${B[@]:1}"; do C0[last]=$i; last=$i;  done
    printf -v "C$((max>>8))[max&255]" "%s" "$cup"
    echo "Ready $SECONDS second $cup"
    i=0
    for N in {500000..10000000..500000}; do
        for (( ; i < N; ++i)); do
            getC a "C$((cup>>8))[cup&255]"; getC b "C$((a>>8))[a&255]"; getC c "C$((b>>8))[b&255]"
            ((d=cup-1)) || d=$max
            while ((d == a || d == b || d == c)); do
                ((--d)) || d=$max
            done
            swap "C$((c>>8))[c&255]" "C$((d>>8))[d&255]" "C$((cup>>8))[cup&255]"
        done
        echo "$i took $SECONDS seconds: cup=$cup"
    done
    a=${C0[1]}; getC b "C$((a>>8))[a&255]"
    echo "23B: $a * $b = $((a*b))"
else
    grep -o "[1-9]" <<< "$A" | awk '
    { if(last){ C[last]=$0 }else{ cup=$0 }; last=$0; ++i; }
    END {
        N=10000000;
        max=1000000;
        C[last]=++i;
        while (i<max) {C[i-1]=++i}
        C[max]=cup;
        for (i=0; i<N; i++) {
            #if (i%500000 ==0) {print i, "cup=", cup }
            a=C[cup]; b=C[a]; c=C[b];
            d=cup; if (--d<=0) { d=max }
            while (d == a || d == b || d == c) {
                if (--d<=0) { d=max }
            }
            C[cup]=C[c]; tmp=C[d]; C[d]=a; C[c]=tmp;
            cup=C[cup];
        }
        printf "23B(awk): %d*%d = %d\n", C[1] , C[C[1]], C[1]*C[C[1]]
    }'
fi
