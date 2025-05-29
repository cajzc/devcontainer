#!/bin/zsh
set -e

echo "Starting ssh-agent for devcontainer user"

eval "$(ssh-agent -s)"
ssh-add /home/devcontainer/.ssh/sshkey

echo "Starting sshd"
exec /usr/sbin/sshd -D
