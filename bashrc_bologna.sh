################################################################################
# BOLOGNA specific tweaks for bashrc
################################################################################
alias hpc='ssh -Y hpc-login'
alias ecs='ssh -Y ecs-login'
alias sp0w='ssh -Y sp0w@ecs-login'
alias pn='getent passwd'

export EDITOR=/usr/bin/vim

export PS1="\[\033[91;1m\]\u@\h \w\n> \[\033[0m\]"

# for Ecflow
export ECF_HOST="ecflow-gen-$USER-001"

# OpenAI key
[ -f ~/dotfiles/assistant.sh ] && source ~/dotfiles/assistant.sh

# Options for various applications
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
export R_LIBS_USER="/perm/sp4e/R"
export FZF_DEFAULT_OPTS='--multi --border --height 100%'


# list queues for given user, sp0w by default
function sq {
  if [[ $# == 0 ]]
  then
    user="sp0w"
  else
    user="$1"
  fi

  # invoque FZF to fyzzy-filter jobs
  header='HOST    JOBID PARTITION         NAME     USER      STATE       TIME  NODES NODELIST(REASON)'
  processes=$(_getjobs $user | \
    fzf --ansi --header="$header" --no-sort --preview "_getjobinfo {1} {2}" --bind "ctrl-r:reload(_getjobs $user)" | \
    awk '{print $1, $2}')

  # get PIDs reading from first column in processes
  pids=""
  while
    read line; do
    system=$(echo $line | awk '{print $1}')
    pid=$(echo $line | awk '{print $2}')
    pids="$pids $pid"
  done < <(echo "$processes")

  # ask whether to kill jobs or not
  if [[ "$pids" != " " ]]; then
    read -p "Want me to kill $pids? [y/N]: " flag
    if [[ $flag == 'y' ]]; then
      # killing selected jobs
      while
        read line; do
        system=$(echo $line | awk '{print $1}')
        pid=$(echo $line | awk '{print $2}')
        if [[ $system == "ECS" ]]; then
          host="ecs-login"
        elif [[ $system =~ "HPC" ]]; then
          host="hpc-login"
        fi
        echo killing $pid in $user@$host
        ssh -n $user@$host "scancel $pid"
      done < <(echo "$processes")
    fi
  else
    # nothig was selected
    echo "Nothing selected to be killed"
  fi
}

# auxiliary function to get list of jobs in both ECS and HPC
_getjobs(){
  format="%.10i %.9P %.12j %.8u %.10T %.10M %.6D %R"
  ssh ecs-batch "squeue -o \"$format\" -h -u $1" | awk '{print "\033[;49;34m" "ECS" $0 "\033[0m"}'
  ssh hpc-batch "squeue -o \"$format\" -h -u $1" | awk '{print "\033[;49;91m" "HPC" $0 "\033[0m"}'
}

# auxiliary function to get exhaustive info from a given job
_getjobinfo(){
  if [ $1 = "ECS" ]; then
    var=$(ssh ecs-batch "squeue -j $2 -o %all")
    head=$(echo "$var" | head -1 | tr '\|' '\n' )
    content=$(echo "$var" | tail -1 | tr '\|' '\n')
    paste <(echo "$head") <(echo "$content")
  else
    var=$(ssh hpc-batch "squeue -j $2 -o %all")
    head=$(echo "$var" | head -1 | tr '\|' '\n' )
    content=$(echo "$var" | tail -1 | tr '\|' '\n')
    paste <(echo "$head") <(echo "$content")
  fi
}

# export functions so they are visible for subprocesses
export -f _getjobinfo
export -f _getjobs

# GET ACCESS TO ANACONDA SOFTWARE
activate_anaconda(){
  module load conda
  conda activate vim
}

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



