export EDITOR=/usr/bin/vim

# Common alias
alias vmi="vim"
alias vi="vim"
alias ls="ls --color"
alias ll='ls -ltr'
alias grep='grep --color'

# Alias as shortcut to connect several computers
alias bastion="ssh -X gomez@$BASTION"
alias sunray1="ssh -X gomez@$BASTION -L 10001:$SUNRAY1:22 -f sleep 5 ; ssh -X -p 10001 gomez@localhost"
alias hzgpc="ssh -X gomez@$BASTION -L 10002:$HZGPC:22 -f sleep 5 ; ssh -X -p 10002 navarro@localhost"
alias hzgproxy="echo Setup Browser to use SOCKS proxy through port 7777; ssh -t -L7777:127.0.0.1:7778 gomez@$BASTION \"ssh -D7778 -N navarro@$HZGPC\""
alias dkrzproxy="echo Setup Browser to use SOCKS proxy through port 7777; ssh -D7777 g260065@login1.zmaw.de"
alias ciclon='ssh -X ciclon.inf.um.es'
alias blz='ssh -X g260065@blizzard.dkrz.de'
alias ubelix='ssh -X jgomez@submit.unibe.ch'
alias phkup300='ssh -X gomez@phkup300'
alias rosa='ssh -X navarro@rosa.cscs.ch'
alias julier='ssh -X navarro@julier.cscs.ch'

alias vpn_unibe_up='sudo /usr/sbin/vpnc VPN2UniBe.conf'
alias vpn_unibe_down='sudo /usr/sbin/vpnc-disconnect'

# Prompt setup for CSCS
if [[ $HOST =~ "rosa" || $HOST =~ "ela" || $HOST =~ "julier" ]]; then 
  export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\u@\h \w\n> \[$(tput sgr0)\]"
fi

# Prompt setup for my PC
if [[ $HOST =~ "portatil" || $HOST =~ "linux" ]]; then 
  export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\u@\h \w\n> \[$(tput sgr0)\]"
fi

# Some useful functions 
source ~/dotfiles/shell-commands.sh
source ~/.git-completion.bash

# Only for my PC
if [[ $HOST =~ "linux" || $HOST =~ "port" ]]; then 
  source ~/SOFTWARE/cdo-1.6.0/contrib/cdoCompletion.bash
  export PATH="$PATH:~/SOFTWARE/cdo-1.6.0/src"
  export PATH="$PATH:/usr/local/texlive/2013/bin/x86_64-linux"
  export PATH="$PATH:~/SOFTWARE/MM5"
  export PATH="$PATH:~/SOFTWARE/Zotero_linux-x86_64"
fi

# Only for CSCS
if [[ $HOST =~ "rosa" || $HOST =~ "ela" || $HOST =~ "julier" ]]; then 
  function killalljobs {
  joblist=$(squeue -u $USER | grep -v JOB | awk "{print \$1}" | tr "\n" " ")
  for jobid in $joblist; do 
    scancel $jobid
  done
  }
  alias micola='squeue -u $USER | sort -k 4'
fi
