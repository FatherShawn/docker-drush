# docker-drush
Drush binary Docker image

## Features

- PHP 5.6
- Drush 8.0-dev
- Acquia CloudAPI and Drush commands
- Mounting of SSH keys
- Drush Registry Rebuild


## Usage

Run in the project directory:

    docker run --rm -v $(pwd):/var/www blinkreaction/drush --version

This image makes certain assumptions:

- The project folder structure is

    ```
    ./
      |_ ..
      |_ docroot - Drupal root directory and working directory for the image
      |_ drush - custom drushrc, commands and aliases
        |_ aliases
        |_ commands
        |_ drushrc.php
      |_ ...
    ```

- You ssh key is called `id_rsa`


## Options


### Mounting SSH keys

SSH keys can be mounted into the container. This will allow you to access remote servers with Drush.

**Mac/Windows** (using [boot2docker-vagrant](https://github.com/blinkreaction/boot2docker-vagrant))

Add `-v /.home/.ssh:/.ssh` to the docker command call:

    docker run --rm -v $(pwd):/var/www -v /.home/.ssh:/.ssh blinkreaction/drush

**Linux**

Add `$(echo ~/.ssh):/.ssh` to the docker command call:

    docker run --rm -v $(pwd):/var/www -v $(echo ~/.ssh):/.ssh blinkreaction/drush


### Acquia Cloud API credentials

Acquia Cloud API credentials can be passed to drush in the command line

Add `--email="<email>" --key="<key> ac-site-list"` to the docker command call:

    docker run --rm -v $(pwd):/var/www blinkreaction/drush \
    --email="<email>" --key="<key> ac-site-list

If you have the `~/.acquia/cloudapi.conf` credentials file, it can mounted into the container

**Mac/Windows** (using [boot2docker-vagrant](https://github.com/blinkreaction/boot2docker-vagrant))

Add `-v /.home/.acquia:/root/.acquia` to the docker command call:


    docker run --rm -v $(pwd):/var/www -v /.home/.acquia:/root/.acquia \
    blinkreaction/drush ac-site-list

**Linux**

Add `-v $(echo ~/.acquia):/root/.acquia` to the docker command call:

    docker run --rm -v $(pwd):/var/www -v $(echo ~/.acquia):/root/.acquia \
    blinkreaction/drush ac-site-list


### Custom Drupal root directory name

If your Drupal root directory is called something other than `docroot`,  
you can override it in the docker command call with `-w /var/www/<drupal_root>`

    docker run --rm -v $(pwd):/var/www -w /var/www/htdocs blinkreaction/drush --version

### Debuggin (bash access)

    docker run --rm -it --entrypoint /opt/startup.sh -v $(pwd):/var/www blinkreaction/drush bash

