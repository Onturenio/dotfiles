set -ex

cd $HOME
for file in bash_profile bashrc gitconfig vimrc tmux.conf; do
  rm -rf .$file
  ln -sf ~/dotfiles/$file .$file
done

ln -sf ~/dotfiles/init.vim ~/.config/nvim/
