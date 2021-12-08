#!/usr/bin/env bash
input=${1:-8.txt}
printf "8A: "
cut -d\| -f 2 "$input" | grep -Eo "[a-g]+" | grep -cE "^([a-g]{2,4}|[a-g]{7})$"
sum=""
while read -r -a A; do
    T=() P235=() P690=() n=""
    for i in "${A[@]:0:10}"; do
        case ${#i} in
            2) T[1]=$i;;
            3) T[7]=$i;;
            4) T[4]=$i;;
            5) P235+=($i);;
            6) P690+=($i);;
            7) T[8]=$i;;
        esac
    done
    for i in "${P235[@]}"; do
        if [[ ${i//[${T[4]}]} == ??? ]]; then  T[2]=$i
        elif [[ ${i//[${T[7]}]} == ?? ]]; then T[3]=$i
        else                                   T[5]=$i
        fi
    done
    for i in "${P690[@]}"; do
        if [[ ${i//[${T[7]}]} == ???? ]]; then T[6]=$i
        elif [[ ${i//[${T[4]}]} == ?? ]]; then T[9]=$i
        else                                   T[0]=$i
        fi
    done
    for i in "${A[@]:11}"; do
        case ${#i} in
            2) n+=1;;
            3) n+=7;;
            4) n+=4;;
            5) for k in 2 3 5 ?; do [[ -z ${i//[${T[k]}]} ]] && break; done; n+=$k;;
            6) for k in 6 9 0 ?; do [[ -z ${i//[${T[k]}]} ]] && break; done; n+=$k;;
            7) n+=8;;
        esac
    done
    sum+=+$((10#$n)) # leading 0 means octal. A '?' will throw an error here
done < "${input}"
echo "8B: $((sum))"
