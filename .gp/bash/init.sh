#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init.sh
# Description:
# Conditional project setup
#

bundle install && rake db:create
ec=$?
if [[ $ec == "0" && ! -f .gp/bash/lock/starter.lock ]]; then
  bash .gp/bash/scaffold-react.sh &&
  yes | bash .gp/bash/configure-new.sh
  if [[ ! -d .gp/bash/lock ]]; then mkdir .gp/bash/lock; fi
  touch .gp/bash/lock/starter.lock
  dserver start & sleep 20 && op && sleep 5 && op hello_world
fi