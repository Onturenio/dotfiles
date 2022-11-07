################################################################################
# BOLOGNA
################################################################################
alias hpc='ssh -Y hpc-login'
alias ecs='ssh -Y ecs'

export EDITOR=/usr/bin/vim

export PS1="\[\033[91;1m\]\u@\h \w\n> \[\033[0m\]"
export ECF_HOST="ecflow-gen-$USER-001"
# export PERM="/perm/ms/es/sp4e"
# export SCRATCH="/scratch/ms/es/sp4e"

# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
export R_LIBS_USER="/perm/sp4e/R"

# list queues for given user, sp0w by default
function sq {
  if [[ $# == 0 ]]
  then
    user="sp0w"
  else
    user="$1"
  fi
  ssh ecs "squeue -u $user" | sort -k 2; ssh ecs "squeue -u $user" | grep $user | wc -l
}


# skgate() {
#   local processes=$( \
#     squeue -u sp0w | grep -v JOBID \
#     | fzf --no-sort  --multi\
#     --bind 'ctrl-r:reload(squeue -u sp0w | grep -v JOBID)' \
#     --header='Press <TAB> or right-click to select, <CTRL-R> to refresh, <ESC> to quit'\
#     | awk '{print $1}')

#   for p in $processes; do
#     echo killing $p
#     ssh sp0w@localhost /usr/local/apps/slurm/18.08.6/bin/scancel $p
#   done
# }

_getjobs(){
  squeue -h -u sp0w | awk '{print "ECGATE", $0}'
}

_getjobinfo(){
  if [ "$#" -ne 2 ]; then
    echo "There must be 1 argument"
  else
    if [ $1 = "ECGATE" ]; then
      var=$(squeue -j $2 -o %all)
      head=$(echo "$var" | head -1 | tr '\|' '\n' )
      content=$(echo "$var" | tail -1 | tr '\|' '\n')
      paste <(echo "$head") <(echo "$content")
    else
      host=$(echo $1 | awk '{print tolower($0)}')
      ssh $host qstat $2 -f
    fi
  fi
}

sk() {
  local processes=$( \
    _getjobs | fzf --no-sort  --multi \
    --bind 'ctrl-r:reload(_getjobs)' \
    --header='Press <TAB> or right-click to select, <CTRL-R> to refresh, <ESC> to quit' \
    --preview '_getjobinfo {1} {2}' \
    | awk '{print $1, $2}')

  while
    read line; do
    system=$(echo $line | awk '{print $1}')
    pid=$(echo $line | awk '{print $2}')
    if [[ $system = "ECGATE" ]]; then
      echo killing $pid in ECGATE
      echo ssh sp0w@localhost /usr/local/apps/slurm/18.08.6/bin/scancel $pid
    elif [[ $system =~ "CC" ]]; then
      echo killing $pid in $system
      ssh sp0w@cca qdel -Wforce $pid
    fi


      # ssh sp0w@cca qdel -Wforce $p
    done < <(echo "$processes")
}

# GET ACCESS TO ANACONDA SOFTWARE
activate_anaconda(){
  export PATH="/perm/sp4e/miniconda3/bin:$PATH"
  export PS1="(anaconda) $PS1"
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

