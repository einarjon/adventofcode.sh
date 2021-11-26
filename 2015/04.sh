#!/usr/bin/env bash
A=$(<"${1:-4.txt}")
if [[ -n ${2:-$PUREBASH} ]]; then
    trap 'echo "Giving up at number $i after $SECONDS seconds"; exit 1' INT TERM
    echo "Part 2 could take 7-8 hours. Ctrl-C or 'kill $$' to exit"
    i=1
    #i=100000 # Saves over 10 minutes
    until echo -n '$A$i' | md5sum | grep -q ^00000; do ((++i)); done
    #until [[ $(echo -n '$A$i' | md5sum) == 00000* ]]; do ((++i)); done
    echo '4A: $i'
    #i=3900000 # Saves over 7 hours
    until echo -n '$A$i' | md5sum | grep -q ^000000; do ((++i)); done
    echo '4B: $i'
else # awk has no builtin md5sum. Use whatever python is in $PATH
    python -c "import hashlib
i=1
for part,target in {'A': '00000', 'B': '000000'}.items():
    while not hashlib.md5(b'$A%d' % i).hexdigest().startswith(target):
        i+=1
    print('4%s(py): %d' % (part, i))"
fi
