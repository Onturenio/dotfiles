# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf vi-mode docker)

source $ZSH/oh-my-zsh.sh
unsetopt inc_append_history
unsetopt share_history

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
# VI_MODE_SET_CURSOR=true
#
#
# Get API keys for IA
source ~/dotfiles/assistant.sh

##########################################################################
# AEMET
##########################################################################
alias neon="ssh -X pn14@neon.aemet.es"
alias sur="ssh -X pn14@sur.aemet.es"
alias cirrus="ssh cirrus"
alias cirrusdesa="ssh cirrusdesa"
alias despacho="ssh despacho"
alias gsreps_sscc_admin="ssh gsreps_sscc_admin"
alias gsreps_sscc_gsreps="ssh gsreps_sscc_gsreps"
alias gsreps_exp_it="ssh gsreps_exp_it"

ftp_ecmwf () {
    echo "Recall user sp4e and TOTP password"
    ftp sp4e@boaccess.ecmwf.int
}

##########################################################################
# ECMWF
##########################################################################
# el centro europeo usa teleport. La idea es que se hace login 1 SOLA VEZ AL
# DIA usando el generador de tokens y con eso ya podemos conectarnos
# directamente desde nuestra máquina hacia ecgate pasando por shell.ecmwf.int.
# Esto es lo que permite usar SSH y SCP, así como port forwarding para usar ecflow_ui
# de forma remota y sin usar contraseñas ni keys durante ese dia

# alias eclogin="tsh login --proxy=jump.ecmwf.int"
# alias ecs="ssh -Y ecs-login"
# alias hpc="ssh -Y hpc-login"

# alias ecflow_forward_sp4e="ssh -J sp4e@shell.ecmwf.int,sp4e@ecgate.ecmwf.int sp4e@ecgb-vecf -C -N -L 19876:ecgb-vecf.ecmwf.int:19876"
# alias ecflow_forward_imp="ssh -J sp4e@shell.ecmwf.int,sp4e@ecgate.ecmwf.int sp4e@ecgb-vecf -C -N -L 3655:ecgb11.ecmwf.int:3655"
# alias ecflow_forward_operativo="ssh -J sp4e@shell.ecmwf.int,sp4e@ecgate.ecmwf.int sp4e@ecgb-vecf -C -N -L 2909:ecgb-vecf.ecmwf.int:2909"
# alias ecflow_forward_atos_sp4e="ssh -J sp4e@jump.ecmwf.int,sp4e@hpc-login sp4e@ecflow-gen-sp4e-001 -N -L3141:localhost:3141"
# alias ecflow_forward_atos_imp="ssh -J sp4e@jump.ecmwf.int,sp4e@hpc-login sp4e@ecflow-gen-imp-001 -N -L3142:localhost:3141"
# alias ecflow_forward_atos_sp0w="ssh -J sp4e@jump.ecmwf.int,sp4e@hpc-login sp4e@ecflow-gen-sp0w-001 -N -L3143:localhost:3141"
# alias ecflow_forward"=ssh -v -C -N -D 9050 -J sp4e@jump.ecmwf.int sp4e@hpc-login"



function ecflow {
    # Manejo de señales para cerrar el túnel si se interrumpe el script
    trap 'kill $SSH_PID 2>/dev/null; exit' INT TERM EXIT

    # Check if certificate is valid
    tsh status --proxy jump.ecmwf.int >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Teleport certificate is not valid. Trying to get one..."
        eclogin
    else
        echo "Teleport certificate is valid"
    fi
    (

        # Launch ecflow_ui in the background
        ecflow_ui -pc4 &

        # Save the PID of the ecflow_ui process
        EC_FLOW_PID=$!

        # Launch the SSH tunnel also in the background
        ssh -C -N -D 9050 -J sp4e@jump.ecmwf.int sp4e@hpc-login &

        # Save the PID of the SSH process
        SSH_PID=$!

        # Wait for the ecflow_ui process to finish
        wait $EC_FLOW_PID

        # If ecflow_ui finishes, kill the SSH process
        kill $SSH_PID 2>/dev/null
    ) > ecflow.log 2>&1 &
}

function ecs {
    # Checl if certificate is valid
    tsh status --proxy jump.ecmwf.int >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Teleport certificate is not valid. Trying to get one..."
        eclogin
    else
        echo "Teleport certificate is valid"
    fi
    ssh -Y ecs-login
}

function hpc {
    # Checl if certificate is valid
    tsh status --proxy jump.ecmwf.int >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Teleport certificate is not valid. Trying to get one..."
        eclogin
    else
        echo "Teleport certificate is valid"
    fi
    ssh -Y hpc-login
}

# get token for ECMWF using oathtool
function ectoken {
    if [[ ! -f ~/dotfiles/token_ecmwf ]]; then
        echo "ERROR: token_ecmwf not found"
        return 1
    fi
    if [[ ! $(which oathtool) ]]; then
        echo "ERROR: oathtool not found"
        return 1
    fi

    if [[ $1 == "sp4e" ]] || [[ $1 == "" ]] ; then
        sha1=$(awk '/sp4e/ {print $2 $3, $4, $5, $6, $7, $7, $8, $9}' ~/dotfiles/token_ecmwf)
        user="sp4e"
    elif [[ $1 == "sp0w" ]] ; then
        sha1=$(awk '/sp0w/ {print $2 $3, $4, $5, $6, $7, $7, $8, $9}' ~/dotfiles/token_ecmwf)
        user="sp0w"
    else
        echo "ERROR: user not found"
        return 1
    fi
    passwd=$(oathtool -b --digits=6 --totp=sha1 "$sha1")

    # if [[ $(which xclip) ]]; then
    #     echo -n $passwd | xclip -selection clipboard
    #     echo "TOTP for $user: $passwd (already copied to clipboard)"
    # else
        # echo "TOTP for $user: $passwd"
    # fi
    echo $passwd | pbcopy
    echo "TOTP for $user: $passwd"
}


# Common alias
alias vmi="vim"
alias vi="vim"
alias ls="ls --color"
alias ll='ls -ltr'
alias grep='grep --color'

##########################################################################
# Only for my PC
##########################################################################
alias pangea="ssh -X radar@pangea.ogimet.com"
# alias cat='batcat --pager "less -RF" --theme=GitHub'
alias vpn='sudo openfortivpn -c ~/.vpnconfig'
alias proxy_sur='ssh -D 8080 -N pn14@172.24.9.20'
alias flexiVDI="~/AEMET/flexvdi-client-3.1.4-x86_64.AppImage"
alias md2pdf="docker run --rm -v .:/documentation meteo-documentation:latest md2pdf.sh"

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

# Ollama in docker
function webui() {
    if [[ "$1" == "up" ]]; then
        # Reinicia el módulo nvidia_uvm
        docker compose -f "/Users/navarro/dotfiles/start_webui.yaml" up -d
    elif [[ "$1" == "down" ]]; then
        # Llama a docker-compose para destruir los servicios
        docker compose -f "/Users/navarro/dotfiles/start_webui.yaml" down
    else
        echo "Error: La opción de comando inválida. Uso: webui [up|down]"
    fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# fast switch between conda environments
function REPL {
    local options=("assistant" "meteoradar")
    local choice=$(printf '%s\n' "${options[@]}" | fzf --prompt="Select environment: ")

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

# conda env switcher with fzf
condaenv() {
    local env=$(conda env list | grep -v '#' | awk '{print $1}' | grep . | fzf --prompt="Select conda env: ")
    if [ -n "$env" ]; then
        conda activate $env
    fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source ~/dotfiles/AI.sh
