#!/usr/bin/env bash
input=${1:-8.txt}
printf "8A: "
cut -d\| -f 2 "$input" | grep -Eo "[a-g]+" | grep -cE "^([a-g]{2,4}|[a-g]{7})$"
sum=""
while read -r -a A; do
    T4="" T7="" n=""
    for i in "${A[@]:0:10}"; do
        case ${#i} in # Just find 4 and 7, ignore the rest
            3) T7=$i; [[ -n $T4 ]] && break;;
            4) T4=$i; [[ -n $T7 ]] && break;;
        esac
    done
    for i in "${A[@]:11}"; do
        case ${#i},${i//[$T4]},${i//[$T7]} in
            2,*)      n+=1;;
            3,*)      n+=7;;
            4,*)      n+=4;;
            5,???,*)  n+=2;;
            5,*,??)   n+=3;;
            5,*)      n+=5;;
            6,*,????) n+=6;;
            6,??,*)   n+=9;;
            6,*)      n+=0;;
            7,*)      n+=8;;
            *) echo "ERROR: ${#i},${i//[$T4]},${i//[$T7]}"; break 2;;
        esac
    done
    sum+=+$((10#$n))
done < "${input}"
echo "8B: $((sum))"
