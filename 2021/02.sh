#! /usr/bin/env bash
input=${1:-2.txt}
declare -i X=0 Y=0 y=0
while read -r dir n; do
  case $dir in
    up) Y+=-$n;;
    down) Y+=$n;;
    forward) X+=$n; y+=$((Y*n));;
  esac
done < "${input}"
echo "12A: $X*$Y = $((X*Y))"
echo "12B: $X*$y = $((X*y))"
# golfed with awk
#awk 'n=$2 /u/{Y-=n}/n/{Y+=n}/f/{X+=n;y+=n*Y}END{print X*Y,X*y}' ${1:-2.txt}
#paste -d"*" <(paste -sd+ <(rg ^f "${input}" | rev | cut -c 1) | bc) <(paste -sd+ <(rg '^[du]' "${input}"  | sed 's/down/1\*/;s/up/-1\*/g'  | bc) | bc) | bc

#paste -d"*" <(paste -sd+ <(paste -d* <(cut -c 1 "${input}") <(rev "${input}" | cut -c -1) <(sed 's/down/1\*/;s/up/-1\*/;s/forward/0\*/g' "${input}" | bc | awk '{total += $0; $0 = total}1') | rg f | tr f 1 | bc ) | bc) <(paste -sd+ <(rg ^f "${input}" | rev | cut -c 1) | bc) | bc
# /u/obluff
paste -d"*" <(paste -sd+ <(sed -n 's/f.* //p' "${input}" )|bc) <(paste -sd+ <(sed 's/down //;s/up /-/g;/f/d' "${input}")|bc) | bc
paste -d"*" <(paste -sd+ <(paste -d* <(cut -c1 "${input}") <(tr -dc '0-9\n' < "${input}") <(x=0 && sed 's/down //;s/up/-/;s/f.*/0/' "${input}" | while read -r a;do echo $((x+=a));done) | sed -n s/f.//p | bc) | bc) <(paste -sd+ <(sed -n 's/f.* //p' "${input}") | bc) | bc
