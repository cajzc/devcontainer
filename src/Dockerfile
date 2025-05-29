FROM debian:latest

# Install packages

RUN apt-get update && apt-get install -y \
	git \
	zsh \
	tmux \
	tree \
	sudo \
	openssh-server \
	gnupg \
	ca-certificates \
	ninja-build \
	gettext \
	cmake \
	unzip \
	curl \
	python3 \
	python3-pip \
	build-essential \
	# Node.js (via Nodesource)
	&& curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
	&& apt-get install -y nodejs \
	# Go
	&& curl -OL https://golang.org/dl/go1.21.0.linux-amd64.tar.gz \
	&& tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz \
	&& rm go1.21.0.linux-amd64.tar.gz \
	# Rust
	&& curl https://sh.rustup.rs -sSf | sh -s -- -y \
	# Cleanup
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Setup ssh
RUN rm -f /etc/ssh/ssh_host_* && \
	ssh-keygen -A

# Build the most recent version of nvim
RUN git clone --depth 1 https://github.com/neovim/neovim && \
	cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && \
	sudo make install

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


# Setup ssh
COPY entrypoint.sh home/devcontainer/entrypoint.sh
RUN chmod +x home/devcontainer/entrypoint.sh && \
	ssh-keygen -A

EXPOSE 22

CMD [ "/home/devcontainer/entrypoint.sh"]

