dot_file_dir = "/Users/andrew/dot-files"
puts "#{File.dirname(File.expand_path(__FILE__))}"

%w{
  gitconfig
  gitignore_global
  screenrc
  slate
  ssh/config
  tmux.conf
  vim
  vimrc
  zshenv
  zshrc
}.each do |dst|
  link "/Users/andrew/.#{dst}" do
    to "#{dot_file_dir}/#{dst}"
  end
end
