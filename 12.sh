#! /usr/bin/env bash
A=($(< "${1:-12.txt}"))
H=1; X=0; Y=0; D=(N E S W)
for i in "${A[@]}"; do
    i=${i/F/${D[H]}}
    n=${i:1}
    case $i in
        N*) Y+=+$n;;
        S*) Y+=-$n;;
        E*) X+=+$n;;
        W*) X+=-$n;;
        R*) H=$((((n/90)+H)%4));;
        L*) H=$((((-n/90)+H)%4));;
        *) echo "ERROR $i"; break;;
    esac
done
echo "12A: $((X))+$((Y)) = $(((X<0?-X:X)+(Y<0?-Y:Y)))"
H=1; X=10; Y=1; x=0; y=0
for i in "${A[@]}"; do
    n=${i:1}
    case $i in
        N*) Y+=+$n;;
        S*) Y+=-$n;;
        E*) X+=+$n;;
        W*) X+=-$n;;
        F*) ((x+=n*X,y+=n*Y));;
        R90|L270)   TMP=$X; ((X=Y,Y=-TMP));;
        R270|L90)   TMP=$X; ((X=-Y,Y=TMP));;
        R180|L180)  ((X=-X,Y=-Y));;
        *) echo "ERROR $i"; break;;
    esac
done
echo "12B: $x+$y = $(((x<0?-x:x)+(y<0?-y:y)))"
