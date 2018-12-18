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

* Continuously see the last lines of a file
```bash
tail -f log.file
```

* Skip the first 5 lines of a file
```bash
tail -n +5 file.txt
```

* To save output and see everything on screen
```bash
gcc *.cc 2>&1 | tee errors.txt
```


