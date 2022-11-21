################################################################################
# BOLOGNA specific tweaks for bashrc
################################################################################
alias hpc='ssh -Y hpc'
alias ecs='ssh -Y ecs'
alias sp0w='ssh -Y sp0w@ecs'
alias micola='sq sp4e'

export EDITOR=/usr/bin/vim

export PS1="\[\033[91;1m\]\u@\h \w\n> \[\033[0m\]"

# for Ecflow
export ECF_HOST="ecflow-gen-$USER-001"

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
  ssh ecs-login "squeue -o \"$format\" -h -u $1" | awk '{print "\033[;49;34m" "ECS" $0 "\033[0m"}'
  ssh hpc-login "squeue -o \"$format\" -h -u $1" | awk '{print "\033[;49;91m" "HPC" $0 "\033[0m"}'
}

# auxiliary function to get exhaustive info from a given job
_getjobinfo(){
  if [ $1 = "ECS" ]; then
    var=$(ssh ecs-login "squeue -j $2 -o %all")
    head=$(echo "$var" | head -1 | tr '\|' '\n' )
    content=$(echo "$var" | tail -1 | tr '\|' '\n')
    paste <(echo "$head") <(echo "$content")
  else
    var=$(ssh hpc-login "squeue -j $2 -o %all")
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
  # export PATH="/perm/sp4e/miniconda3/bin:$PATH"
  # export PS1="(anaconda) $PS1"
  module load conda
  conda activate vim
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/perm/sp4e/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/perm/sp4e/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/perm/sp4e/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/perm/sp4e/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

