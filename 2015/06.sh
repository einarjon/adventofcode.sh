#!/usr/bin/env bash
input=${1:-6.txt}
idx=({0..999})
printf -v one  '%.s1' "${idx[@]}"
printf -v zero '%.s0' "${idx[@]}"
AA=($(printf "%.s$zero\n" "${idx[@]}"))
IFS=$' ,\n'
while read -r action x y _ X Y; do
    case $action in
        on) for i in "${idx[@]:y:Y-y+1}"; do
            AA[i]=${AA[i]:0:x}${one:x:X-x+1}${AA[i]:X+1}; done;;
        off) for i in "${idx[@]:y:Y-y+1}"; do
            AA[i]=${AA[i]:0:x}${zero:x:X-x+1}${AA[i]:X+1}; done;;
        toggle) for i in "${idx[@]:y:Y-y+1}"; do # swap using "t" as tmp
            T=${AA[i]:x:X-x+1};T=${T//0/t}; T=${T//1/0}; T=${T//t/1};
            AA[i]=${AA[i]:0:x}${T}${AA[i]:X+1}; done;;
    esac
done < <(sed "s/turn.//" "$input")
IFS='' ANS=${AA[*]//0}
echo "6A: ${#ANS}"

if [[ -n ${2:-$PUREBASH} ]]; then
    IFS=$' ,\n'
    AA=($(printf "%.s$zero\n" "${idx[@]}"))
    while read -r action x y _ X Y; do
        case $action in
            on) for i in "${idx[@]:$y:$Y-y+1}"; do  # shift up by 1. '?' means overflow
                AA[i]=${AA[i]:0:x}$(tr '0-9a-zA-Z' '1-9a-zA-Z?' <<< "${AA[i]:x:X-x+1}")${AA[i]:X+1}; done;;
            off) for i in "${idx[@]:y:Y-y+1}"; do  # shift down by 1
                AA[i]=${AA[i]:0:x}$(tr '1-9a-zA-Z' '0-9a-zA-Y' <<< "${AA[i]:x:X-x+1}")${AA[i]:X+1}; done;;
            toggle)  for i in "${idx[@]:y:Y-y+1}"; do  # shift up by 2
                AA[i]=${AA[i]:0:x}$(tr '0-9a-zA-Z' '2-9a-zA-Z??' <<< "${AA[i]:x:X-x+1}")${AA[i]:X+1}; done;;
        esac
    done < <(sed "s/turn.//" "$input")
    #ANS=$(printf "%s" "${AA[@]//0}" | grep -o . | sort | uniq -c | sed "s/^ */+/;s/ /*/")
    ANS=$(printf "%s" "${AA[@]//0}" | sed "s/./+&/g" )
    XX=({0..9} {a..z} {A..Z})
    # convert a-z and A-Z to variables so that $((ANS)) converts a=10, z=35, A=36, etc
    for ii in "${idx[@]:10:52}"; do printf -v "${XX[ii]}" "%s" "$ii"; done
    echo "6B: $((ANS))"
else
    sed "s/turn.on/1/;s/turn.off/-1/;s/toggle/2/" "$input" | awk -F"[, ]" ' {
        for(y=$3;y<=$6;y++){ for(x=$2;x<=$5;x++){ if($1>0||A[y][x]>0){ A[y][x]+=$1 }}}
    }
    END {
        sum=0; for(y=0;y<=999;y++){ for(x=0;x<=999;x++) { sum+=A[y][x] }}
        print "6B(awk):", sum
    }
    '
fi
