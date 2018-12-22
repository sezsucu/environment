# Ubuntu

## Packages needed
```bash
sudo apt-get update
sudo apt-get install emacs25
sudo apt-get install git
sudo apt-get install python
sudo apt-get install xdg-utils
sudo apt-get install curl
sudo apt-get install unzip
sudo apt install python-pip
```

## Packages nice to have
```bash
sudo apt-get install g++
sudo apt install npm
sudo apt-get install tmux
```

## Install Apps
* [Chrome](https://askubuntu.com/questions/510056/how-to-install-google-chrome)
* [Intellij IDEA](https://www.jetbrains.com/idea/download/#section=linux)

# Commands
* `watch`: to execute a program periodically and show its output fullscreen
* `tmux`: run multiple terminals at the same time, switch between them easily
* `pidof`: find the process id(s) of the given program
* `paste`: merge multiple lines into a single file

## Command Examples
* to list all available services
```bash
service --status-all
systemctl -l --type service --all
systemctl -r --type service --all
/etc/init.d
```

* merge multiple lines into a single line
```bash
# 3 lines into a single line
cat ../data/population.csv | cut -d ',' -f1,2,3 | paste - - -
# 2 lines into a single line
cat ../data/population.csv | cut -d ',' -f1,2,3 | paste - -
```

* watch command can be a life saver
```bash
# see the top 5 processes every 4 seconds
watch -n 4 "ps aux | sort -nrk 3,3 | head -n 5"
```

* pidof by default displays one or more pids of a given program
```bash
pidof commandName
# to display just one pid
pidof -s commandName
```

* To see version info
```bash
cat /etc/*-release
more /proc/version
uname -a
```

## tmux
* Default command prefix is `Ctrl-b`, I changed it to `Ctrl-Space`

### Outside the tmux
* Create a new session `tmux`
* Create a new session with a name `tmux new -s "My New Session"`
* Attach to a currently existing session `tmux attach`
* Attach to a named session `tmux attach -t "My New Session"`
* Kill all sessions `tmux kill-server`
* Kill a named session `tmux kill-session -t "Mt New Session"`
* List all sessions `tmux ls`
* Attach to a specific session `tmux attach -t 0`

### Inside the tmux
* Detach from tmux `tmux detach`
* Kill all sessions `tmux kill-server`

#### Using keyboard
* Detatch from tmux `Ctrl-Space-d`
* Create a window within the same session `Ctrl-Space-c`
  * To move between windows `Ctrl-Space-p` (previous) or `Ctrl-Space-n` (next)
  * To jump to a specific window `Ctrl-Space-[0-9]`
  * To choose a window or pane from a list `Ctrl-Space-w`
  * `exit` to close the window
  * `Ctrl-Space-&` to kill all processes in an unresponive window
* Split the window `Ctrl-Space-%` or `Ctrl-Space-"`
  * To move between panes `Ctrl-Space-o`
  * To switch to another pane `Ctrl-Space-arrow key`
  * To zoom in on a pane `Ctrl-Space-z`
  * To zoom out on a pane `Ctrl-Space-z`
* To switch to another session `Ctrl-Space-(` or `Ctrl-Space-)`
* Type `exit` to kill a pane or a window or a session

#### Resizing panes
* `Ctrl-Space-:` to go to command mode in tmux
* Assuming we are on the top pane
    * `resize-pane -U 2` to move the separator up 2 lines
    * `resize-pane -D 2` to move the separator down 2 lines
* Assuming we are on the left pane
    * `resize-pane -L 2` to move the separator left 2 lines
    * `resize-pane -R 2` to move the separator right 2 lines



