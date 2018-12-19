# Commands
* `type`: builtin command
* `which`: to find which command would be executed
* `man`: to view the manual for a command
* `help`: to view the help page for builtin commands (e.g. help type)
* `file`: determine file type
* `stat`: display file status
* `echo`: print to standard output
* `printf`: print formatted strings to standard output
* `cat`: output contents of a file
* `sort`: to sort a file
* `uniq`: to remove adjacent duplicate lines from a file
* `tee`: to copy input into both standard output and a given file
* `tr`: translate characters
* `wc`: word, line, character count
* `grep`: to find text in files
* `egrep`: like grep but can handle extended regular expressions
* `zgrep`: to find text in compressed files
* `zcat`: like cat, but for compressed files
* `head`: to display the beginning of a file
* `tail`: to display the end of a file
* `awk`: a great utility to process text files and extract columns
* `time`: to time commands
* `kill`: to kill a job with pid or job number
* `trap`: to trap a signal
* `date`: to show current time and date
* `diff`: to compare two files
* `ln`: to make symbolic links
* `xargs`: to construct argument list and execute utility
* `sed`: find and replace in a file
* `getopts`: to process command line arguments
* `test`: to evaluate a test condition
* `mkdir`: to create a directory
* `od`: to display a binary file in a given format
* `strings`: to display ASCII strings in a binary file
* `fold`: to fold long lines for a given width
* `lpr`: to print
* `lpq`: to display the print job queue
* `lprm`: to remove a print job from the queue
* `script`: to record a login session
* `who`: to display who is logged in
* `w`: to display who is logged in and what they are doing
* `uptime`: to show how long the system was running
* `finger`: to lookup user information, last logins etc...
* `pwd`: to show the current directory
* `chmod`: to change file permissions
* `passwd`: to change password
* `tty`: to display user's terminal name
* `jobs`: to list active jobs
* `at`: to run a job for later execution
* `atq`: to list the jobs to be executed later
* `atrm`: to remove a job from the at queue
* `cal`: to display a calendar
* `chown`: to change the owner of a file
* `split`: to split a file into pieces
* `csplit`: to split a file into pieces based on context
* `column`: to columnate lists
* `nohup`: to run a command immune to hangups

* Continuously see the last lines of a file
```bash
tail -f log.file
```

* Skip the first 5 lines of a file
```bash
tail -n +5 ../data/names.txt
```

* To save output and see everything on screen
```bash
gcc *.cc 2>&1 | tee errors.txt
```

* To run a job even after shell exit
```bash
nohup command &
```

* Grep options
```bash
# case insensitive search
grep -i caseinsensitive *
# just show the number of times it was found in a file
grep -c searchedText *
# show lines that don't contain the given text
grep -v unwantedText *
# search for a regex
grep '[0-9]\{7\}' phones.txt
# search compressed files
zgrep searchedText *
```

* awk options
```bash
# print first word
awk '{print $1}' < input

# to print first and last word in a line
awk '{print $1, $NF}' < input

# to reverse all words in a line
awk '{for (i=NF; i>0; i--) {printf "%s ", $i;} printf "\n" }' < input

# to process an awk script
awk -f script.awk < input
```

* awk script to count occurrence of the second word
```
NF > 1 {
    words[$1]++
}
END {
    for (i in words) {
        printf "%s occurs %d times\n", i, words[i]
    }
}
```

* Sort in reverse order
```bash
sort -r ../data/names.txt
```

* sort numeric data
```bash
sort -n ../data/numbers.txt
```

* Remove duplicate lines
```bash
sort -u ../data/duplicates.txt > noDuplicates.txt
# or
sort ../data/duplicates.txt | uniq > noDuplicates.txt
```

* Find all shells used in a system
```bash
cat ../data/passwd | grep -v ^# | cut -d':' -f7 | sort | uniq -c  | sort -rn
```

`grep -v` used to remove comments, lines that start with #. `cut` is used to
select the 7th field, using ':' as a delimiter. Finally `uniq -c` is used
to count each unique sorted value.

* To sort ip addresses
```bash
sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 ../data/ips.txt
```

* Select a particular field from ps
```bash
# tr is used to collapse multiple spaces into a single space
ps -l | tr -s ' ' | cut -f 3 -d ' '
# or easier to do with awk
ps -l | awk '{print $3}'
```

* Convert DOS text files to UNIX files
```bash
tr -d '\r' < input.dos > output.unix
```

* Counting lines, words and characters
```bash
# lines
wc -l ../data/lorem.txt
# words
wc -w ../data/lorem.txt
# characters
wc -c ../data/lorem.txt
```

* Pretty format mangled text
```bash
fmt -w40 ../data/lorem.txt
```

* Configure less with options
```bash
# show line numbers -N
# ignore case -i
# prevent clearing the screen when exiting less -X
# supress all noises -Q
export LESS="-N -i -X -Q"
```

* Commands with less
    - one window forward: `f`
    - Type `100` followed by `z` to change the window size (applies to `f` and `b`)
    - one window backward: `b`
    - Type `100` followed by `w` to change the window size (applies to `f` and `b`)
    - one line forward: `e` or `j`
    - one line backward: `y`
    - Type `100` followed by `d` to move forward 100 lines and 100 lines every time `d` is presed
    - To refresh the file: `r` or `R`
    - To go to beginning: `g`
    - To go to end: `G`
    - To mark a position: `m` + a lower case letter
    - To go to a previously marked position: `'` + the lower case letter
    - Move to a specific position by percentage: Enter a number followed by `p` or `%`
    - Search for text: `/` + type searched text
    - Search backwards for text: `?` + type searched text
    - To load a new file: `:e newFile.txt`
    - To exit: `q` or `Q`

* To view all jobs started from the current shell
```bash
jobs
# to see pids too
jobs -l
```

* To measure the time it takes to run a command
```bash
time command
```

* To format dates
```bash
ISO_8601='%Y-%m-%dT%H:%M:%S%z'
ISO_8601_ALT='%Y-%m-%d %H:%M:%S %Z'
FILENAME_DATE='%Y%m%d%H%M%S'

date "+$ISO_8601"
mv log.file.log "log.file.$(date +$FILENAME_DATE).log"
```

* Get the epoch seconds of now
```bash
date '+%s'
# Epoch seconds are the number of seconds since midnight on January 1, 1970
```

* To create a symbolic link
```bash
ln -s source.file new.symbolick.link
```

* To pipe output of find to ls

But this won't work really well with file names that include whitespace.
In order to solve that you need to change the delimiter used by xargs, but
that won't work on Mac Os X, where the only alternative is to set the delimiter
to '\0' character using `-0` option, and consequently you need to modify the find command to print '\0'
using `-print0`. In Linux, it is much easier using `-d '\n'` command option.
```bash
# on mac os x and linux
find . -name *\.sh* -print0 | xargs -0 ls -lh

# on linux (it is easier)
find . -name *\.sh* | xargs -d '\n' ls -lh
```

* To find and replace the first occurrence of a word in all lines of a file
```bash
sed 's/unix/linux' notes.txt
```

* To find and replace the second occurrence of a word in all lines of a file
```bash
sed 's/unix/linux/g' notes.txt
```

* To find and replace all occurrences of a word in a file
```bash
sed 's/unix/linux/g' notes.txt
```







