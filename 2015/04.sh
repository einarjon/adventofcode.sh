#!/usr/bin/env bash
A=$(<"${1:-4.txt}")
i=1
i=100000 # Saves over 10 minutes
#until echo -n "$A$i" | md5sum | grep -q ^00000; do ((++i)); done
until [[ $(echo -n "$A$i" | md5sum) == 00000* ]]; do ((++i)); done;
#until [[ $(md5sum < <(echo -n "$A$i")) == 00000* ]]; do ((++i)); done;
echo "4A: $i"
i=3900000 # Saves over 7 hours
until echo -n "$A$i" | md5sum | grep -q ^000000; do ((++i)); done
#until [[ $(md5sum < <(echo -n "$A$i")) == 000000* ]]; do ((++i)); done;
echo "4B: $i"
