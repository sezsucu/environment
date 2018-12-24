## Shell Commands
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
* `fg`: brings the most recent job to the foreground
* `at`: to run a job for later execution
* `atq`: to list the jobs to be executed later
* `atrm`: to remove a job from the at queue
* `cal`: to display a calendar
* `chown`: to change the owner of a file
* `split`: to split a file into pieces
* `csplit`: to split a file into pieces based on context
* `column`: to columnate lists
* `nohup`: to run a command immune to hangups
* `pkill`: send a signal to a program based on a given name or a pattern
* `pgrep`: list pids of a program based on a given name or a pattern
* `ssh`: ssh client
* `scp`: transfer files between a local host and a remote host
* `base64`: base64 encode/decode data
* `ping`: ping an ip address or host
* `uuidgen`: to generatae a uuid
* `bc`: calculator
* `script`: to record terminal session
* `scriptreplay`: to replay a recoded terminal session
* `md5`: md5 on mac os x
* `md5sum`: md5 on linux
* `sha1sum`: sha1 on linux
* `gpg`: openPGP encryption and signing tool
* `mktemp`: to create or generate temp files or file names

## Command Examples
* To generate salted passwords
```bash
openssl passwd -1 -salt 78891234 mySecretPassword
$1$78891234$.caUJ9QS3PL8.xulIOLok1
```

* To verify a md5 checksum of a file
```bash
md5sum * > all_files_md5.txt
# this will verify each file and output OK or FAILED for each one
md5sum -c all_files_md5.txt
# find all md5s under the current directory
find /path/to/dir -name ".git" -prune -o -type f -print0 | xargs -0 md5sum >> dir.md5
md5sum -c dir.md5
```

* To verify a sha1 checksum of a file
```bash
sha1sum * > all_files_sha1.txt
# this will verify each file and output OK or FAILED for each one
sha1sum -c all_files_sha1.txt
# find all sha1s under the current directory
find /path/to/dir -name ".git" -prune -o -type f -print0 | xargs -0 sha1sum >> dir.sha1
sha1sum -c dir.sha1
```

* To calculate something quick
```bash
bc <<< '2 + 3'
```

* To redirect stderr to a specific file
```bash
cmd 2>stderr.txt 1>stdout.txt
```

* TO generate a uuid
```bash
uuidgen
# to generate a time-based UUID
uuidgen -t
# uppercase letters
uuidgen | tr [a-z] [A-Z]
```

* To sanitize file names
```bash
# replace any character that is not in the list with an underscore
echo 'fileName' | sed -e 's/[^A-Za-z0-9._-]/_/g'
```

* ping until it is a success
```bash
while ! ping host.name &> /dev/null; do
    echo "Pinging"
done
```

* Send a signal based on a name
```bash
pkill emacs # by default SIGTERM is sent
pkill -9 emacs # sends a SIGKILL
pkill -i emacs # case insensitive
```

* Continuously see the last lines of a file
```bash
tail -f log.file
# filter out
tail -f log.file | grep somePattern
# follow the new file if logs are rotated regularly
tail -F log.file | grep somePattern
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

* Check if a file is sorted
```bash
sort ../data/names.txt | sort -C
echo $? # 0 means it is sorted, otherwise not sorted
```

* Sort population data for a specific year
```bash
# sort by 2017
sort -t ',' -nrk 58 population.csv  | awk -F',' '{print $1, $58}'
# sort by 1960
sort -t ',' -nrk 2 population.csv  | awk -F',' '{print $1, $2}'
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

* Convert DOS text files to UNIX files by deleting \r character
```bash
tr -d '\r' < input.dos > output.unix
```

* To squeeze multiple consecutive occurrences of a character into a single one
```bash
# replaces runnings of a space with a single space
tr -s ' ' < input
# remove extra empty lines
tr -s '\n' < input
```

