# zshrc
if [ -e ~/.zshrc ]; then
    rm ~/.zshrc
fi
ln -s ~/dotfiles/_zshrc ~/.zshrc

# zshrc alias
if [ -e ~/.zshrc.alias ]; then
    rm ~/.zshrc.alias
fi
ln -s ~/dotfiles/_zshrc.alias ~/.zshrc.alias

# zplug
if [ -e ~/.zplug ]; then
    rm ~/.zplug
fi
ln -s ~/dotfiles/_zplug ~/.zplug
if [ -e ~/.zshrc.zplug ]; then
    rm ~/.zshrc.zplug
fi
ln -s ~/dotfiles/_zshrc.zplug ~/.zshrc.zplug

# vim
if [ -e ~/.vim ]; then
    rm ~/.vim
fi
ln -s ~/dotfiles/_vim ~/.vim

# vimrc
if [ -e ~/.vimrc ]; then
    rm ~/.vimrc
fi
ln -s ~/dotfiles/_vimrc ~/.vimrc

# tmux
if [ -e ~/.tmux.conf ]; then
    rm ~/.tmux.conf
fi
ln -s ~/dotfiles/_tmux.conf ~/.tmux.conf

# gitconfig
if [ -e ~/.gitconfig ]; then
    rm ~/.gitconfig
fi
ln -s ~/dotfiles/_gitconfig ~/.gitconfig

# vimperator
if [ -e ~/.vimperatorrc ]; then
    rm ~/.vimperatorrc
fi
ln -s ~/dotfiles/_vimperatorrc ~/.vimperatorrc

