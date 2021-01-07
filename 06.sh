#! /usr/bin/env bash
X=abcdefghijklmnopqrstuvwxyz; x=$X; j=-; a=0
A=($(sed s/^$/X/ ${1:-6.txt}))
while read -n1 i; do
    [ "$i" = X ] && a=$((a+26-${#x})) && x=$X
    x=${x/$i}
done < <(echo ${A[*]} X)
echo "6A: $a";

x=""; a=0
for line in "${A[@]}" X; do
  if [[ "$line" = X ]]; then a=$((a+${#x})); x=X;
  elif [ "$x" = X ]; then x=$line;
  else
      y=""; while read -n1 i; do [[ ${x/$i} != ${x} ]] && y+="$i"; done <<< $line
    #  y="";for ((i=0;i<${#line};i++ )); do [[ ${x/${line:$i:1}} != ${x} ]] && y+="${line:$i:1}"; done
      x=$y;
  fi
done
echo "6B: $a"
