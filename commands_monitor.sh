#### configuration ecflow commands ####
export ecflow_host="ecflow-gen-sp0w-001"
export ecflow_port="3141"
export python_script="/home/sp4e/dotfiles/query_server_fzf.py"

alias micola='sq sp4e'
alias miec='ec --host ecflow-gen-sp4e-001 --port 3141'

# alias ec_view='ec_command --command "view" --suite'
# alias ec_suspend='ec_command --command --suspend --header "Select nodes to suspend" --suite'
# alias ec_resume='ec_command --command --resume --header "Select nodes to resume" --suite'
# alias ec_kill='ec_command --command --kill --header "Select nodes to kill" --suite'
# alias ec_complete='ec_command --command "--force=complete recursive" --header "Select nodes to set to complete" --suite'
# alias ec_requeue='ec_command --command "--requeue force" --header "Select nodes to requeue" --suite'
# alias ec_defcomplete='ec_command --command "--alter change defstatus complete" --header "Select nodes to set Default Status complete" --suite'
# alias ec_defqueued='ec_command --command "--alter change defstatus queued" --header "Select nodes to set Default Status queued" --suite'
#### end configuration ecflow commands ####


# list queues for given user, sp0w by default
function sq {
  if [[ $# == 0 ]]
  then
    user="sp0w"
  else
    user="$1"
  fi

  # invoque FZF to fyzzy-filter jobs
  header='HOST    JOBID  PART               NAME     USER      STATE       TIME #NODES     NODELIST(REASON) TASK'
  processes=$(_getjobs $user | \
    # fzf --ansi --header="$header" --no-sort --exact +i --preview "_getjobinfo {1} {2}" --preview-window=down,2,wrap --bind "F5:reload(_getjobs $user)" | \
    # awk '{print $1, $2}')
    fzf --ansi --header="$header" --no-sort --exact +i --bind "F5:reload(_getjobs $user)" | awk '{print $1, $2}')

  # get PIDs reading from first column in processes
  pids=""
  while read line; do
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
  format="%.10i %.5P %.18j %.8u %.10T %.10M %.6D %.20R %o"
  # ssh ecs-batch "squeue -o \"$format\" -h -u $1" | awk '{print "\033[;49;34m" "ECS" $0 "\033[0m"}' | sed "s#\x1B\(\[;49;[0-9][0-9]m\)\(.*\)RUNNING\(.*\)#\x1B\1\2\x1B[;49;32mRUNNING\x1B\1\3#"
  # ssh hpc-batch "squeue -o \"$format\" -h -u $1" | awk '{print "\033[;49;91m" "HPC" $0 "\033[0m"}' | sed "s#\x1B\(\[;49;[0-9][0-9]m\)\(.*\)RUNNING\(.*\)#\x1B\1\2\x1B[;49;32mRUNNING\x1B\1\3#"
  ssh ecs-batch "squeue -o \"$format\" -h -u $1" | awk '{print "\033[;49;34mECS\033[0m" $0}' \
      | sed "s#RUNNING#\x1B[;49;32mRUNNING\x1B[0m#"\
      | sed "s#COMPLETING#\x1B[;49;33mCOMPLETING\x1B[0m#" \
      | sed "s#PENDING#\x1B[;49;36mPENDING\x1B[0m#" \
      | sed 's#\(.*\ \).*\(/gSREPS_AI.*\).job.*#\1\2#'

  ssh hpc-batch "squeue -o \"$format\" -h -u $1" | awk '{print "\033[;49;91mHPC\033[0m" $0}' \
      | sed "s#RUNNING#\x1B[;49;32mRUNNING\x1B[0m#"\
      | sed "s#COMPLETING#\x1B[;49;33mCOMPLETING\x1B[0m#" \
      | sed "s#PENDING#\x1B[;49;36mPENDING\x1B[0m#" \
      | sed 's#\(.*\ \).*\(/gSREPS_AI.*\).job.*#\1\2#'
}

# auxiliary function to get exhaustive info from a given job
# _getjobinfo(){
#   if [ $1 = "ECS" ]; then
#     var=$(ssh ecs-batch "squeue -j $2 -o %all")
#     head=$(echo "$var" | head -1 | tr '\|' '\n' )
#     content=$(echo "$var" | tail -1 | tr '\|' '\n')
#     paste <(echo "$head") <(echo "$content")
#   else
#     var=$(ssh hpc-batch "squeue -j $2 -o %all")
#     head=$(echo "$var" | head -1 | tr '\|' '\n' )
#     content=$(echo "$var" | tail -1 | tr '\|' '\n')
#     paste <(echo "$head") <(echo "$content")
#   fi
# }

_getjobname(){
  if [ $1 = "ECS" ]; then
    var=$(ssh ecs-batch "squeue -j $2 -o %o" | grep -v COMMAND)
  else
    var=$(ssh hpc-batch "squeue -j $2 -o %o" | grep -v COMMAND)
  fi

  if [[ $var == "" ]]; then
    echo "Job not running"
  else
    echo $var | awk '{print $1}'
  fi
}

_searchjob(){
    if [[ $@ =~ "suite" ]]; then
        echo "Suite Node, no job to search"
        return 0
    elif [[ $@ =~ "family" ]]; then
        echo "Family Node, no job to search"
        return 0
    elif [[ ! $@ =~ "active" ]]; then
        echo "Inactive Node, no job to search"
        return 0
    fi
    jobname=$(echo $2 | awk '{print $1}')
    jobs=$(_getjobs $1 | grep $jobname)
    if [[ $jobs == "" ]]; then
        echo -e "\033[;49;31mJOB NOT FOUND!!!\033[0m"
    else
        echo -e "\033[;49;32mJob found in queue\033[0m"
    fi
}
export -f _searchjob

# export functions so they are visible for subprocesses
# export -f _getjobinfo
# export -f _getjobname
export -f _getjobs

# rm -rf ~/kk.txt
 # general template function to build Ecflow commands
function ec_command() {
  command=""
  tasks=""
  host=$ecflow_host
  port=$ecflow_port

  if [[ $# == 0 ]]; then
    echo "Usage: ec_command [--host <host>] [--port <port>] --command <command> task1 task2 ..."
    return 1
  fi

  while [[ $# -gt 0 ]]; do
    # echo "\$1" $1 >> ~/kk.txt
    case "$1" in
      --host)
        host=$2
        shift 2
        ;;
      --port)
        port=$2
        shift 2
        ;;
      --command)
        command=$2
        shift 2
        ;;
      -h|--help)
        echo "Usage: ec_command [--host <host>] [--port <port>] --command <command> task1 task2 ..."
        return 0
        ;;
      *)
        # check if command matches gSREPS
        for word in $1; do
          if [[ "$word" =~ "/" ]]; then
            tasks="$tasks $word"
          fi
        done
        shift 1
        ;;
    esac
  done

  echo "tasks: $tasks"

  if [[ "$command" == "" ]]; then
    echo "No command specified. Use --command <command>"
    echo $@
    return 0
  fi

  case $command in
    suspend)
        command="ecflow_client --host $host --port $port --suspend"
        ;;
    resume)
        command="ecflow_client --host $host --port $port --resume"
        ;;
    kill)
        command="ecflow_client --host $host --port $port --kill"
        ;;
    complete)
        command="ecflow_client --host $host --port $port --force=complete recursive"
        ;;
    requeue)
        command="ecflow_client --host $host --port $port --requeue force"
        ;;
    defcomplete)
        command="ecflow_client --host $host --port $port --alter change defstatus complete"
        ;;
    defqueued)
        command="ecflow_client --host $host --port $port --alter change defstatus queued"
        ;;
    *)
      echo "Unknown command $command"
      return 1
      ;;
  esac

  # echo "tasks: $tasks" >> ~/kk.txt

  for task in $tasks; do
    # echo $command $task >> ~/kk.txt
    $command $task
  done
}
export -f ec_command

