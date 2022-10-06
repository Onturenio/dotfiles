################################################################################
# ECGATE
################################################################################
export PS1="\[\033[95;1m\]\u@\h \w\n> \[\033[0m\]"
export PERM="/perm/ms/es/sp4e"
export SCRATCH="/scratch/ms/es/sp4e"
alias perm='cd $PERM'

# list queues for given user, sp0w by default
function sq {
  if [[ $# == 0 ]]
  then 
    user="sp0w"
  else
    user="$1"
  fi
  echo "=== ECGATE ==="
  squeue -u $user | sort -k 2; squeue -u $user | grep $user | wc -l
  echo
  echo "=== CCA ==="
  ssh cca "qstat -u $user" | grep --color=never Job ; ssh cca "qstat -u $user" | grep $user | sort -k 10; ssh cca "qstat -u $user"| grep $user  | wc -l
  echo
  echo "=== CCB ==="
  ssh ccb "qstat -u $user" | grep --color=never Job ; ssh ccb "qstat -u $user" | grep $user | sort -k 10; ssh ccb "qstat -u $user" | grep $user | wc -l
}

skgate() {
  local processes=$( \
    squeue -u sp0w | grep -v JOBID \
    | fzf --no-sort  --multi\
    --bind 'ctrl-r:reload(squeue -u sp0w | grep -v JOBID)' \
    --header='Press <TAB> or right-click to select, <CTRL-R> to refresh, <ESC> to quit'\
    | awk '{print $1}')

  for p in $processes; do
    echo killing $p
    ssh sp0w@localhost /usr/local/apps/slurm/18.08.6/bin/scancel $p
  done
}

_getjobs(){
  ssh cca qstat -u sp0w | grep sp0w | awk '{print "CCA", $0}'
  ssh ccb qstat -u sp0w | grep sp0w | awk '{print "CCB", $0}'
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

export -f _getjobinfo
export -f _getjobs


#  # TOOLS TO UPDATE PYTHON 2 TO 3 IN GSREPS
source ~/gSREPS/util/extras/Py2to3/bash_functions_py2topy3.sh

# GET ACCESS TO ANACONDA SOFTWARE
activate_anaconda(){
  export PATH="/perm/ms/es/sp4e/miniconda/bin:$PATH"
  export PS1="(anaconda) $PS1"
}
