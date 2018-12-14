## Fonts
* [Consolas](https://docs.microsoft.com/en-us/typography/font-list/consolas)
* [Inconsolata](http://www.levien.com/type/myfonts/inconsolata.html)

## Markdown
* [Markdown cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
* [Markdown Syntax](https://daringfireball.net/projects/markdown/syntax)

## Python
* `pip install requests` on Windows or Cygwin
* `sudo pip install requests` on Linux or MacOs X

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

