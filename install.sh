#!/bin/bash

# Check root permission
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;31mEste script tiene que ser ejecutado como superusuario\e[0m" 
   exit 1
fi

# Copy executable to bin
echo -n "Copying shell file to /usr/local/bin..."
sudo cp git-branch-clean.sh /usr/local/bin/git-branch-clean
echo -e "\e[1;32mOK\e[0m"
# Change permissions from file to root
echo -n "Updating file permissions..."
sudo chown root:root /usr/local/bin/git-branch-clean
sudo chmod 755 /usr/local/bin/git-branch-clean
echo -e "\e[1;32mOK\e[0m"
# Add alias to git
echo -n "Adding alias to git..."
git config --global alias.clean-branches "! git-branch-clean"
echo -e "\e[1;32mOK\e[0m"
echo -e "\n\n\e[1;32mDone.\e[0m"

exit 0