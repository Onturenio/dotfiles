export EDITOR=/usr/bin/vim

# Common alias
alias vmi="vim"
alias vi="vim"
alias ls="ls --color"
alias ll='ls -ltr'
alias grep='grep --color'

# Functions and commands defined elsewhere
source ~/dotfiles/shell-commands.sh
source ~/.git-completion.bash

##########################################################################
# ALIAS AS SHORTCUT TO CONNECT SEVERAL COMPUTERS:
##########################################################################
# Hamburg
alias bastion="ssh -X gomez@$BASTION"
alias hzgpc="ssh -X gomez@$BASTION -L 10002:$HZGPC:22 -f sleep 5 ; ssh -X -p 10002 navarro@localhost"
alias hzgproxy="echo Setup Browser to use SOCKS proxy through port 7777; ssh -t -L7777:127.0.0.1:7778 gomez@$BASTION \"ssh -D7778 -N navarro@$HZGPC\""
alias dkrzproxy="echo Setup Browser to use SOCKS proxy through port 7777; ssh -D7777 g260065@login1.zmaw.de"
alias mistral='ssh -X g260065@mistral.dkrz.de'
alias sunray1="ssh -X gomez@$BASTION -L 10001:$SUNRAY1:22 -f sleep 5 ; ssh -X -p 10001 gomez@localhost"

# Murcia
alias ciclon='ssh -X ciclon.inf.um.es'
alias huracan='ssh -X huracan.inf.um.es'

# Bern
alias ubelix='ssh -X jgomez@submit.unibe.ch'
alias phkup300='ssh -X gomez@phkup300'
alias dora='ssh -X navarro@dora.cscs.ch'
alias ela='ssh -X navarro@ela.cscs.ch'
alias data='ssh -X gomez@oeschgerstor01.unibe.ch'
alias pilatus='ssh -X navarro@pilatus.cscs.ch'
##########################################################################


##########################################################################
# Only for my PC
##########################################################################
if [[ $HOST =~ "bender" || $HOST =~ "port" ]]; then 
  export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\u@\h \w\n> \[$(tput sgr0)\]"
  source ~/SOFTWARE/cdoCompletion.bash
  export PATH="$PATH:/usr/local/texlive/2013/bin/x86_64-linux"
  export PATH="$PATH:~/SOFTWARE/MM5"
  export PATH="$PATH:~/SOFTWARE/Zotero_linux-x86_64"
  export PATH="$PATH:~/SOFTWARE/shellcheck-master"
  export PATH="$PATH:~/SOFTWARE/anaconda/bin"
  export PATH="$PATH:$HOME/SOFTWARE/local/bin/"

  alias vpn_unibe_up='sudo /usr/sbin/vpnc VPN2UniBe.conf'
  alias vpn_unibe_down='sudo /usr/sbin/vpnc-disconnect'
  alias unibepc='ssh -X gomez@130.92.143.6'
fi

##########################################################################
# Only for CSCS
##########################################################################
if [[ $HOST =~ "rosa" || $HOST =~ "ela" || $HOST =~ "julier" || $HOST =~ "dora" || $HOST =~ "pilatus" ]]; then 
  export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\u@\h \w\n> \[$(tput sgr0)\]"
  function killalljobs {
  joblist=$(squeue -u $USER | grep -v JOB | awk "{print \$1}" | tr "\n" " ")
  for jobid in $joblist; do 
    scancel $jobid
  done
  }
  alias micola='squeue | head -1; squeue -u $USER |grep -v USER| sort -k 4'
  alias workenv='module load cdo netcdf git ncl ncview'
  export RESULT='/project/s584/navarro'
  export PATH="$PATH:~/SOFTWARE"
fi


##########################################################################
# Only for DKRZ
##########################################################################
if [[ $HOSTNAME =~ "mlogin100" ]]; then 
  export PS1="\[$(tput bold)\]\[$(tput setaf 3)\]\u@\h \w\n> \[$(tput sgr0)\]"
  function killalljobs {
  joblist=$(squeue -u $USER | grep -v JOB | awk "{print \$1}" | tr "\n" " ")
  for jobid in $joblist; do 
    scancel $jobid
  done
  }
  alias micola='squeue | head -1; squeue -u $USER |grep -v USER| sort -k 4'
  alias workenv='module load cdo netcdf git ncl ncview'
fi
