# NOTE This should be run with chef-apply

### Install same packages on all platforms
package 'ack'
package 'cowsay'
package 'ctags'
package 'docker'
package 'docker-machine'
package 'jq'
package 'nmap'
package 'socat'
package 'tmux'
package 'xz'
package 'zsh'

case node['platform_family']
when 'mac_os_x'
  # Install GNU toolchain
  package 'binutils'
  package 'coreutils'
  package 'findutils'
  package 'gawk'

  package 'moreutils'
  package 'macvim'
  # TODO Version check?
  package 'xhyve'

  # Caskroom packages

  go_pkg = 'go'
when 'fedora'
  go_pkg = 'golang'
end

# Install Golang
package go_pkg

# Install Rustup

# Install Rbenv
