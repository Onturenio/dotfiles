export PS1="\[\033[95;1m\]\u@\h \w\n> \[\033[0m\]"

stty -ixon  # this avoids freezing when pressing C-s in the terminal https://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/radar/SOFTWARE/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/radar/SOFTWARE/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/radar/SOFTWARE/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/radar/SOFTWARE/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate test2
