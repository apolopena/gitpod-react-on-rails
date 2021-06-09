#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-gitpod.sh
# Description:
# Tasks to be run when a gitpod workspace is created for the first time.
# TODO: add error logging

# Load deps
. .gp/bash/workspace-init-logger.sh
. .gp/bash/spinner.sh

# BEGIN: Initialize
bundle install &&
rake db:create &&
gem install foreman #&&
#rails webpacker:install &&
#rails webpacker:install:react &&
#git add -A && git commit -m "Initial scaffolding" &&
#cp Gemfile tmp/__ && rails generate react_on_rails:install && mv tmp/__ Gemfile
# END: Initialize

# Always do this last
gp sync-done gitpod-inited

