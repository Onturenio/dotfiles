set -o vi
export EDITOR=/usr/bin/vim

# Common alias
alias vmi="vim"
alias vi="vim"
alias ls="ls --color"
alias ll='ls -ltr'
alias grep='grep --color'
alias fd='fdfind'

# fzf-related config
export BAT_THEME="GitHub"
export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="--multi --border --height 80%"
# export single_quote="'"
# export FZF_ALT_C_OPTS="--preview $single_quote tree -C {}$single_quote"
# export FZF_CTRL_T_OPTS="--preview $single_quote batcat -n --color=always {}$single_quote --bind $single_quote ctrl-/:change-preview-window(down|hidden|)$single_quote"

# Functions and commands defined elsewhere
# source ~/dotfiles/shell-commands.sh
# source ~/dotfiles/HOSTNAMES

export PS1="\[\033[32;1m\]\u@\h \w\n> \[\033[0m\]"

##########################################################################
# AEMET
##########################################################################
alias neon="ssh -X pn14@neon.aemet.es"
alias sur="ssh -X pn14@sur.aemet.es"
alias cirrus="ssh pn14@cirrus.aemet.es"
alias cirrusdesa="ssh pn14@cirrusdesa.aemet.es"
alias despacho="ssh navarro@172.24.141.44"
alias server_gsreps_admin="ssh admin@172.24.8.92"
alias server_gsreps_gsreps="ssh gsreps@172.24.8.92"

##########################################################################
# ECMWF
##########################################################################
# el centro europeo usa teleport. La idea es que se hace login 1 SOLA VEZ AL
# DIA usando el generador de tokens y con eso ya podemos conectarnos
# directamente desde nuestra máquina hacia ecgate pasando por shell.ecmwf.int.
# Esto es lo que permite usar SSH y SCP, así como port forwarding para usar ecflow_ui
# de forma remota y sin usar contraseñas ni keys durante ese dia

alias ecgate="ssh -Y ecgate"
alias ecs="ssh -Y ecs-login"
alias hpc="ssh -Y hpc-login"
# alias ecflow_forward_sp4e="ssh -J sp4e@shell.ecmwf.int,sp4e@ecgate.ecmwf.int sp4e@ecgb-vecf -C -N -L 19876:ecgb-vecf.ecmwf.int:19876"
# alias ecflow_forward_imp="ssh -J sp4e@shell.ecmwf.int,sp4e@ecgate.ecmwf.int sp4e@ecgb-vecf -C -N -L 3655:ecgb11.ecmwf.int:3655"
# alias ecflow_forward_operativo="ssh -J sp4e@shell.ecmwf.int,sp4e@ecgate.ecmwf.int sp4e@ecgb-vecf -C -N -L 2909:ecgb-vecf.ecmwf.int:2909"
alias ecflow_forward_atos_sp4e="ssh -J sp4e@jump.ecmwf.int,sp4e@hpc-login sp4e@ecflow-gen-sp4e-001 -N -L3141:localhost:3141"
alias ecflow_forward_atos_imp="ssh -J sp4e@jump.ecmwf.int,sp4e@hpc-login sp4e@ecflow-gen-imp-001 -N -L3142:localhost:3141"
alias ecflow_forward_atos_sp0w="ssh -J sp4e@jump.ecmwf.int,sp4e@hpc-login sp4e@ecflow-gen-sp0w-001 -N -L3143:localhost:3141"

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

    if [[ $(which xclip) ]]; then
        echo -n $passwd | xclip -selection clipboard
        echo "TOTP for $user: $passwd (already copied to clipboard)"
    else
        echo "TOTP for $user: $passwd"
    fi
}

######################################################
# Source global definitions.
# This enables using `module load` in HPC
# if [ -f /etc/bashrc ]; then
#     . /etc/bashrc
# fi
######################################################

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# tmux completion
[ -f ~/dotfiles/tmux_completion.bash ] && source ~/dotfiles/tmux_completion.bash

# git completion
[ -f ~/dotfiles/git-completion.bash ] && source ~/dotfiles/git-completion.bash

# conda env switcher with fzf
condaenv() {
    local env=$(conda env list | grep -v '#' | awk '{print $1}' | grep . | fzf --prompt="Select conda env: ")
    if [ -n "$env" ]; then
        conda activate $env
    fi
}

# laptop specific setup
if [ $(hostname) == 'bender' ]; then
    [ -f ~/dotfiles/bashrc_laptop.sh ] && source ~/dotfiles/bashrc_laptop.sh
fi

# laptop Aemet specific setup
if [ $(hostname) == 'bender2' ]; then
    [ -f ~/dotfiles/bashrc_laptop_aemet.sh ] && source ~/dotfiles/bashrc_laptop_aemet.sh
fi

# # desktop Aemet specific setup
if [ $(hostname) == 'AEMET' ]; then
    [ -f ~/dotfiles/bashrc_dektop_aemet.sh ] && source ~/dotfiles/bashrc_dektop_aemet.sh
fi

# bologna specific setup
if [[ $HOSTNAME =~ "aa" || $HOSTNAME =~ "ab" || $HOSTNAME =~ "ac" || $HOSTNAME =~ "ad" || $HOSTNAME =~ "lfcm" ]]; then
  [ -f ~/dotfiles/bashrc_bologna.sh ] && source ~/dotfiles/bashrc_bologna.sh
fi

# generic setup
if [[ $HOSTNAME =~ "pangea" ]]; then
  [ -f ~/dotfiles/bashrc_pangea.sh ] && source ~/dotfiles/bashrc_pangea.sh
fi
