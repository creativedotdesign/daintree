#!/usr/bin/env bash

#Check composer installed

# Get wp-cli
echo "Checking for wp-cli..."
if [ -x "$(command -v wp)" ]; then
  #Check cli Version....
else
  echo "Downloading wp-cli..."
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  echo "Moving wp-cli to /usr/bin. You might need to enter a password..."
  sudo mv wp-cli.phar /usr/bin/wp

  #Install wp-cli env module and configure...
fi
