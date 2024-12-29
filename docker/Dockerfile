ARG FROM_IMAGE_NAME=ubuntu:24.04
FROM ${FROM_IMAGE_NAME}

ADD . /workspace/Kalman-and-Bayesian-Filters-in-Python
WORKDIR /workspace/Kalman-and-Bayesian-Filters-in-Python

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y curl wget htop zsh tmux git vim sudo

ARG UNAME
ARG UID
ARG GID
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAME