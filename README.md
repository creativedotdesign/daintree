# Daintree
An experimental WordPress boilerplate.

## DO NOT USE. IN EARLY DEVELOPMENT

## Requirements
- PHP >= 5.5
- Composer
- WP-CLI
- WP-CLI DotEnv Command [https://github.com/aaemnnosttv/wp-cli-dotenv-command]

## Features
- Clean directory structure
- Dependency management via Composer
- Environment variables via Dotenv
- Create an .env file on the fly
- Create Bitbucket repository (optional)

## Installation

The following commands should be executed on the server you wish to run the installation on and in the directory you want your WordPress project to be installed in. 

```
$ git clone --depth=1 https://github.com/lambdacreatives/daintree.git . && rm -rf .git
$ chmod +x install.sh
$ ./install.sh
```

Point your directory root at /web.
