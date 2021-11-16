# adventofcode.sh
Advent of Code 2015, done in bash. Because one year is not enough.
https://adventofcode.com/2015/

Input can be given on the command line.
Defaults to *number*.txt in the same folder (no leading 0).
Setting env variable PUREBASH to any value (or giving a second argument) will use slow bash instead of using faster awk in days 6 and 25.

### 01.sh
 1. Convert brackets to ±1 and add them up.
 2. Add up from the start, and stop when you get negative.

### 02.sh
Sort the dimensions by size. Add up the dimensions. Using a bash "bubble sort" is 40x faster than calling $(sort ...).

### 03.sh
 1. Switch to select where to go. Store visited squares in a hash table.
 2. Store x/y coordinates in arrays so both parts can be solved with the same code.

### 04.sh
Oneliners using md5sum. Calling md5sum in a subshell forever to run (~150 hashes/sec). Running it from 1 could take 7-8 hours.
Speed up by setting the number to nearest 100000 below my target, skipping over 98% of the md5sum calculations.

### 05.sh
Oneliners using grep -E.

### 06.sh
This is where bash sucks. The best I could do was an array of strings, and substring manipulation to change the values.
 1. Switch to select what to do. Use substring index magic. Fixed strings of 1000 ones and zeros to make life easier. Swap is a bother, and uses string substitution.
 2. A million countable items in bash are always a bother. Using $(tr ...) allows me to store 62 values per character in a string, but it's extremely slow. Awk is around 30 times faster.

### 07.sh
 1. After setting up, loop through all values and evaluate it to a number if all parameters have been evaluated.
Takes about 100 iterations through all values. Run in a subshell to keep the namespace clean for part 2.
 2. Repeat with a different input.

### 08.sh
String manipulation with printf.

### 09.sh
Recursive brute force. Worst case is 8!
Skip cases that have no chance to reach min/max when 3 places are unset (~5000 rounds instead of 40320)
After doing day 13p2, close the circle and keep track of min/max distances to take advantage of circular symmetry.
Remove those to find best/worst routes (~1200 rounds instead of ~5000).

### 10.sh
Very slow.
Make a function to apply the rules. Run 40 times. Then 10 times more.
To avoid monster strings, store the output in an array of strings, changing every 4K chars.

### 11.sh
A lot easier to guess than to code.
Use a regex to verify. Replace the end of the password with the next match and assemble for each turn.
Assumes that the beginning of the password does not fulfill the requirements, and will miss some passwords if it does.

### 12.sh
 1. Just filter out the numbers and add them up.
 2. Similar to 2020 day 18. Work from the innermost '{...}' out. Replace it with 0 or the sum of the numbers in it. Repeat until done.

### 13.sh
 1. A repeat of day 9. Set the combined happiness change A=>B and B=>A as distance and find the max of the circle. Due to circular symmetry only one position needs to be calculated.
  This reduces the worst case from 8! to 7!
 2. It would be easy to add "Me" with distance 0, but that would increase the complexity to 9! (or 8! calculated).
	But by just keeping track of the worst seating in the circle and deleting it by placing yourself in between you get the same result.
	Skip cases that seem unhappy when 3 places are unset.

### 14.sh
Again the lack of 2D arrays are a bother. Use a function with local -n to bypass that.
 1. Calculate how far each reindeer will go. Keep track of the max.
 2. Calculate how far each reindeer will go each round. Keep track of the tally.

### 15.sh
Brute force. Triple for loop to try every combination of ingredients.
Keep track of highest score for every cookie, and also for the 500 calorie ones.

### 16.sh
Use grep -n and grep -E to find what Sues fit.
 1. Loop trough the list and drop the Sues that have the wrong number for the item. Only one remains.
 2. Replace cats, trees, etc with a glob. Repeat as before.

### 17.sh
Recursive brute force. Try every combo. Start with biggest containers to fail faster.
Don't bother counting until we have at least enough values to reach 150, and skip combining the smallest numbers that don't add up to 150.

### 18.sh
 1. Game of life. Copied from day 11 of 2020 with minor changes.
 2. Change corners to a different value, so they are stuck. Repeat

### 19.sh
This is where bash sucks again. Use a hashtable of strings to store the inputs and outputs.
 1. For every input, Split the mol into substrings where the input is found, then replace one of them at a time with the output and store the resulting molecule in a hash table. Return number of entries in the hash table.
 2. Blindly try to replace the outputs with inputs until the result is e. Luckily that gives the lowest number.

### 20.sh
 1. Find all numbers that the house number is divisible by. Sum up the divisor and result and stop once the target is reached.
 2. Same for the first 50.
 This would take forever, so skip a lot of houses until we are closer to reaching the target, and stop counting if the house number has few small divisors.

### 21.sh
Yet another brute force.
 1. For every possible hit point, find the least amount of armor that wins, and calculate the cheapest ways to buy that.
 2. Deduct 1 from the armor the winning combinations, and calculate the most expensive way to buy that.
  Not a complete solution, since it does not test 2 rings of the same type (2xHP or 2xArmor).

### 22.sh
Recursive brute force.
 1. Try every combo until you win, die, run out of mana or spend more than the min mana needed.
 2. Same as part 1, but lose one HP before your round.
  Only run the winning first move for each round to save time.

### 23.sh
Switch to handle the different commands. Similar to 2020 day 8.

### 24.sh
Easy to guess, harder to code. The lowest multiple involves the biggest numbers, so I started on that end.
Recursively try all combinations. Only try the first 4 at each legroom, since the "entanglement" will only get bigger.

### 25.sh
Multiply and modulus repeated +17M times. Awk is around 30 times faster than bash.
