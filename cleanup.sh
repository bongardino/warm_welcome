#!/usr/bin/env bash

# Disable exit on non 0, be verbose
set +e
set -x

# set new bash as the default
sudo echo '/usr/local/bin/bash' >> /etc/shells
chsh -s /usr/local/bin/bash

# Disable Gatekeeper
sudo spctl --master-disable

# do this last bc it blockblocks things
brew cask install blockblock

echo "Done. Note that some of these changes require a logout/restart to take effect."
