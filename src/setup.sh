# Init
read -p "Enter the ssh private key file name: " ssh_private_key
read -p "Enter the username: " user

mkdir dotfiles

cd dotfiles

# Get the ssh configs
mkdir -p .ssh
cp /home/$user/.ssh/$ssh_private_key .ssh/sshkey
cp /home/$user/.ssh/$ssh_private_key.pub .ssh/sshkey.pub
cp ../config .ssh/


echo "[SUCCESS] Copied ssh configs"


# Get the dotfiles
mkdir -p .config
cp -r /home/$user/.config/tmux .config/
cp -r /home/$user/.config/nvim .config/
cp -r /home/$user/.config/kitty .config/
echo "[SUCCESS] Copied dotfiles"

# Get the shell config
cp -r /home/$user/.zshrc .
echo "[SUCCESS] Copied shell configs"

# Start the docker file
docker compose up --build -d
