set -ex

wget --quiet --output-document - https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/1password-archive-keyring.gpg

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list > /dev/null

sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
wget --quiet --output-document - https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol > /dev/null
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
wget --quiet --output-document - https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --yes --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

sudo apt-get update > /dev/null && sudo apt-get install 1password > /dev/null

if pgrep 1password > /dev/null; then
    pkill -e 1password
fi

1password --silent --log error

pid=$!
echo "close 1password or kill pid: $pid to continue" 
wait $pid

cd "$HOME"

sudo apt-get install git > /dev/null

if ! git status > /dev/null; then
    git init
    git remote add origin git@github.com:luism6n/home.git
fi

git fetch
git checkout master
git pull

bash bin/setup.sh
