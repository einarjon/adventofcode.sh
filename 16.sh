#! /usr/bin/env bash
input=${1:-16.txt}
A=($(grep -o -- "-[0-9]*" "$input" | sort -n)); max=${A/-} # get min/max and tickets
A=($(grep -o -- "[0-9]*-" "$input" | sort -n)); min=${A/-}
A=($(grep "," "$input"))
sum=""
for i in "${!A[@]}"; do
  for j in ${A[i]//,/ }; do
    (( j < min || j > max )) && sum+=+$j A[i]=""
  done
done
echo "16A: $((sum))"

my_ticket=(${A//,/ })
B=(${A[@]:1}) # Drop bad tickets
IFS='' i=0 f=({0..9} {a..z}) options="${f[*]:0:${#my_ticket[@]}}"
IFS=$' :-\n'; C=(); Cf=();
while read -r name min1 max1 _ min2 max2; do # Read min/max values and field names
    Cf[i]=$options
    Cm1[i]=$min1; CM1[i]=$max1
    Cm2[i]=$min2; CM2[i]=$max2
    C[i++]=$name
done < <(sed -n -e "/ .*:/s/ /_/;/or/p" "$input")
IFS=$' \n'
idx=${!C[*]}
for line in "${B[@]}"; do
  T=(${line//,/ })
  for i in $idx; do
    for n in $idx; do
      if (( (T[n] < Cm1[i] || T[n] > CM1[i]) && (T[n] < Cm2[i] || T[n] > CM2[i]) )); then
        Cf[i]=${Cf[i]//${f[n]}} # remove out of range char
      fi
    done
  done
done
#for k in ${!C[@]}; do echo ${C[k]}=${Cf[k]}; done
total=1
while [[ "$oldC" != "${Cf[*]}" ]]; do
  oldC="${Cf[*]}"
  for i in $idx; do
    if [[ ${#Cf[i]} == 1 ]]; then
      x=${Cf[i]}
      [[ ${C[i]} = dep* ]] && total+="*${my_ticket[36#$x]}"
      Cf=("${Cf[@]//$x}")
    fi
  done
done
echo "16B: ${total:2} = $((total))"
