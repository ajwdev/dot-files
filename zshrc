DIRSTACKSIZE=5
HISTSIZE=4000
SAVEHIST=4000
HISTFILE=~/.history

bindkey -e

setopt APPEND_HISTORY     # Append to history file instead of overwriting
setopt EXTENDED_HISTORY   # Save timestamps in history
setopt HIST_IGNORE_DUPS   # Dont save command in history if its a duplicate of the previous command
setopt HIST_NO_STORE      # don't save history cmd in history

setopt AUTO_CD            # cd if no matching command
setopt AUTOPUSHD          # Turn cd into pushd for all situations
setopt PUSHD_IGNORE_DUPS  # Don't push multiple copies of the same directory onto the directory stack
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT  # Sort numerically first, before alpha
setopt NOMATCH            # Raise error if a glob did not match files instead passing that string back as an argument
setopt PRINT_EXIT_VALUE   # Print status code on non-zero returns
setopt MULTIOS            # Allow multiple redirection operators
setopt CORRECT            # Try to correct the spelling of commands
#setopt CORRECT_ALL        # Try to correct the spelling of all arguments in a line
setopt LIST_TYPES         # Show file types in list

# XXX Not sure about these yet
setopt PROMPT_SUBST
setopt PROMPT_PERCENT
#setopt HASH_CMDS # save cmd location to skip PATH lookup

unsetopt BEEP NOTIFY

autoload -U select-word-style
select-word-style bash

zmodload zsh/complist
autoload -Uz compinit
compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:manuals' separate-sections true

#
# Aliases
#
if [[ $(uname -s) == "Darwin" ]]; then
  alias sed=gsed
  alias awk=gawk
  alias find=gfind
  alias tar=gtar

  # If MacVim is installed, use that binary
  # Prioritize version in home directory if possible
  if [ -f "$HOME/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
      alias vim="nocorrect $HOME/Applications/MacVim.app/Contents/MacOS/Vim"
  elif [ -f "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
      alias vim="nocorrect /Applications/MacVim.app/Contents/MacOS/Vim"
  fi
fi

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -lha'
alias less='less -R'  # Send raw ascii control codes (ex: colors)

alias bex='nocorrect bundle exec'
alias knife='nocorrect /opt/chefdk/bin/knife'
alias kitchen='nocorrect /opt/chefdk/bin/kitchen'
alias chef='nocorrect /opt/chefdk/bin/chef'

alias ..='pushd ..'
alias ....='pushd ../..'
alias ......='pushd ../../..'

alias gh="open \`git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/:/\//' -e 's/git@/http:\/\//'\`"
alias _join='ruby -e "puts STDIN.readlines.map(&:strip).join"'

#
# Functions
#
function gethostbyname() {
  python -c "import socket; print socket.gethostbyname('${1}')"
}

function webserver {
  port="${1:-3000}"
  ruby -r webrick -e "s = WEBrick::HTTPServer.new(:Port => $port, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start"
}

function _errno {
  cpp -dM /usr/include/errno.h | grep 'define E' | sort -n -k 3
}

if [[ $(uname -s) == "Darwin" ]]; then
  function profile-userspace {
    if [ -z "${1}" ]; then
      echo "Please specify an application name" >&2
      return 1
    fi
    sudo dtrace -n "profile-97 /execname == \"${1}\"/ { @[ustack()] = count(); }"
  }

  function notify {
    osascript -e "display notification 'Done: "$@"' with title '$@'"
  }
fi

alias kc='kubectl'
function ksecret {
  kubectl get secrets ${1} -o "go-template={{index .data \"${2}\"}}" | base64 -D -
}


#
# Prompt
#
autoload -Uz promptinit
promptinit

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' actionformats '(%F{2}%b%F{3}|%F{1}%a%f)'
zstyle ':vcs_info:*' formats       '(%F{2}%b%f)'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
precmd () { vcs_info }

[ $UID != 0 ] && PS1=$'[%{\e[1;32m%}%n:%l %{\e[1;34m%}%2~%{\e[00m%}]${vcs_info_msg_0_}%(1j.|%j|.)$ '

eval "$(rbenv init -)"

# source <(kubectl completion zsh)

source /usr/local/share/zsh/site-functions/_docker
source ~/.zshrc.local

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/andrew/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/andrew/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/andrew/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/andrew/google-cloud-sdk/completion.zsh.inc'; fi

source /usr/local/etc/profile.d/z.sh
