# If not running interactively, don't do anything
[ -z "$PS1" ] && return
fd=0   # stdin
if ! [[ -t "$fd" || -p /dev/stdin ]]; then
   return
fi
#set -x

# set home to be wherever .bashrc is
export HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# set configdir to be ~/[.]dotfiles
export CONFIGDIR=$HOME;
if [ -d $HOME/dotfiles ]; then
   export CONFIGDIR="$HOME/dotfiles";
else if [-d $HOME/.dotfiles ]; then
   export CONFIGDIR="$HOME/.dotfiles";
fi
fi

export XDG_CONFIG_HOME=$CONFIGDIR

# source system profile scripts
for PROFILEFILE in /etc/profile.d/*.sh; do
   source $PROFILEFILE;
done >/dev/null 2>&1

# environment
export TZ=US/Eastern
export FULLNAME="Fred Smith"
export EMAIL="fred@getsatisfaction.com"
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/coreutils/libexec/gnubin:$PATH:/sbin:/usr/sbin:$HOME/.rvm/bin 

# bash modules

shopt -s autocd &> /dev/null
shopt -s checkwinsize &> /dev/null

#Import ~/.bash modules
if [ -d $CONFIGDIR/bash ]; then
   for BASHMODULE in  $CONFIGDIR/bash/*; do
      source $BASHMODULE;
   done
fi

#Secrets
if [ -f $HOME/.secrets ]; then
   source $HOME/.secrets;
fi


# functions
function rehash { 
   if [ -f $HOME/.bashrc ]; then
      . $HOME/.bashrc
   fi
}

cd

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
