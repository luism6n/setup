set -ex

wget --quiet --output-file - https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output --yes /usr/share/keyrings/1password-archive-keyring.gpg

sudo echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' > /etc/apt/sources.list.d/1password.list

sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
sudo wget --quiet --output-file - https://downloads.1password.com/linux/debian/debsig/1password.pol > /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
wget --quiet --output-file - https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output --yes /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

sudo apt update && sudo apt install 1password

1password
