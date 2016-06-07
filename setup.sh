# zshrc
[ -f ~/.zshrc ] && rm ~/.zshrc
ln -s ~/dotfiles/_zshrc ~/.zshrc

# zshrc alias
[ -f ~/.zshrc.alias ] && rm ~/.zshrc.alias
ln -s ~/dotfiles/_zshrc.alias ~/.zshrc.alias

# zplug
[ -d ~/.zplug ] && rm -rf ~/.zplug
curl -sL get.zplug.sh | zsh
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

# git
[ -f ~/.gitconfig ] && rm ~/.gitconfig
[ -f ~/.gitignore ] && rm ~/.gitignore
ln -s ~/dotfiles/_gitconfig ~/.gitconfig
ln -s ~/dotfiles/_gitignore ~/.gitignore

