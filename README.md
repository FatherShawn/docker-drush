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

Some option examples vary based on the host OS in use:
 
 - B2D: Mac/Windows (using [boot2docker-vagrant](https://github.com/blinkreaction/boot2docker-vagrant))
 - Linux

### Mounting SSH keys

SSH keys can be mounted into the container by mounting the home directory from the host.  
This will allow you to access remote servers with Drush.

Add `-v /.home:/.home` for **BD2** or `-v $(echo ~):/.home` for **Linux** to the docker command call:

    B2D: docker run --rm -v $(pwd):/var/www -v /.home:/.home blinkreaction/drush
    Linux: docker run --rm -v $(pwd):/var/www -v $(echo ~):/.home blinkreaction/drush


## Custom SSH key name

Specify a custom SSH RSA key name if necessary. Defaults to `id_rsa`.

Add `-e SSH_KEY_NAME=<key_name>` to the docker command call:

    B2D: docker run --rm -v /.home:/.home -e SSH_KEY_NAME=id_rsa blinkreaction/drush
    Linux: docker run --rm -v $(echo ~):/.home -e SSH_KEY_NAME=id_rsa blinkreaction/drush


### Acquia Cloud API credentials

Acquia Cloud API credentials can be passed to drush in the command line

Add `--email="<email>" --key="<key> ac-site-list"` to the docker command call:

    docker run --rm -v $(pwd):/var/www blinkreaction/drush \
    --email="<email>" --key="<key> ac-site-list

If you have the `~/.acquia/cloudapi.conf` credentials file,  
it can be mounted into the container by mounting the home directory from the host.

    Follow instructions for Mounting SSH keys.


### Host Drush settings

Drush settings (~/.drush) can be mounted into the container by mounting the home directory from the host.

    Follow instructions for Mounting SSH keys.


### Custom Drupal root directory name

If your Drupal root directory is called something other than `docroot`,  
you can override it in the docker command call with `-w /var/www/<drupal_root>`

    docker run --rm -v $(pwd):/var/www -w /var/www/htdocs blinkreaction/drush

### Debuggin (bash access)

    docker run --rm -it --entrypoint /opt/startup.sh -v $(pwd):/var/www blinkreaction/drush bash

