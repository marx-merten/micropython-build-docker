export RSHELL_PORT=$(rshell -l | awk -F ': ' '{ print $2 }'|fzf)
echo New port: $RSHELL_PORT
