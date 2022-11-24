export EDITOR=/usr/bin/vim

# Common alias
alias vmi="vim"
alias vi="vim"
alias ls="ls --color"
alias ll='ls -ltr'
alias grep='grep --color'

# fzf-related config
export BAT_THEME="GitHub"
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--multi --border --height 40%'

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

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# git completion
[ -f ~/dotfiles/git-completion.bash ] && source ~/dotfiles/git-completion.bash

# laptop specific setup
if [ $(hostname) == 'bender' ]; then
    [ -f ~/dotfiles/bashrc_laptop.sh ] && source ~/dotfiles/bashrc_laptop.sh
fi

# laptop Aemet specific setup
if [ $(hostname) == 'bender2' ]; then
    [ -f ~/dotfiles/bashrc_laptop_aemet.sh ] && source ~/dotfiles/bashrc_laptop_aemet.sh
fi

# ecgate specific setup
if [[ $HOSTNAME =~ "ecgb11" ]]; then
  [ -f ~/dotfiles/bashrc_ecgate.sh ] && source ~/dotfiles/bashrc_ecgate.sh
fi

# bologna specific setup
if [[ $HOSTNAME =~ "aa" || $HOSTNAME =~ "ab" || $HOSTNAME =~ "ac" || $HOSTNAME =~ "lfcm" ]]; then
  [ -f ~/dotfiles/bashrc_bologna.sh ] && source ~/dotfiles/bashrc_bologna.sh
fi

