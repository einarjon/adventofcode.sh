# adventofcode.sh
Advent of Code 2020 and 2015, done in bash. Because why not?
https://adventofcode.com/2020/

https://adventofcode.com/2015/ can be found in the folder 2015.

Input not included, but can be given on the command line.
Defaults to *number*.txt in the same folder (no leading 0).
Setting env variable PUREBASH to any value (or giving a second argument) will use slow bash instead of using faster awk in days 15, 23 and 25.

Description of what I'm doing. Contains spoilers....

### 01.sh
 1. Use an array as a hash table. Loop through all the numbers looking for 2020-a.
 2. Double loop through all the numbers looking for 2020-a-b.

### 02.sh
 Simple read and string manipulation. Use IFS to split up the min/max and remove the ':'.
 1. Remove everything except the correct letter, then count what is left.
 2. Check the letters in the position given.

### 03.sh
 1. Collect all the characters in our path to a string. Remove the '.' and check the remaining length.
 2. Same with more paths.

### 04.sh
 Use case globbing to find the entries. If field is found, remove a letter representing that field from a string of all fields.
 If all letters have been removed when the entry is parsed, the entry is valid.
 Swap the empty line between entries with a XXX and use IFS to simplify handling.

### 05.sh
 1. Convert to binary with tr. Reverse sort pushes highest number to top. Convert from binary to decimal.
 2. Check if two numbers in a row end in the same number (0 or 1). Those are the neighbours of the match.

### 06.sh
 1. Remove the letters from a string of all answers like in day 4. Number of answers is then strlen(all)-strlen(remaining).
 2. Reverse the approach. First line now becomes the string of all answers. Subsequent lines remove letters that are missing, until only the common ones remain.

### 07.sh
 1. So much grep. Grep until you can grep no more.
 2. Recursive function that uses grep to count the number of bags in a bag (including itself).
    Remember to deduct 1 shiny gold bag from the answer.

### 08.sh
 1. Use a switch to handle the jumps. Mark "touched" instructions with an x. Stop when a "touched" instruction is found.
 2. Brute force swapping of one jmp/nop at a time. Run as in part 1 until the program completes.

### 09.sh
 1. Brute force. First one to take more than half a second to run. Using index is much faster than $(seq ...);
 2. Sliding window until the number is found.

### 10.sh
 1. Iterate through the list, collect the diffs into buckets. Multiply bucket 1 and 3.
 2. Same as part 1, but collect the diffs into a string (order matters). Each string of ones has a variety of paths, but 3s have only one path.
    Since there are only 1s and 3s in the list, split into strings of ones, plug in possible paths and multiply.

### 11.sh
 1. 2D arrays suck in bash. Use an array of strings, and a lot of string manipulation. Slow, since we need to calculate neighbours of 7000 seats +80 times.
    Optimized a bit to skip the first round and the "always full" seats (very little gain), and only check lines if they or their neighbour line changed last round (big gain).
 2. More of the same. Optimizing to skip lines is not really possible, since keeping track of what neighbours changed is too much work.

### 12.sh
 1. Store X and Y position in separate strings. Keep track of H(eading) each time a rotation is made and convert F to the correct direction.
 2. Same as 1, but also store x and y position of waypoint. Convert rotation manually, because thinking is hard. F just jumps towards (x,y).

### 13.sh
 1. Filter out x-es using IFS, store the min value and the ID. Multiply.
 2. Simple (possibly not correct) implementation of Chinese Remainder Theorem.

### 14.sh
 1. Switch case similar to day 4 and 8. Use printf -v to avoid parsing the number in mem\[x\].
 2. Use IFS and read to simplify handling.
    Recursive function that converts the first X to 1 and 0, and calls itself twice until no X remains. Then do the thing.

## Getting harder
  The puzzles from day 15 are starting to be pushing the limits of bash. Runtime is in seconds instead of tens or hundreds of milliseconds.

### 15.sh
 1. Store the last known position in a sparse array. Calculate next position until done.
 2. Finally bash fails. Sparse arrays in bash seem to be linked lists, so accessing/adding an item is O\[N\] or worse.
    Gave up after 20 hours getting to item 6.1M, and solved it in 10-12 seconds with awk.
    Using a sharded-set https://github.com/romkatv/advent-of-code-2019 solves this in about 20 minutes.

### 16.sh
 1. Find the min/max of the classes, then loop through every ticket to find illegal values.
 2. A. Filter out bad tickets.
    B. Then do the same trick as in day 4, for every field. Any number outside the min/max marks it as invalid.
    C. Find a field that has only one character left, mark that as the correct. Remove that character from all fields. Repeat until solved.

### 17.sh
 1. 3-D Game of Life. Use x.y.z as a named array index, and loop through all neighbours. Give all neighbours a +1 in a tmp array, and all currently active cubes a 0 (to correctly clear lone cubes).
 2. Remarkably easy with x.y.z.w as an index.

### 18.sh
 Have to turn glob off, or \* will be replaced with all files in directory.
 1. Bash regex to find a bracket that doesn't contain inner brackets. Calculate that. Replace the whole bracket with result. Repeat until no brackets remain. Slow, but faster than grep -o.
 2. Just replace "\*" with ")\*(" to change the precedence. Add "(" and ")" to the ends to close off the brackets.

### 19.sh
 1. Recursive regex building. Use a cache to only build a regex once for each rule.
 2. Cheat a bit and use regex{n} to denote repeated matches.

### 20.sh
 1. Slice and dice all permutations of the edges into arrays. Grep each tile against all permutations of edges. Convert line number to index/rotation. The ones with only 2 matches are corners. The ones with 3 are edges. Use that to assemble the image.
 2. Not done yet: Once the picture is assembled, use a multi-line regex to find the monsters. Then count.

### 21.sh
 Grep, sort, count
 1. Get a sorted list of allergens, and number of lines they appear in. Find the ingredients that appear in all those lines. Then count the remaining ones.
 2. Same as 16 part 2. Find an allergen that only has 1 ingredient. Store and remove. Repeat until all ingredients are removed. 

### 22.sh
 1. Simple while loop. Run until one array is empty.
 2. Recursive while loop. Store all permutations of A/B as a key in hash table to find repeats. Takes +2 minutes to run.

### 23.sh
 1. String manipulation. Lots of trial and error to get it right.
 2. Just over 20 minutes in bash. Awk is more than 60 times faster.

### 24.sh
 1. Use an X-Y grid with only diagonals. One step can be (±2,0) or (±1,±1). Modify input so that standalone e/w are doubled, and count the total movement.
 2. Hex game of life. Use the same index trick as day 17. Access the grid manually, since a loop would be a PITA.

### 25.sh
 1. While loop for 15M rounds. Yay. Awk finishes in seconds.
 2. I need to complete 20-2 to get this one. Nope.

