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
 80 rounds can be done in half a second with string shenaningans, but 256 days would take terabytes of RAM, and lots of time.
 Instead store a count of the fishes each day in a circular buffer, with the current 0-day at n%9. Bash arrays are circular by default.

### 07.sh
 1. Use the median.
 2. Use the mean.

### 08.sh
 1. Simple grep to fish out the output digits and isolate the ones with 2-4 or 7 digits.
 2. A damn bother, since the letters were scrambled. Assigned the numbers based on length. The 5-6 length ones got special handling, by checking the length after removing the letters that make up 4 and 7. That was enough to identify every one.

### 09.sh
 1. For each line, go forward in the string while the next char is lower. Once you reach that, add a low point if all 4 neighbours are higher.
 2. Clean out the map so that all numbers except edges and 9s are empty. Add each low point from part 1 with a different symbol.
 Use terrible bash to grow the symbols until the whole map is filled. Count the size of each symbol block.

### 10.sh
 Renamed the brackets for easier grok-ing, and so that I could assign values to each one.
 1. Keep removing "innermost" bracket pairs until none remains, then remove opening brackets and sum up the values in the first column, if any.
 2. Remove any string containing a closing bracket, reverse the rest. Instead of adding a closing bracket, add the value for each opening bracket at a time.

### 11.sh
  1. Convert the map to a 1D array, and add -9999999 to the sides so I don\'t need to think about edges. Recursive function to flash the octopi.
  2. Run until all fields flash at once.

### 12.sh
 1. Brute force. Simplified version of the recursive functions of 2015 (9 and 13). Collect a hashmap with the destinations for each cave. Remove "start" from the destinations to simplify coding.
 2. Add a dumb check to allow the first lowercase cave twice. Takes way too long to run.

### 13.sh
 1. Functions fold_x/fold_y for easier handling. Fold and remove duplicates for first line.
 2. Repeat for rest of the lines. Collect space-delimited dots in an array of strings. Print the array.

### 14.sh
 Collect the conversions in an array. Count the number of pairs in the initial polymer. For each polymer, convert the input to 2 outputs.
 For the final count, every char is part of 2 pairs except the ends, so add 1 to the ends and then divide by 2 for the final number.
