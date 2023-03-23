set -ex

cd $HOME
for file in bash_profile bashrc gitconfig vimrc; do
  rm -rf .$file
  ln -sf ~/dotfiles/$file .$file
done

ln -sf ~/dotfiles/init.vim ~/.config/nvim/
