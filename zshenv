export DOCKER_SCAN_SUGGEST=false
export ANSIBLE_NOCOWS=1
export GOPATH=$HOME
# export GO111MODULE=on
export GOPRIVATE=stash.corp.netflix.com
# export AWS_DEFAULT_REGION=us-west-1

export BAT_THEME=OneHalfDark


if command -v nvim &>/dev/null; then
  export EDITOR=$(which nvim)
  alias vim=nvim
  export NVIMRC=$HOME/.config/nvim/init.lua
else
  export EDITOR=$(which vim)
fi
# TODO Do I need this?
export SVN_EDITOR=$EDITOR

export PATH=/opt/homebrew/bin:$PATH

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

eval "$(rbenv init -)"
export PATH=$HOME/.rbenv/bin:$PATH

export PLAN9=$HOME/src/9fans/plan9port
# TODO Clean this up
# PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH:$HOME/.cargo/bin:$PLAN9/bin export PATH
export PATH=$HOME/bin:/opt/wasi-sdk-12.0/bin:/usr/local/sbin:/usr/local/bin:$HOME/.cargo/bin:$PATH


[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
. "$HOME/.cargo/env"

export PATH=/opt/nflx:/opt/nflx/bin:$PATH
