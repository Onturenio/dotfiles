alias pangea="ssh -X radar@pangea.ogimet.com"
alias cat='batcat --pager "less -RF" --theme=GitHub'
alias vpn='sudo openfortivpn -c ~/.vpnconfig'
alias flexiVDI="~/AEMET/flexvdi-client-3.1.4-x86_64.AppImage"
# alias aemet='/home/navarro/SOFTWARE/anaconda3/envs/GDAL/bin/python ~/SOFTWARE/aemet.py'
alias login_shell="tsh login --proxy=shell.ecmwf.int:443"
alias login_jump="tsh login --proxy=jump.ecmwf.int:443"

export PATH="$PATH:/opt/texlive/2022/bin/x86_64-linux"
export MANPATH="$MANPATH:/opt/texlive/2022/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:/opt/texlive/2022/texmf-dist/doc/info"
# export PATH="$PATH:~/SOFTWARE/Zotero_linux-x86_64"

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate AEMET
