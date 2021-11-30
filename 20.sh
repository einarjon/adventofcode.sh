#! /usr/bin/env bash
rotate() {
    local -n in=$1 out=$2
    local len=${#in[0]}
    for i in "${idx[@]:1:len}"; do
        out[len-i]=$(printf "%s\n" "${in[@]}" | cut -c"$i" | tr -d '\n' )
    done
}

IFS=$'\n'
A=($(tr '.' '_' < "${1:-20.txt}")) # . is a wildcard
idx=(${!A[@]})
rotate A A270
ENDS=() NUM=() D=() U=() len=${#A[1]}
for ((i=0;i<${#A[@]};i+=len+1)); do
    NUM+=(${A[i]//[^0-9]})
    U+=(${A[i+1]})
    D+=(${A[i+len]})
done
IFS=$' \n'
L=(${A270[-1]//[^_#]/ })
R=(${A270[0]//[^_#]/ })
Ur=($(printf "%s\n" "${U[@]}" | rev))
Dr=($(printf "%s\n" "${D[@]}" | rev))
Lr=($(printf "%s\n" "${L[@]}" | rev))
Rr=($(printf "%s\n" "${R[@]}" | rev))
N="${#U[@]}"
for n in "${idx[@]:2:N}";do ((n*n==N)) && break; done
printf -v ALL "%s\n" "${U[@]}" "${R[@]}" "${Dr[@]}" "${Lr[@]}"
IFS=$' :\n'
for i in "${!U[@]}"; do
    x=()
    while read -r k _; do
        (((--k%N)!=i)) && x+=("$((k/N)):$((k%N))")
    done < <(echo "$ALL" | grep -n -E -x "(${U[i]}|${R[i]}|${Dr[i]}|${Lr[i]}|${Ur[i]}|${Rr[i]}|${D[i]}|${L[i]})")
    PIC[i]=${x[*]}
    case ${#x[*]} in
        2) ENDS[i]="${NUM[i]}";;
        3|4) : ;;
        *) echo "ERROR($i): ${x[*]}"; break;;
    esac
done
IFS=$' \n'
printf -v prod "*%s" "${ENDS[@]}"; prod=${prod:1}
echo "20A: $prod=$((prod))"
GRID=() FOUND=() ROT=() s1=() s2=()
index=(${!ENDS[@]})
next=${index[0]}

# Top row. Rotation is based on neighbors, so that has to wait
FOUND[next]=0; GRID[0]=$next
for i in "${idx[@]:1:n-1}"; do
  for k in ${PIC[next]//?:}; do
    [[ -n ${FOUND[k]} || ${PIC[k]} == *:*:*:*:* ]] && continue
    next=$k; FOUND[k]=$i; GRID[i]=$k; break
  done
done
#Rows 2-12. Exactly one side should not be done already
for i in "${idx[@]:n:N-n}"; do
    for j in ${PIC[GRID[i-n]]}; do
        k=${j/?:}; [[ -n ${FOUND[k]} ]] && continue
        FOUND[k]=$i; GRID[i]=$k; ROT[i]=${j/:*}; break
    done
done
# Circle back to the first row
for i in "${idx[@]:0:n-1}"; do
     if [[ ${PIC[GRID[i+n]]} =~ ([0-9]):${GRID[i]} ]]; then
         ROT[i]=$(( BASH_REMATCH[1]+2 ))
     fi
done

edges=(R Dr Lr U L Ur Rr D)
segde=(L Ur Rr D R Dr Lr U) # flipped
get_edges() {
    local -n both=$1 left=${edges[$3]} right=${segde[$3]}
    both=(${left[$2]} ${right[$2]})
}
# Make sure the left/right sides match
for ((i=1 ; i < N; i+=2)); do
   get_edges s1 "${GRID[i-1]}" ${ROT[i-1]}
   get_edges s2 "${GRID[i]}" ${ROT[i]}
   if   [[ ${s1[0]} == "${s2[1]}" ]]; then ((ROT[i]-=4, ROT[i-1]-=4)) # flip both
   elif [[ ${s1[1]} == "${s2[1]}" ]]; then ((ROT[i]-=4))              # flip right
   elif [[ ${s1[0]} == "${s2[0]}" ]]; then ((ROT[i-1]-=4))            # flip left
   elif [[ ${s1[1]} == "${s2[0]}" ]]; then  :                         # no flip
   else echo "ERROR: idx $((i-1)) and $i don't match: ${s1[*]} != ${s2[*]}"
   fi
done

rot0(){
    local X=() offset=$((11*$1))
    for i in {1..8}; do X+=(${A[offset+i+1]:1:8}); done
    printf "%s\n" "${X[@]}"
}
rot270() {
    local X=() offset=$((11*$1))
    for i in {1..8}; do X+=(${A270[i]:offset+2:8}); done
    printf "%s\n" "${X[@]}"
}
rot180(){ rot0 "$@" | tac | rev; }
rot90(){ rot270 "$@" | tac | rev; }
flip0() { rot0 "$@" | rev; }
flip270() { rot270 "$@" | rev; }
flip180() { rot0 "$@" | tac; }
flip90() { rot270 "$@" | tac; }
TOTAL=() FINAL=() FINAL270=()
TRANSFORM=(flip0 flip270 flip180 flip90 rot0 rot270 rot180 rot90)
for i in "${!GRID[@]}"; do
    TOTAL+=($(${TRANSFORM[ROT[i]]} "${GRID[i]}"))
done

# Assemble image
for ((i=0; i < n; ++i)); do
 for ((j=0; j < 8; ++j)); do
    for ((k=0; k < n; ++k)); do
      FINAL[8*i+j]+=${TOTAL[8*n*i+j+k*8]}
    done
  done
done
rotate FINAL FINAL270
monster="..................(#..{77}#....##....##....###.{77}.#..#..#..#..#..#...)"
monsterlen=${monster//[^\#]}; monsterlen=${#monsterlen}
regex=${monster/................../[_\#]\{18\}} # no newline at start
i=0
printf -v "MAP[i++]" "%s\n" "${FINAL[@]}"
MAP[i++]=$(printf "%s\n" "${FINAL[@]}" | tac)
MAP[i++]=$(printf "%s\n" "${FINAL[@]}" | rev| tac)
MAP[i++]=$(printf "%s\n" "${FINAL[@]}" | rev)
printf -v "MAP[i++]" "%s\n" "${FINAL270[@]}"
MAP[i++]=$(printf "%s\n" "${FINAL270[@]}" | tac)
MAP[i++]=$(printf "%s\n" "${FINAL270[@]}" | rev| tac)
MAP[i++]=$(printf "%s\n" "${FINAL270[@]}" | rev)
hashes=${MAP[0]//[^#]}; total=${#hashes} found=0
for map in "${MAP[@]}"; do
    if [[ $map =~ $regex  ]]; then
        break
    fi
done

# Change the head of the monster so it is only found once
while [[ $map =~ $regex ]]; do
    ((++found < 200)) || { echo "Error: replace is failing ($found monsters)"; break; }
    map=${map/"${BASH_REMATCH[1]}"/"O${BASH_REMATCH[1]:1}"}
done
echo "20B: $total-$monsterlen*$found = $((total-monsterlen*found))"
