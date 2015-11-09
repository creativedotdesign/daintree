#!/usr/bin/env bash

# Daintree - WP install script
#
# A simple bash script to automate installation of WordPress with some settings.
#
# Dependencies:
# 1: WP-CLI
# 2: Bash
# 3: Composer
# 4: WP-CLI DotEnv Command (https://github.com/aaemnnosttv/wp-cli-dotenv-command)
##

# Set up the shell variables for colors
# http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
yellow=`tput setaf 3`;
green=`tput setaf 2`;
red=`tput setaf 1`;
clear=`tput sgr0`;

function hr ()
{
	echo ""
	echo "-------------------------------------------------------------------------------"
	echo ""
}

function title {
	echo -n "${green}$1${clear}"
}

function error {
	echo -n "${red}$1${clear}"
}

function question {
	echo
	echo "${yellow}$1${clear}"
}

clear
hr
echo "WordPress Install Script"
hr

#Check composer installed
if [ ! -x "$(command -v composer)" ]; then
  error "Composer is not installed."
	echo
	exit 1
fi

#Check wp-cli installed
if [ ! -x "$(command -v wp)" ]; then
	error "wp-cli is not installed."
	echo
	exit 1
fi

# Check wp-cli dotenv command
target_dir="~/.wp-cli"
if [ ! -d $target_dir ]; then
	error "wp-cli in home directory does not exist."
  echo
	exit 1
fi

echo
title "Create config file"
echo

#First check if config file exsts... wp dotenv list
wp dotenv init --template=.env.example --interactive --with-salts

question "Have you already created a database? (Y/n) "
read -e response
response=${response:-n}
if [[ $response =~ ^[Nn]$ ]]
then
	echo "You need to create a database first."
	echo
	exit
fi
unset response

# accept the name of our website
question "Site name: "
read -e sitename

echo

title "Admin credentials"
echo

# accept admin email
question "Admin email address: "
read -i ${admin_email} -e admin_email

# accept admin username
question "Admin username: "
read -i ${wpuser} -e wpuser

# accept admin password
question "Admin Password: "
read -e pass
if [[ -z "$pass" ]]
	then
  echo "Generating a random password..."
	# generate random 12 character password
	pass=$(LC_CTYPE=C tr -dc A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)-+= < /dev/urandom | head -c 12)
	echo "Admin Password is: ${pass}"
fi
hr

# add a simple yes/no confirmation before we proceed
question "Run Install? (Y/n) "
read -e run
run=${run:-Y}

# if the user didn't say no, then go ahead an install
if [ "$run" == n ] ; then
	exit
else
  if composer install$1; then
		echo "Nice one."
	else
		exit $?
	fi
fi

#Get the site URL for the installer
URL="$(wp dotenv get WP_SITEURL)"
echo URL
echo

wp core install --url="${URL}" --title="${sitename}" --admin_user="${wpuser}" --admin_password="{$pass}" --admin_email="${admin_email}"

title "Blocking search engines..."
echo
# discourage search engines
wp option update blog_public 0 --url="${URL}"
echo

title "Deleting sample pages..."
echo
# delete sample page, and create homepage
wp post delete $(wp post list --post_type=page --posts_per_page=1 --post_status=publish --pagename="sample-page" --field=ID --format=ids) --url="${URL}"
echo

title "Creating home page..."
echo
wp post create --post_type=page --post_title=Home --post_status=publish --post_author=$(wp user get $wpuser --field=ID --format=ids) --url="${URL}"

# set homepage as front page
wp option update show_on_front 'page'

# set homepage to be the new page
wp option update page_on_front $(wp post list --post_type=page --post_status=publish --posts_per_page=1 --pagename=home --field=ID --format=ids) --url="${URL}"
echo

# Delete sample post
title "Deleting sample post..."
echo
wp post delete 1 --force --url="${URL}"
echo

# set pretty urls
title "Setting up pretty urls..."
echo
wp rewrite structure '/%postname%/'
wp rewrite flush
echo

# delete hello dolly
title "Deleting hello dolly plugin..."
echo
wp plugin delete hello

hr

title "Installation is complete. :)"
echo
echo
title "Website: "
echo $URL
title "Admin: "
echo $URL"/wp/wp-admin"
title "Username: "
echo "$wpuser"
title "Password: "
echo "$pass"
