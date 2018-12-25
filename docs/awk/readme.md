# To run
```bash
awk -f number_of_lines.awk ../data/population.csv
```

# Examples

## [number_of_lines.awk](number_of_lines.awk)
* Count lines of a file
* Use of NR at the end

## [line_no.awk](line_no.awk)
* Print line number for each line of the file
* Use of NR

## [summation.awk](summation.awk)
* Sum a file that consists of numbers per line

## [skip_first_line.awk](skip_first_line.awk)
* Will skip the first line and then process the rest

## [shell_usage.awk](shell_usage.awk)
* Arrays
* For loop

## [word_frequency.awk](word_frequency.awk)
* Counts word frequency in a given file
* Assumes words are separated by a space
* Use of printf

## Notes

* Special variables
  * `NR`: current record number
  * `NF`: number of fields
  * `$0`: text of the current record
  * `$1`: first field

* To pass an external variable
```bash
awk -v USER_NAME=$USER '{print USER_NAME}'
```

* To filter lines of a file
```bash
# first 3 lines
awk 'NR < 3' < input.file
# first 3 lines
awk `NR==1,NR==3' < input.file
# lines containing the word dollar
awk `/dollar/' < input.file
# lines not containing the word dollar
awk `!/dollar/' < input.file
```

* Setting a different delimiter
```bash
awk -F: '{ print $NF }' < ../data/passwd
awk 'BEGIN { FS=":" } { print $NF }' < ../data/passwd
```

* To read the output of a command
```bash
awk 'BEGIN { FS=":" } { "grep root ../data/passwd" | getline; print $1,$6}' < input.file
```

* Loops
```bash
for(i=0;i<10;i++) {
    print $i;
}
for (i in array) {
    print array[i];
}
```

* String functions
   * `length(string)`
   * `index(string, search)`: the position at which search is found within string
   * `split(string, array, delimiter)`: populates an array with strings created by splitting the string on the delimiter character
   * `substr(string, start, end)`: returns the substring between start and end positions
   * `sub(regex, replacement, string)`: replaces the first regex match with the replacement string
   * `gsub(regex, replacement, string)`: replaces all regex matches with the replacement string
   * `match(regex, string)`: if there is a match returns non-zero value, 0 otherwise. If there
   is a match RSTART contains where the match starts, and RLENGTH is the length of the match.
