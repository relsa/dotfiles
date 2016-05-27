# zshrc
[ -f ~/.zshrc ] && rm ~/.zshrc
ln -s ~/dotfiles/_zshrc ~/.zshrc

# zshrc alias
[ -f ~/.zshrc.alias ] && rm ~/.zshrc.alias
ln -s ~/dotfiles/_zshrc.alias ~/.zshrc.alias

# zplug
if [ -d ~/.zplug ]; then
  rm ~/.zplug
else
  curl -sL get.zplug.sh | zsh
fi

[ -f ~/.zshrc.zplug ] && rm ~/.zshrc.zplug
ln -s ~/dotfiles/_zshrc.zplug ~/.zshrc.zplug

# vim
[ -d ~/.vim ] && rm ~/.vim
ln -s ~/dotfiles/_vim ~/.vim

# vimrc
[ -f ~/.vimrc ] && rm ~/.vimrc
ln -s ~/dotfiles/_vimrc ~/.vimrc

# tmux
[ -f ~/.tmux.conf ] && rm ~/.tmux.conf
ln -s ~/dotfiles/_tmux.conf ~/.tmux.conf

# gitconfig
[ -f ~/.gitconfig ] && rm ~/.gitconfig
ln -s ~/dotfiles/_gitconfig ~/.gitconfig

