#!/bin/bash

# dynamically mount volumes based on existence
CONTAINER_NAME=kbf-$(id -un)
CONTAINER_UNAME=docker-kbf-$(id -un)
HOME_DIR=$(eval echo ~/)

MOUNT_CANDIDATES=(
  "$PWD:/workspace/Kalman-and-Bayesian-Filters-in-Python"
  "$HOME_DIR.bashrc:/home/$CONTAINER_UNAME/.bashrc"
  "$HOME_DIR.zshrc:/home/$CONTAINER_UNAME/.zshrc"
  "$HOME_DIR.oh-my-zsh:/home/$CONTAINER_UNAME/.oh-my-zsh"
  "$HOME_DIR.p10k.zsh:/home/$CONTAINER_UNAME/.p10k.zsh"
  "$HOME_DIR.gitconfig:/home/$CONTAINER_UNAME/.gitconfig"
  "$HOME_DIR.tmux.conf:/home/$CONTAINER_UNAME/.tmux.conf"
  "$HOME_DIR.ssh:/home/$CONTAINER_UNAME/.ssh"
)
MOUNT=""
for vol in ${MOUNT_CANDIDATES[@]}; do
  src="${vol%%:*}"
  dst="${vol#*:}"
  if [ -e "$src" ]; then
    MOUNT+="-v $src:$dst "
  else
    echo "$vol will not be mounted. It does not exists."
  fi
done

# run docker container
docker run -it \
  -e TERM=xterm-256color \
  --name $CONTAINER_NAME \
  -u $(id -u):$(id -g) \
  --ipc=host \
  --network host \
  --shm-size=512g \
  $MOUNT \
  $CONTAINER_NAME zsh