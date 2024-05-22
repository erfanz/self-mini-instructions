# Shell navigation
`Ctrl` + `A`: Go to the beginning of line   
`Ctrl` + `E`: Go to the end of line   
`Ctrl` + `W`: Delete the word _before_ the cursor   
`Ctrl` + `U`: Delete the entire line


# Commands
| Command | Explain | Example |
|----------|----------|----------|
| `for ... do ... done` | for-loop | <pre>for file in *.zip; do <br/>&nbsp;&nbsp;unzip "$file"; <br/>done</pre> <br> one-liner: <pre>sh -c 'for file in *.zip; do unzip "$file"; done'</pre> |
| `watch` | Repeatedly runs a specified command at regular intervals | `watch ps aux \| grep gvi`  |
| `tail -f` | Prints last few lines of a file, and continously prints any new lines | `tail -f filename` |
