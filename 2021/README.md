# adventofcode.sh
Advent of Code 2021, done in bash. Because I can't stop
https://adventofcode.com/2021/

Input can be given on the command line.
Defaults to *number*.txt in the same folder (no leading 0).
Added my input files in input/ folder.
Setting env variable PUREBASH to any value (or giving a second argument) will use slow bash instead of using faster awk when needed.

Description of what I'm doing. Contains spoilers....

### 01.sh
 1. Dumb looping through all variables.
 2. Use a sliding window. 2/3 of the values in the windows are the same, but this is fine.

### 02.sh
 Simple switch to handle all cases. Both parts handled at once.

### 03.sh
 1. Slightly tricky. Use a function to find the most/least common number in each position.
 2. Same function, but change the input for every char.

### 04.sh
 1. Use an array to store all lines/rows of a bingo card. Delete numbers from all lines until a line is empty. 
 2. Remove a card when a line is empty. Keep going until all cards are gone.

### 05.sh
 1. Mark all points on the grid in a hash table. Return a count of points that are != 1.
 2. Mark diagonals on a second hash table. Add the first hash table to it and return a count of points that are != 1.

### 06.sh
 Store a count of the fishes each day in a circular buffer, with the current 0-day at n%9. Bash arrays are circular by default.

### 07.sh
 1. Use the median.
 2. Use the mean.

### 08.sh
 1. Simple grep to fish out the output digits and isolate the ones with 2-4 or 7 digits.
 2. A damn bother, since the letters were scrambled. Assigned the numbers based on length. The 5-6 length ones got special handling, by checking the length after removing the letters that make up 4 and 7. That was enough to identify every one.
