##########################################################################
# Only for my PC
##########################################################################
alias pangea="ssh -X radar@pangea.ogimet.com"
alias cat='batcat --pager "less -RF" --theme=GitHub'

source ~/SOFTWARE/cdoCompletion.bash
source ~/SOFTWARE/gmt_completion.bash
export PATH="$PATH:/home/navarro/SOFTWARE/texlive/2020/bin/x86_64-linux"
export MANPATH="$MANPATH:/home/navarro/SOFTWARE/texlive/2020/texmf-dist/doc/man/:/home/navarro/SOFTWARE/local/share/man"
export INFOPATH="$INFOPATH:/home/navarro/SOFTWARE/texlive/2020/texmf-dist/doc/man/"
export PATH="$PATH:~/SOFTWARE/MM5"
export PATH="$PATH:~/SOFTWARE/Zotero_linux-x86_64"
export PATH="$PATH:~/SOFTWARE/shellcheck-master"
export PATH="$PATH:~/SOFTWARE/eccodes/bin"
# export PATH="$PATH:~/SOFTWARE/anaconda/bin"
# export PATH="$PATH:$HOME/SOFTWARE/local/bin/"
# export PATH="$PATH:$HOME/SOFTWARE/"

stty -ixon  # this avoids freezing when pressing C-s in the terminal https://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator


# added by Anaconda3 5.3.1 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/navarro/SOFTWARE/anadonda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/navarro/SOFTWARE/anadonda3/etc/profile.d/conda.sh" ]; then
alias cat='batcat --pager "less -RF" --theme=GitHub'
# . "/home/navarro/SOFTWARE/anadonda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/navarro/SOFTWARE/anadonda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/navarro/SOFTWARE/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/navarro/SOFTWARE/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/navarro/SOFTWARE/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/navarro/SOFTWARE/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate AEMET