function ec(){
  host=$ecflow_host
  port=$ecflow_port

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --host)
        host=$2
        shift 2
        ;;
      --port)
        port=$2
        shift 2
        ;;
      -h|--help)
        echo "Usage: ec [--host <host>] [--port <port>]"
        return 0
        ;;
      *)
        echo "Unknown option $1"
        return 1
        ;;
    esac
  done

  # get_suites="$python_script --host $host --port $port --color"

  # $get_suites > ~/suite.list
  # _getjobs sp0w > ~/jobs.list

  _refresh $host $port sp0w | fzf --reverse --ansi --exact +i \
    --bind "f5:reload(_refresh $host $port sp0w)" \
    --bind "ctrl-s:execute(ec_command --host $host --port $port --command suspend {+})" \
    --bind "ctrl-r:execute(ec_command --host $host --port $port --command resume {+})" \
    --bind "ctrl-k:execute(ec_command --host $host --port $port --command kill {+})" \
    --bind "ctrl-c:execute(ec_command --host $host --port $port --command complete {+})" \
    --bind "ctrl-q:execute(ec_command --host $host --port $port --command requeue force {+})" \
    --bind "ctrl-d:execute(ec_command --host $host --port $port --command defcomplete {+})" \
    --bind "ctrl-f:execute(ec_command --host $host --port $port --command defqueued {+})" \
    --bind 'ctrl-z:change-preview-window(50%|2)' \
    --header="F5:refresh c-s:suspend c-r:resume c-k:kill c-c:complete c-q:requeue c-d:defcomplete c-f:defqueued c-z:preview" \
    --preview "_build_preview" --preview-window=down,2,wrap \
    > /dev/null
}

    # --preview "_searchjob sp0w {}" --preview-window=down,1,wrap \
function _refresh(){
    if [[ $# -lt 3 ]]; then
        echo "Usage: _refresh <host> <port> <user>"
        return 1
    fi
    _getjobs $3 > ~/jobs.list
    $python_script --host $1 --port $2 --color | grep -v \#suite | tee ~/suite.list
}
export -f _refresh

function _consistency(){
    jobs=$(awk '{print $10}' ~/jobs.list)
    tasks=$(awk '(/active/ || /submitted/) && /task/ {print $1}' ~/suite.list | sed -r "s/\x1B\[[0-9;]*[a-zA-Z]//g")
    for task in $tasks; do
        # echo $task
        if [[ ! $jobs =~ $task ]]; then
            echo -e "$task not found in queue"
        fi
    done
}
export -f _consistency

function _build_preview(){
    wrong=$(_consistency)
    if [[ $wrong != "" ]]; then
        echo -e "\033[;49;31mInconsistencies found\033[0m"
        echo -e "\033[;49;31m$wrong\033[0m"
    else
        echo -e "\033[;49;32mConsistency OK\033[0m"
    fi
}
export -f _build_preview


