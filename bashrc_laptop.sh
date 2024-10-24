##########################################################################
# Only for my PC
##########################################################################
alias pangea="ssh -X radar@pangea.ogimet.com"
# alias cat='batcat --pager "less -RF" --theme=GitHub'
alias vpn='sudo openfortivpn -c ~/.vpnconfig'
alias vpn_proxy='ssh -D 8080 -N onturenio@192.168.1.174'
alias flexiVDI="~/AEMET/flexvdi-client-3.1.4-x86_64.AppImage"
alias aemet='/home/navarro/SOFTWARE/anaconda3/envs/GDAL/bin/python ~/SOFTWARE/aemet.py'
alias login_shell="tsh login --proxy=shell.ecmwf.int:443"
alias login_jump="tsh login --proxy=jump.ecmwf.int:443"
alias md2pdf="docker run --rm -v .:/documentation meteo-documentation:latest md2pdf.sh"




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
export PATH="$PATH:$HOME/SOFTWARE/local/bin/"
# export PATH="$PATH:$HOME/SOFTWARE/"

stty -ixon  # this avoids freezing when pressing C-s in the terminal https://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator

# CUDA environment variables
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
#

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

# activate copilot CLI
# eval "$(github-copilot-cli alias -- "$0")"

conda activate AEMET2

# create OPENAI_API_KEY
source ~/dotfiles/assistant.sh

function REPL {
    options=("assistant" "meteoradar" "TEST3")
    choice=$(printf '%s\n' "${options[@]}" | fzf --prompt="Select environment: ")

    if [[ $choice == "assistant" ]]; then
        cd ~/METEORED/CHATBOT
        conda activate assistant
        ipython
    elif [[ $choice == "TEST3" ]]; then
        cd ~/METEORED/CHATBOT
        conda activate TEST3
        ipython
    elif [[ $choice == "meteoradar" ]]; then
        cd ~/METEORED/METEORADAR
        conda activate meteoradar
        ipython
    fi
}
#
#
# powerline-shell
# function _update_ps1() {
#     PS1="$(powerline-shell $? )"
# }

# if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#     PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi

function ollama_docker() {
    if [[ "$1" == "up" ]]; then
        # Reinicia el módulo nvidia_uvm
        sudo rmmod nvidia_uvm && sudo modprobe nvidia_uvm
        # Llama a docker-compose para levantar los servicios
        docker compose -f "/home/navarro/dotfiles/start_ollama_webui.yaml" up -d
    elif [[ "$1" == "down" ]]; then
        # Llama a docker-compose para destruir los servicios
        docker compose -f "/home/navarro/dotfiles/start_ollama_webui.yaml" down
    else
        echo "Error: La opción de comando inválida. Uso: llama_docker [up|down]"
    fi
}
