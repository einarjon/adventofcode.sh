#! /usr/bin/env bash
input=${1:-16.txt}
# lazy get min/max and tickets
A=($(grep -o -- "-[0-9]*" $input | sort -n)); max=${A/-}
A=($(grep -o -- "[0-9]*-" $input | sort -n)); min=${A/-}
A=($(grep "," $input))
sum=""
for i in ${!A[@]}; do
  for j in ${A[$i]//,/ }; do
    [[ $j -lt $min || $j -gt $max ]] && sum+=+$j && A[$i]=""
  done
done
echo "16A: $((sum))"

B=(${A[@]}) # Drop bad tickets
my_ticket=(${B//,/ })
i=0; f=({0..9} {a..z}) options=$(echo ${f[*]:0:${#my_ticket[@]}}| tr -d ' ')
IFS=$' :-\n'; C=(); Cf=(); CM1=
while read name min1 max1 _ min2 max2; do
#    echo $name $min1 $max1 _ $min2 $max2
    C[$i]=$name  # Read min/max values and field names
    Cf[$i]=$options
    Cm1[$i]=$min1; CM1[$i]=$max1
    Cm2[$i]=$min2; CM2[$((i++))]=$max2
done < <(sed -n -e "/ .*:/ s/ /_/;/or/p" $input)
IFS=$' \n'
my_ticket=(${B//,/ })
idx=${!C[@]}
for line in ${B[@]}; do
  T=(${line//,/ })
  for i in $idx; do
    for n in $idx; do
#        echo "${T[n]} -lt ${Cm1[i]}   ${T[n]} -gt ${CM1[i]} ]] && [[ ${T[n]} -lt ${Cm2[i]} || ${T[n]} -gt ${CM2[i]} "
      if [[ ${T[n]} -lt ${Cm1[i]} || ${T[n]} -gt ${CM1[i]} ]] && [[ ${T[n]} -lt ${Cm2[i]} || ${T[n]} -gt ${CM2[i]} ]]; then
          Cf[$i]=${Cf[$i]//${f[n]}} # remove out of range char
      fi
    done
  done
done
#for k in ${!C[@]}; do echo ${C[k]}=${Cf[k]}; done
total=1; j=0;
while [[ "$oldC" != "${Cf[*]}" ]]; do
  oldC="${Cf[*]}"
  for i in $idx; do
    if [ ${#Cf[i]} = 1 ] ; then
      x=${Cf[i]}; n=$((36#$i))
      j=$((++j))
      [ ${C[i]:0:3} = dep ] && total+=*${my_ticket[$n]}
      Cf=("${Cf[@]//$x}")
    fi
  done
done
echo "16B: ${total:2} = $((total))"
