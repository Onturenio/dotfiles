set -ex

cd $HOME 
for file in git-completion.bash bash_profile bashrc gitconfig toprc vimrc; do
  rm -rf .$file
  ln -sf ~/dotfiles/$file .$file
done
