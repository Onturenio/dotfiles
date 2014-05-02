export EDITOR=/usr/bin/vim

test -s ~/.alias && . ~/.alias || true

alias vmi="vim"
alias vi="vim"
alias ls="ls --color"
alias ll='ls -ltr'

alias bastion="ssh -X gomez@$BASTION"
alias sunray1="ssh -X gomez@$BASTION -L 10001:$SUNRAY1:22 -f sleep 5 ; ssh -X -p 10001 gomez@localhost"
alias hzgpc="ssh -X gomez@$BASTION -L 10002:$HZGPC:22 -f sleep 5 ; ssh -X -p 10002 navarro@localhost"
alias hzgproxy="echo Setup Browser to use SOCKS proxy through port 7777; ssh -t -L7777:127.0.0.1:7778 gomez@$BASTION \"ssh -D7778 -N navarro@$HZGPC\""
alias dkrzproxy="echo Setup Browser to use SOCKS proxy through port 7777; ssh -D7777 g260065@login1.zmaw.de"
alias vpn_unibe_up='sudo /usr/sbin/vpnc VPN2UniBe.conf'
alias vpn_unibe_down='sudo /usr/sbin/vpnc-disconnect'
alias ciclon='ssh -X ciclon.inf.um.es'
alias blz='ssh -X g260065@blizzard.dkrz.de'
alias ubelix='ssh -X jgomez@submit.unibe.ch'
alias phkup300='ssh -X gomez@phkup300'
alias rosa='ssh -X navarro@rosa.cscs.ch'
alias julier='ssh -X navarro@julier.cscs.ch'

function open_sunray2 {
ssh gomez@$BASTION -L 10010:141.4.7.191:22 -f sleep 100
echo "scp -r -P10010 __ gomez@localhost:"
}

function open_HZGPC {
ssh gomez@$BASTION -L 10011:$HZGPC:22 -f sleep 100
echo "scp -r -P10011 __ navarro@localhost:"
}

source ~/dotfiles/shell-commands.sh

if [[ $HOST =~ "rosa" || $HOST =~ "ela" || $HOST =~ "julier" ]]; then 
  export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\u@\h \w\n> \[$(tput sgr0)\]"
fi

if [[ $HOST =~ "linux" ]]; then 
  export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\u@\h \w\n> \[$(tput sgr0)\]"
fi

# Only for my PC
if [[ $HOST =~ "kk" ]]; then 
  source ~/SOFTWARE/cdo-1.6.0/contrib/cdoCompletion.bash
  export PATH="$PATH:/home/navarro/SOFTWARE/cdo-1.6.0/src"
  export PATH="$PATH:/usr/local/texlive/2013/bin/x86_64-linux"
  export PATH="$PATH:/home/navarro/SOFTWARE/MM5"
  export PATH="$PATH:/home/navarro/SOFTWARE/Zotero_linux-x86_64"
fi
