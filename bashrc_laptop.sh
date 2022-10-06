##########################################################################
# Only for my PC
##########################################################################
alias pangea="ssh -X radar@pangea.ogimet.com"
alias cat='batcat --pager "less -RF" --theme=GitHub'
alias vpn='sudo openfortivpn -c ~/.vpnconfig'
alias flexiVDI="~/AEMET/flexvdi-client-3.1.4-x86_64.AppImage"
alias aemet='/home/navarro/SOFTWARE/anaconda3/envs/GDAL/bin/python ~/SOFTWARE/aemet.py'
alias login_shell="tsh login --proxy=shell.ecmwf.int:443"
alias login_jump="tsh login --proxy=jump.ecmwf.int:443"

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

function passwd_INTERNET {
if [[ $# == 0 ]]; then
  gpg -d ~/Dropbox/INTERNET.asc 2> /dev/null | less
  echo "Type \"gpg -ca file\" to encrypt a file in ASCII"
elif [[ $# == 1 ]]; then
  gpg -d ~/Dropbox/INTERNET.asc 2> /dev/null | grep -i $1
else
  echo "Usage passwd_INTERNET [filter]"
fi
}

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
