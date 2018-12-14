# Purpose of this Project
A set of scripts, documentation, programs for a productive development environment.

* [How to install](#how-to-install)
  * [Aliases](#aliases)
  * [Files and directories](#files-and-directories)
  * [Compressing and Decompressing Files](#compressing-and-decompressing-files)
  * [Encryption/Decryption](#encryptiondecryption)
  * [Displaying system and environment information](#displaying-system-and-environment-information)
  * [Managing simple bash variables](#managing-simple-bash-variables)
  * [Time functions](#time-functions)
  * [Snapshoting directories](#snapshoting-directories)
* [Windows](docs/windows.md)
* [Linux](docs/linux.md)
* [Mac](docs/mac.md)
* [Misc](docs/misc.md)

## How to install
`~/environment/` directory contains where this project resides. In order to use it
you need to include the following in your `~/.profile` or `~/.bashrc` files:

```bash
. ~/environment/start.sh
```

**You can rename `~/environment` to any directory you want**.

**When passing parameters to library functions make sure that you quote them**. For example
```bash
findFiles `*~`
```
If you pass it without quote, bash will expand *~ and pass the matching files to the function, not the
'*~'.

### Environment variables
* **`ENV_HOME_DIR`**: where this project resides
* **`ENV_DATA_DIR`**: always defined as `~/.envData`

### Variables defined in lib.sh
* **`ENV_ARCH`**: either `32` or `64` depending on the architecture of the CPU
* **`ENV_PLATFORM`**: `Mac` or `Linux` or `Cygwin` or `WSL`

### Data directories and files
* `~/.envData/bash`: history file and bashVars.sh file location
* `~/.envData/emacs/backup`: emacs backup files location

### Customizations
Consider looking at the files below for customizations.
```
$ENV_HOME_DIR/etc/aliases.sh
$ENV_HOME_DIR/etc/settings.sh
```

### Local Time Zone
By default, `settings.sh` will attempt to figure out the local time zone, but if it fails
it will use the default value of `LOCAL_TIME_ZONE` which is `Etc/UTC`.
This value is being used in various locations for display purposes. **By default, we set `TZ` to
`Etc/UTC` and prefer to work with UTC mostly**. We use the local time zone in certain locations,
such as the bash prompt. `LOCAL_TIME_ZONE` is also used in certain functions due to limitations
of platforms.

## Aliases

* `lsl`: detailed list of files
* `lsa`: non-detailed list of files
* `sane`: use it when your screen is messed up, can't see what you type
* `reloadEnv`: reread the start.sh, so changes are reflected
* `..`: go one directory up
* `dus`: how much current directory occupies in size
* `duh`: this directory and its direct subdirectories reported
* `paths`: show PATH environment variable as a list of paths
* `localDate`: time and date in local time zone (except on WSL (Linux on Windows))
* `utcDate`: time and date in UTC time zone
* `localTime`: time in local time zone
* `download`: fetch a given url and download it
* `setTitle`: to set a custom title for the terminal window you are working on
* `resetTitle`: to reset the title to its default value
* `enableCore`: to enable cores again (by default it is off)
* `disableCore`: to disable cores again
* `getMd5`: gets the md5 of a given file
* `openResource`: tries to open the given path with the OS's assigned app, if can't open it, it prints on the terminal
* `download`: download a url to a local file (if curl or wget is available)
* `responseHeaders`: shows reponse headers of a given url (only if curl is available)
* `allHeaders`: shows all HTTP headers of a given url (only if curl is available)

## Files and directories

### Finding files by name
```bash
# find all cc files (does not follow symbolic links)
findFiles '*.cc'
```

### Finding files that contain some text
**findGrep and findGrepi skips the following directories: .git, .idea, .svn subdirectories**
```bash
# find all *.sh files that contain word Environment
findGrep Environment '*.sh'
# find all *.sh files that contain word environment in a case-insensitive manner
findGrepi Environment '*.sh'
```

### Removing files
```bash
# remove all class files recursively
removeFiles '*.class'
```

### Displaying the directory tree structure
Display the directory structure for the given path or the current directory in a nice visual way.
```bash
dirTree.sh .
.
.\ .git (ignored)
.| .idea
..\ markdown-navigator
.| bin
.| docs
.| etc
..\ emacs
```

### Finding large files and directories
#### largeDirs.sh
Displays the top 15 directories in terms of disk space they occupy.
Only the direct files are considered, not the contents of its sub directories.

#### largeFiles (function)
Lists the top 15 largest files.

### Finding oversize files
**findOverSize.sh** finds files which are larger than the given size. By default kilobyte is used if no explicit size unit is provided.
For example below it finds all files that are larger than 20 kilobytes.
```bash
findOverSize.sh 20 # 20 kilobytes
```
You can use other size units, namely g or G for gigabytes, m or M for megabytes, k or K for kilobytes.
```bash
findOverSize.sh 20K # 20 kilobytes
findOverSize.sh 20k # 20 kilobytes
findOverSize.sh 20m # 20 megabytes
findOverSize.sh 20M # 20 megabytes
findOverSize.sh 1g # 1 gigabytes
findOverSize.sh 1G # 1 gigabytes
```
You can provide a second argument to narrow the search, e.g. only log files large than 2GB.
```bash
findOverSize.sh 2G "*.log"
```

### Finding recently modified files
**findRecentlyModified.sh** finds recently modified files within a given time frame from now. By default time unit is minutes,
so below it finds recently modified files within the last 2 hours:
```bash
findRecentlyModified.sh 120
```
You can use other time units, namely d or D for days, m or M for minutes and h or H for hours.
```bash
findRecentlyModified.sh 120m # 120 minutes
findRecentlyModified.sh 120M # 120 minutes
findRecentlyModified.sh 120 # 120 minutes
findRecentlyModified.sh 2H # 2 hours
findRecentlyModified.sh 2h # 2 hours
findRecentlyModified.sh 1d # 1 day
findRecentlyModified.sh 1D # 1 day
```

To find specific file names provide a second argument
```bash
findRecentlyModified.sh 2h '*.cc' # all cc files modified within the last 2 hours
```

By default this tool ignores a number of directories documented in the file.

## Compressing and decompressing files
### pack
Compresses a given file or a set of files based on the compression method used.

```bash
pack compressed.tar.gz *
pack compressed.tgz *
pack archive.tar dir1 dir2
pack compressed.tar.bz2 *
pack compressed.zip *
pack compressed.bz2 huge.txt
pack compressed.gz huge.txt
```

### unpack
Decompresses an archive file.

```bash
unpack compressed.tar.gz
unpack archive.tar
unpack compressed.tgz
unpack compressed.zip
unpack compressed.bz2
unpack compressed.gz
```

## Encryption/Decryption
You can use **crypt.sh** script to encrypt/decrypt data.

**To create a private key**
```bash
crypt.sh create privateKey.pem
```

**To extract the public key from the private key**
```bash
crypt.sh public privateKey.pem > publicKey.txt
```

**To encrypt a small size file using the private key**
```bash
crypt.sh encrypt privateKey.pem < shortMesg.txt > shortMesg.enc.bin
```

**To decrypt a small size encrypted file using the private key**
```bash
crypt.sh decrypt privateKey.pem < shortMesg.enc.bin > shortMesg.dec.txt
```

**To encrypt a small size file using the public key**
```bash
crypt.sh encrypt publicKey.txt < shortMesg.txt > shortMesg.pub.enc.bin
# You can decrypt this file only with a privateKey
crypt.sh decrypt privateKey.pem < shortMesg.pub.enc.bin > shortMesg.dec.txt
```
You can't encrypt with a private key and decrypt with a public key using crypt.sh

**Sign a data file with your private key**
```bash
crypt.sh sign privateKey.pem < test.txt > signature.file
```

**Verify a signature of data file with a public key**
```bash
crypt.sh verify publicKey.txt signature.file < test.txt
```

**Add a password to a private key file**
```bash
crypt.sh add privateKey.pem > protectedPrivate.pem
```

**Remove a password from a password protected private key file**
```bash
crypt.sh remove protectedPrivate.pem > privateKey.pem
```

**Generate a secret key**
```bash
crypt.sh generate 32 > secretKey.txt
```

**Encrypt a big message using a secret key file**
```bash
crypt.sh encrypt secretKey.txt < bigMesg.txt > enc.txt
```

**Decrypt an encrypted message using a secret key file**
```bash
crypt.sh decrypt secretKey.txt < enc.txt > bigMesg.txt
```

**Encrypt a big message using a password**
```bash
crypt.sh encrypt < bigMesg.txt > enc.txt
```

**Decrypt an encrypted message using a password**
```bash
crypt.sh decrypt < enc.txt > bigMesg.txt
```

## Displaying system and environment information
Displays general system information which includes

* Platform: Cygwin, Linux, Mac, WSL (Linux on Windows)
* env home directory
* env data directory
* Whether IP is up or not
* Whether HTTP is working or not
* Whether DNS is working or not
* IP address (not very reliable though)
* If remotely connected, SSH client ip address
* Distro name and version
* CPU count, model and speed
* Total memory
* Free memory and its percentage
* CPU Load
* Kernel version
* For each file system available space and use percentage

## Managing simple bash variables
**manageVars.sh** is used to manage variables in **$ENV_DATA_DIR\bash\bashVars.sh** file.
This file is a set of key value pairs where
each key is a variable exported by default. For example, say there is a long host name for a dev
machine you regularly use. Instead of typing the host name everytime, you can set dev to this
dev machine's host name. This way you can quickly ssh by simply doing `ssh $dev` assuming you
set dev to the machine's host name. This file is automatically included in each bash session.

* `-l`: to list all variable names and their values
* `-a varName 'varValue'`: to add the given varName with the varValue
* `-d varName`: to delete the varName

**Keep the var names and var values simple**

## Time functions
### toEpoch
Convert a date to epoch number.
```bash
toEpoch `date`
```

### fromEpoch
Converts an epoch number to date
```bash
fromEpoch 1543786787
```

## Snapshoting directories
**snapshot.sh** allows you to take a snapshot (backup) of a directory you are working
on. This is a rather crude version control system, where you simply keep copies
of a directory. By default, it compresses the directory into a compressed archive,
but you can tell snapshot.sh not to compress by passing `-n` flag.

```bash
# snapshots the current directory and saves a copy in the parent directory
snapshot.sh
snapshot.sh .
snapshot.sh . ..
# deletes all snapshots in the parent directory
snapshot.sh -d . ..
# lists all snapshots in the parent directory
snapshot.sh -l . ..
# deletes all snapshots in the parent directory and takes a single snapshot
snapshot.sh -s . ..
# you can provide any path to source and target
snapshot.sh ~/my.big.fat.project /backups
# do not compress (simply create a copy of the directory)
snapshot.sh -n . ..
```



