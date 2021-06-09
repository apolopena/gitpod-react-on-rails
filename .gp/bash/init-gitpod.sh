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
gem install foreman
# END: Initialize

# handle scaffolding
bash .gp/bash/init-scaffolding.sh

