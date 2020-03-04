#!/usr/bin/env bash

# Disable exit on non 0, be verbose, wake till done

set +e
set -x

caffeinate -disu ./_setup.sh
