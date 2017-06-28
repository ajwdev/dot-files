export GOPATH=$HOME/source/go
export PLAN9=/usr/local/plan9port
export CHEF=/opt/chefdk/bin
export NPM=/usr/local/shared/npm/bin
export PATH=$HOME/nvim-macos/nvim-osx64/bin:$GOPATH/bin:$HOME/.cargo/bin:$CHEF:/usr/local/sbin:/usr/local/bin:$PATH

# XXX plan9port has a program on its PATH called `bundle` so make sure we do
# this after we set the PATH for plan9

# export PATH=$HOME/bin:$PATH

export EDITOR=vim
export JAVA_HOME="$(/usr/libexec/java_home)"

# Dont use cowsay when running ansible playbooks
export ANSIBLE_NOCOWS=1

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
