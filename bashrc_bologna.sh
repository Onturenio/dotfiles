################################################################################
# BOLOGNA specific tweaks for bashrc
################################################################################
alias sp0w='ssh -Y sp0w@ecs-login'
alias zes2_ecs='ssh -Y zes2@ecs-login'
alias zes2_hpc='ssh -Y zes2@hpc-login'
alias pn='getent passwd'

if [[ $(scontrol show config | grep ClusterName) =~ "ecs" ]]; then
    export ECS_HPC="ECS"
else
    export ECS_HPC="HPC"
fi

export EDITOR=/usr/bin/vim

# export PS1="\[\033[91;1m\]\u@\h \w\n> \[\033[0m\]"
export PS1="\[\033[91;1m\]\u@${ECS_HPC} \w\n> \[\033[0m\]"

# for Ecflow
export ECF_HOST="ecflow-gen-$USER-001"

# OpenAI key
[ -f ~/dotfiles/assistant.sh ] && source ~/dotfiles/assistant.sh

# Options for various applications
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
export R_LIBS_USER="/perm/sp4e/R"
export FZF_DEFAULT_OPTS='--multi --border --height 100%'

######################################################
# Source global definitions.
# This enables using module load in HPC
# if [ -f /etc/bashrc ]; then
#     . /etc/bashrc
# fi
######################################################

# GET ACCESS TO ANACONDA SOFTWARE
# activate_anaconda(){
#   module load conda
#   conda activate vim
# }

# include NODE in the path
export PATH="~/SOFTWARE/NODE/bin:$PATH"
export PATH="~/SOFTWARE/bin:$PATH"

# Ecflow commands
source ~/dotfiles/commands_monitor.sh

compare_grib(){
  if [[ $# != 2 ]]; then
    echo "Usage: compare_grib file1 file2"
    return 1
  fi
  vimdiff <(grib_dump -O $1) <(grib_dump -O $2)
}



