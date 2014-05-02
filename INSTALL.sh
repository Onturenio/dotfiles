set -ex

cd $HOME 
for file in bash_profile bashrc gitconfig toprc vimrc; do
  ln -sf ~/dotfiles/$file .$file
done
