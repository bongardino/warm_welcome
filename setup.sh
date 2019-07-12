#!/usr/bin/env bash

# Disable exit on non 0, be verbose
set +e
set -x

source helpers.sh

./tools.sh
./macos.sh
./cleanup.sh