* Character classes
  * `alnum`
  * `alpha`
  * `cntrl`
  * `digit`
  * `graph`
  * `lower`
  * `print`
  * `punct`
  * `space`
  * `upper`
  * `xdigit`


* Convert a tab character to a single space
```bash
tr '\t' ' ' < input
```

* Delete all chars not in set1
```bash
echo "|hello 1234 |"| tr -c 'a-z|' ' '
|hello      |
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

* To print specific fields from ../data/passwd
```bash
cut -d':' -f1,6,7 ../data/passwd
# to find the most popular shell
grep -v '^#' ../data/passwd | cut -d':' -f7 | sort | uniq -c | sort -rn
# to rearrange fields
grep -v '^#' ../data/passwd | awk 'BEGIN {FS=":"; OFS="\t"; } { print $1, "->",  $7,$6; }'
```

* To grep the matching parts only
```bash
# just grep the ip addresses (not lines)
egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' ../ips.txt
```

* To compress whitespace
```bash
# will compress multiple consecutive whitespaces into a single whitespace
cat ../data/withLotsOfSpace.txt | tr -s ' ' ' '
```

* To display a file in a user specified format
```bash
# output the given binary file in hexadecimal shorts
od -x < binaryFile.bin
```

* To display ASCII strings in a file
```bash
strings < binaryFile.bin
```

* To display a file with long lines fitted into a given width
```bash
fold -w80 /path/to/file
```

* To generate ssh key pairs
```bash
ssh-keygen -v -t rsa -b 4096 -C 'My New Key'
```

* To ssh without password
```bash
# create key-pair using ssh-keygen
ssh-keygen -v -t rsa -b 4096 -C 'My New Key'
# append ~/.ssh/id_rsa.pub into ~/.ssh/authorized_keys file
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# make sure that ~/.ssh is readable by you only
# drwx------   4 username  group 128 Aug 30 22:52 .ssh
# make sure that ~/.ssh/id_rsa is readable by you only
# 8 -rw-------  1 username  group   3.2K Aug 30 22:55 id_rsa
# run ssh-agent
eval `ssh-agent`
# check if everything is running smoothly
set | grep SSH
# should see SSH_AGENT_PID and SSH_AUTH_SOCK
# add ssh identity
ssh-add
# how to kill the ssh-agent
# eval `ssh-agent -k`
```

* To run a script on a remote server without copying the script file there
```bash
# encode in base64 and decode it and run it on the other server
# -w0 to disable line wrapping
command=$(base64 -w0 myScript.sh)
ssh user@remotehost "echo $command | base64 -d | bash"
```

* Important manual sections
    - user commands: 1
    - system calls: 2
    - subroutines: 3
    - devices: 4
    - file formats: 5
    - games: 6
    - miscellaneous: 7
    - system administration: 8
    - kernel: 9
    - new: 10

```bash
# shows passwd from section 5
man 5 passwd
# shows passwd from section 1
man passwd
```

* Essential directories
    - /bin: essential commands
    - /dev: device files (disk drives, terminals, printers)
    - /etc: machine-local system config files
    - /etc/opt: add-on software config files
    - /etc/X11: X Window System config files
    - /home: user home directories
    - /Users: user home directories on Mac OS X
    - /lib: shared libraries
    - /lib/modules: loadable kernel modules
    - /mnt: mount point for temporary file systems
    - /opt: add-on software packages
    - /proc: kernel and process info
    - /root: home directory of root
    - /sys: device pseudofilesystem
    - /tmp: temporary files
    - /usr/bin: most user commands
    - /usr/include: C header files
    - /usr/lib: libraries
    - /usr/local: locally important files
    - /usr/sbin: system admin files
    - /usr/share: architecture independent data
    - /usr/share/doc: documentation
    - /usr/share/info: gnu info
    - /usr/share/man: manuals
    - /usr/src: source code
    - /var: variable data
    - /var/log: log data
    - /var/spool: spooled application data

* setuid and setgid permissions: when an executable file has setuid permission set, running it
takes the privileges of the file's owner

* Hard links can only be created within the same file system, soft links can not be easily moved around
```bash
echo "abc" > real.txt
ln real.txt hard.txt
ln -s real.txt soft.txt
more hard.txt
> abc
more soft.txt
> abc
mv soft.txt /tmp
more /tmp/soft.txt
> /tmp/soft.txt: No such file or directory
mv hard.txt /tmp
more /tmp/hard.txt
> abc
```

* To run a command for later execution. Notice that TZ variable effects at utility too,
so if you set TZ to UTC your time will change too.
```bash
at 11:53 am
ls > ~/fileList.txt
[CTRL-D]
job 4 at Thu Oct  4 11:53:00 2017
# see the queue
atq
4	Thu Oct  4 11:53:00 2017
# remove the job
atrm 4
# to start service if not running
sudo service atd start
sudo service atd stop
# on mac os x
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.atrun.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.atrun.plist
```

* To show a calendar of a month
```bash
# for current month
cal
    October 2018
