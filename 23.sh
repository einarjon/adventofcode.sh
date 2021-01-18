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
A=$(<"${1:-23.txt}")
#A=389125467
grep -o "[1-9]" <<< "$A" | awk '
{ if(last){ C[last]=$0 }else{ cup=$0 }; last=$0; ++i; }
END{
N=10000000;
max=1000000;
C[last]=++i;
while (i<max) {C[i-1]=++i}
C[max]=cup;
for (i=0; i<N; i++) {
  a=C[cup]; b=C[a]; c=C[b];
  d=cup; if (--d<=0) { d=max }
    while (d == a || d == b || d == c) {
    if (--d<=0) { d=max }
  }
  C[cup]=C[c];
  tmp=C[d]; C[d]=a; C[c]=tmp; cup=C[cup];
}
printf "23B: %d*%d = %d\n", C[1] , C[C[1]], C[1]*C[C[1]]
}'
