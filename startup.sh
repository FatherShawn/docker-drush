#!/bin/bash

# Copy SSH keys from host if available
# First see if we have a mount at /.ssh
if [ -f  /.ssh/id_rsa ]; then
  cp /.ssh/id_rsa* ~/.ssh/
# Otherwise copy from /.home/.ssh if available
elif [ -f  /.home/.ssh/id_rsa ]; then
  cp /.home/.ssh/id_rsa* ~/.ssh/
fi

# Execute passed CMD arguments
exec "$@"
