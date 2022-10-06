set -ex

cd $HOME 
for file in git-completion.bash bash_profile bashrc gitconfig toprc vimrc vim; do
  rm -rf .$file
  ln -sf ~/dotfiles/$file .$file
done
