## Fonts
* [Consolas](https://docs.microsoft.com/en-us/typography/font-list/consolas)
* [Inconsolata](http://www.levien.com/type/myfonts/inconsolata.html)

## Markdown
* [Markdown cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
* [Markdown Syntax](https://daringfireball.net/projects/markdown/syntax)

## tmux
* Default command prefix is `Ctrl-b`, I changed it to `Ctrl-Space`

### Outside the tmux
* Create a new session `tmux`
* Attach to a currently existing session `tmux attach`
* Kill all sessions `tmux kill-server`
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
