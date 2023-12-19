#### configuration ecflow commands ####
export ecflow_host="ecflow-gen-sp0w-001"
export ecflow_port="3141"
export python_script="/home/sp4e/dotfiles/query_server_fzf.py"

alias ec_view='ec_command --command "view" --suite'
alias ec_suspend='ec_command --command --suspend --header "Select nodes to suspend" --suite'
alias ec_resume='ec_command --command --resume --header "Select nodes to resume" --suite'
alias ec_kill='ec_command --command --kill --header "Select nodes to kill" --suite'
alias ec_complete='ec_command --command "--force=complete recursive" --header "Select nodes to set to complete" --suite'
alias ec_requeue='ec_command --command "--requeue force" --header "Select nodes to requeue" --suite'
alias ec_defcomplete='ec_command --command "--alter change defstatus complete" --header "Select nodes to set Default Status complete" --suite'
alias ec_defqueued='ec_command --command "--alter change defstatus queued" --header "Select nodes to set Default Status queued" --suite'
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
  header='HOST    JOBID  PART               NAME     USER      STATE       TIME #NODES NODELIST(REASON)'
  processes=$(_getjobs $user | \
    fzf --ansi --header="$header" --no-sort --exact +i --preview "_getjobinfo {1} {2}" --bind "ctrl-r:reload(_getjobs $user)" | \
    awk '{print $1, $2}')

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
  format="%.10i %.5P %.18j %.8u %.10T %.10M %.6D %R"
  # ssh ecs-batch "squeue -o \"$format\" -h -u $1" | awk '{print "\033[;49;34m" "ECS" $0 "\033[0m"}' | sed "s#\x1B\(\[;49;[0-9][0-9]m\)\(.*\)RUNNING\(.*\)#\x1B\1\2\x1B[;49;32mRUNNING\x1B\1\3#"
  # ssh hpc-batch "squeue -o \"$format\" -h -u $1" | awk '{print "\033[;49;91m" "HPC" $0 "\033[0m"}' | sed "s#\x1B\(\[;49;[0-9][0-9]m\)\(.*\)RUNNING\(.*\)#\x1B\1\2\x1B[;49;32mRUNNING\x1B\1\3#"
  ssh ecs-batch "squeue -o \"$format\" -h -u $1" | awk '{print "\033[1;49;34mECS\033[0m" $0}' \
      | sed "s#RUNNING#\x1B[;49;32mRUNNING\x1B[0m#"\
      | sed "s#COMPLETING#\x1B[;49;33mCOMPLETING\x1B[0m#" \
      | sed "s#PENDING#\x1B[;49;36mPENDING\x1B[0m#"

  ssh hpc-batch "squeue -o \"$format\" -h -u $1" | awk '{print "\033[1;49;91mHPC\033[0m" $0}' \
      | sed "s#RUNNING#\x1B[;49;32mRUNNING\x1B[0m#"\
      | sed "s#COMPLETING#\x1B[;49;33mCOMPLETING\x1B[0m#" \
      | sed "s#PENDING#\x1B[;49;36mPENDING\x1B[0m#"
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

# general template function to build Ecflow commands
function ec_command() {
  suite=""
  command=""
  header=""
  host=$ecflow_host
  port=$ecflow_port

  if [[ $# == 0 ]]; then
    echo "Usage: ec_command [--host <host>] [--port <port>] [--header <header>] --suite <suite> --command <command>"
    return 0
  fi

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
      --suite)
        if [[ $# -gt 1 ]]; then
          suite=$2
          shift 2
        else
          echo "No suite specified. Provide partial name to use fuzzy search"
          return 0
        fi
        ;;
      --command)
        command=$2
        shift 2
        ;;
      --header)
        header=$2
        shift 2
        ;;
      -h|--help)
        echo "Usage: ec_command [--host <host>] [--port <port>] [--header <header>] --suite <suite> --command <command>"
        return 0
        ;;
      *)
        echo "Unknown option $1"
        return 0
        ;;
    esac
  done

  if [[ "$suite" == "" ]]; then
    echo "No suite specified. Use --suite <suite>"
    return 0
  fi

  if [[ "$command" == "" ]]; then
    echo "No command specified. Use --command <command>"
    echo $@
    return 0
  fi

  if [[ "$header" == "" ]]; then
    header="Select nodes to $command"
  fi

  # echo "Running $command on $suite with host $host and port $port"
  # return 0
  #

  python_query="$python_script $suite --host $host  --port $port"

  processes=$($python_query | fzf --reverse --ansi --exact +i --header="$header" --bind "ctrl-r:reload($python_query)"  | \
    awk '{print $1}')

  if [[ "$command" == "view" ]]; then
    return 0
  fi

  if [[ "$processes" == "" ]]; then
    echo "Nothing selected"
    return 0
  fi

  while read line; do
    echo ecflow_client --host $ecflow_host --port $ecflow_port $command $line
    ecflow_client --host $ecflow_host --port $ecflow_port $command $line
  done < <(echo "$processes")
}

