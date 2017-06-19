# install anyenv
if [ ! -d ~/.anyenv ] ; then
  git clone https://github.com/riywo/anyenv ~/.anyenv
  git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
fi

# zshrc
[ -f ~/.zshrc ] && rm ~/.zshrc
[ -f ~/.zshrc.alias ] && rm ~/.zshrc.alias
ln -s ~/dotfiles/_zshrc ~/.zshrc
ln -s ~/dotfiles/_zshrc.alias ~/.zshrc.alias

# vim
[ -d ~/.vim ] && rm ~/.vim
[ -f ~/.vimrc ] && rm ~/.vimrc
ln -s ~/dotfiles/_vim ~/.vim
ln -s ~/dotfiles/_vimrc ~/.vimrc

# tmux
[ -f ~/.tmux.conf ] && rm ~/.tmux.conf
ln -s ~/dotfiles/_tmux.conf ~/.tmux.conf

# git
[ -f ~/.gitconfig ] && rm ~/.gitconfig
[ -f ~/.gitignore ] && rm ~/.gitignore
ln -s ~/dotfiles/_gitconfig ~/.gitconfig
ln -s ~/dotfiles/_gitignore ~/.gitignore

# dircolors
[ -f _/.dircolors ] && rm ~/.dircolors
ln -s ~/dotfiles/_dircolors ~/.dircolors