Su Mo Tu We Th Fr Sa
    1  2  3  4  5  6
 7  8  9 10 11 12 13
14 15 16 17 18 19 20
21 22 23 24 25 26 27
28 29 30 31

# for a specific Month
cal November 2015
   November 2015
Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30
```

* To number each line
```bash
cat -n file.txt | more
```

* To squeeze blank lines into single blank lines
```bash
cat -s file.txt | more
```

* To display tabs
```bash
cat -t file.txt
```

* To make sure xargs correctly processes its input and prompt before executing each command.
```bash
echo 'one two three' | xargs -p touch
touch one two three?...
# press y for yes
```

* To run multiple commands with xargs, use `-I` flag. So xargs executes the commands for each line in the input.
```bash
cat args.txt | xargs -I % sh -c 'echo %; mkdir %'
```

* To display only repeated lines in a file
```bash
uniq -d
```

* To display only non-repeated lines in a file
```bash
uniq -u
```

* To ignore case when using uniq
```bash
uniq -i
```

* To convert lower case letters to upper case letters
```bash
tr “[:lower:]” “[:upper:]” < real.txt
```

* To convert braces into parenthesis
```bash
tr '{}' '()' < real.txt
```

* To squueze repetition of a character or character set from a file
```bash
tr -s [:space:] ' ' < real.txt
# any repetition of a, b, or c will be compressed into the character 'a'
# e.g. cbbabbabbccc will become a
tr -s [abc] 'a' < real.txt
```

* To delete a character or a set of characters from a file
```bash
tr -d [:space:] < real.txt
```

* To compare two files
```bash
cmp file1.txt file2.txt
```

* To compare two files but only set the process exit code
```bash
cmp -s file1.txt file2.txt
```

* To create a patch and apply. [A good tutorial](https://linuxacademy.com/blog/linux/introduction-using-diff-and-patch/)
```bash
diff -urN originalFile.txt updatedFile.txt > my.patch
patch originalFile.txt -i my.patch -o updatedFile.txt
# or in place patching
patch --verbose originalFile.txt < my.patch
```

* To split a file into equal pieces
```bash
split file
```

* To split a file into a given number of lines each
```bash
split -l 50 ../data/population.csv segment_
# segment_aa segment_ab ...
```

* To split a file into a given number of bytes each
```bash
# use numeric suffixes, use 4 suffix length e.g. 0000
split -b 32768 ../data/population.csv -d -a 4 segment_
```

* To dump the contents of a file in character format
```bash
od -c input.file
# no offset info
od -An -c input.file
# jump 1000 bytes and show in hexadecimal format
od -j1000 -x input.file
```

* To get the first, second and third fields from population.csv file
```bash
cat ../data/population.csv | cut -d ',' -f1,2,3
```

* Merge multiple files into one file
```bash
cat file1 file2 file3 > merged.file
```

* To squeeze multiple adjancent blank lines into a single blank line
```bash
cat -s input.file
```

* To display tab characters as ^I
```bash
cat -T input.file
```

* To display line numbers
```bash
cat -n input.file
```

* To record and replay screen commands
```bash
script -t 2> timing.log -a output.session
# then do whatever you want and finally type exit
exit
# to replay it
scriptreplay timing.log output.session
# it will play everything and then exit by itself
```

* Finding files
```bash
# find all files and directories under current directory
find . -print
# find all files and directories under current directory, follow symbolic links
find -L . -print
# find all files and do an ls using xargs
find . -type f -print0 | xargs -0 ls -l
# using regular expressions
find . -regex '.*\(\.java\|\.sh\)$'
# using regular expressions, ignore the case
find . -iregex '.*\(\.java\|\.sh\)$'
# find based on file's name
find . \( -name '*.txt' -o -name '*.md' \) -print
# find based on file's name ignoring the case
find . \( -iname '*.txt' -o -iname '*.md' \) -print
# find based on a file's path's name
find . \( -path '*/text/*' -o -name '*.md' \) -print
# find all files that are NOT named *.txt
find . ! -name "*.txt" -print
# just direct children of the current directory
find . -maxdepth 1 -print
# minimum 2 directory deep
find . -mindepth 2 -print
# based on access time within the last 7 days
find . -atime -7 -print
# based on modification time exactly 7 days old
find . -mtime 7 -print
# based on modification time within the last 7 minutes
find . -mmin -7 -print
# based on creation time that is more than 7 minutes old
find . -cmin +7 -print
# find all files that were modified more recently than input.file
find . -type f -newer input.file -print
# find all files greater than 2 Megabytes
find . -type f -size +2M
# find all files less than 2 kilobytes
find . -type f -size -2M
# find all files that is exactly 2 bytes
find . -type f -size 2b
# find all files that have the exact permission
find . -type f -perm 644 -print
# find all files owned by a specific user
find . -type f -user root -print
# delete all found files
find . -type f -name "*.mwd" -delete
# executing a command on each found file
find . -type f -user root -exec chown user1 {} \;
# if the command accepts multiple arguments use + to speed up
find . -type f -user root -exec chown user1 {} +
# to concatenate all files into a single file
find . -name "*.txt" -exec cat {} > everything.txt \;
# copy files older than 10 days to a backup directory
find . -type f -mtime +10 -exec cp {} /backup \;
# to use multiple commands for each file, store multiple commands in a script file
find . -type f -mtime +10 -exec multi_command.sh \;
# to .git directory
find . -name ".git" -prune -o -type f -print
# move all movies to a single directory
find . -name "*.mov" -exec mv {} /path/to/targetDir \;
```

* Use xargs to split input into items and run a command for each one of them
```bash
# by default xargs will echo the input
cat ../data/names.txt | xargs
# change the delimiter
cat ../data/names.txt | xargs -d ' '
cat ../data/names.txt | xargs -d 'i'
# change the number of items to process per command invocation
cat ../data/names.txt | xargs -n 5
# if there are white spaces in the input, use -print0 in the find and -0
find . -name "*.txt" -print0 | xargs -0 grep Joe
# to make xargs call the command with a formatted argument
# below xargs will call myCommand.sh for each item in the input
# with "-p item -l" arguments
find . -name "*.txt" -print0 | xargs -0 -I {} myCommand.sh -p {} -l
find . -name "*.txt" -print0 | xargs -0 -I ^ myCommand.sh -p ^ -l
# count the number of shell script lines
find . -name "*.sh" -print0 | xargs -0 wc -l
```

* To generate a temporary file name without creating one
```bash
fileName=$(mktemp -u /tmp/testing.XXXXXX)
```

* To create a temporary directory, rather than a file
```bash
dirPath=$(mktemp -d /tmp/testDir.XXXXXXX)
```
