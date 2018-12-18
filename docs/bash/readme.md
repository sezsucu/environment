# Examples

## [file_type.sh](file_type.sh)
* if then
* case statement
* function
* readability check
* file pattern matching in if expression

## [list_files.sh](list_files.sh)
* iterating files in a directory
* arrays
* array size
* directory check
* size of a file
* find command
* basename of a path
* for loop

## [list_dirs.sh](list_dirs.sh)
* iterating directories in a directory
* arrays
* array size
* directory check
* size of a file
* find command
* basename of a path
* for loop
* error for when no value is provided for an argument

## [line_no.sh](line_no.sh)
* reading a file line by line
* arrays
* printf
* while loop
* for loop

## [capitalize.sh](capitalize.sh)
* tr to capitalize
* character processing of a string
* argument processing

## [recognize.sh](recognize.sh)
* regular expressions
* shows

## [can_i_drive.sh](can_i_drive.sh)
* if expressions
* read answer from user

## [check_env_vars.sh](check_env_vars.sh)
* environment variable
* -z to check if a variable is defined or has zero length
* -n to check if a variable has non-zero length

## [file_access.sh](file_access.sh)
* find root path of the running script
* return a value from a function
* dirname of a path

## [daemon.sh](daemon.sh)
* trap signals
* send signals
* append to a file
* while infinite loop
* get file size
* crude logging
* nohup use for daemonizing
* getting process id, pid
* -z to check if a variable is defined
* remove any aliasing (e.g. \mv)
* check the status of a previously run program ($?)

## [guess_my_number.sh](guess_my_number.sh)
* random number generation
* modulus operator
* regular expressions
* argument processing using getopts
* showing help
* read with a timeout
* check $? for timeout of read
* prompt with read

## [dedup.sh](dedup.sh)
* making a temporary file name or directory
* detecting platform
* iterating files in a directory
* cleaning up at the exit of the program

## [random.sh](random.sh)
* using /dev/urandom
* fold output for a specific width
* use of uuidgen

## [sort_by_size.sh](sort_by_size.sh)
* sort numerically
* sort in reverse order
* arrays (adding, looping)
* declaring arrays
* iterating files
* use of IFS

## [quiz.sh](quiz.sh)
* select loop
* until loop

## [string_info.sh](string_info.sh)
* string length
* string concatenation
* string last char removal
* string first char removal
* building comma separated list

## [unquote.sh](string_info.sh)
* -n to test if string is non-zero length
* conditional last char removal
* condition first char removal

## [debug.sh](debug.sh)
* debugging bash script
* set -x and set +x

## [analyze_data.sh](analyze_data.sh)
* IFS to process comma separated files
* processing a file using io redirection in a while loop
* reading a line into an array using IFS
* you can't do float arithmetic in bash, you can do division though

## [builtin_data.sh](builtin_data.sh)
* read from here documents
* a mini ascii art
* processing data from here documents
* adding to an array
* printing contents of an array

# Notes

* To avoid alias
```bash
\ls -l
```

* To avoid shell expansion and substitution use single quotes
```bash
echo 'Hello, the item is 10$!'
```

* To redirect standard error to standard output
```bash
program 2>&1
```

* To discard error output or direct it to a specific file
```bash
program 2> /dev/null
gcc *.cc 2> errors.txt
```

* To direct both standard error and standard output to the same file
```bash
program >& everything.txt
```

* To run multiple commands and direct their output all at once
```bash
( program1; program2; program3 ) > output.txt
```

