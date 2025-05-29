FROM debian:latest

# Install packages
RUN apt-get update && apt-get install -y \
	git \
	zsh \
	tmux \
	neovim \
	tree \
	sudo \
	openssh-server \
	gnupg \
	ca-certificates \
	&& apt-get clean

# Setup ssh
RUN rm -f /etc/ssh/ssh_host_* && \
	ssh-keygen -A


# Setup the user
# zsh as the default shell
RUN useradd -ms /bin/zsh devcontainer && \
	echo "devcontainer:password" | chpasswd && \
	usermod -aG sudo devcontainer && \
	mkdir /var/run/sshd

USER root

# Copy configurations
RUN mkdir -p /home/devcontainer/.config && \
	mkdir -p /home/devcontainer/.ssh

COPY dotfiles/.config/ home/devcontainer/.config/
COPY dotfiles/.ssh/ /home/devcontainer/.ssh/
# Change permissions to give rw access to ssh config files
RUN chown -R devcontainer:devcontainer /home/devcontainer/.ssh && \
	chmod 700 /home/devcontainer/.ssh && \
	chmod 600 /home/devcontainer/.ssh/*
COPY dotfiles/.zshrc  home/devcontainer/


EXPOSE 22

# Setup ssh
COPY entrypoint.sh home/devcontainer/entrypoint.sh
RUN chmod +x home/devcontainer/entrypoint.sh && \
	ssh-keygen -A


CMD [ "/home/devcontainer/entrypoint.sh"]

