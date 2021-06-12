#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init.sh
# Description:
# Conditional project setup
#

bundle install && rake db:create && gp sync-done task1
ec=$?
if [[ $ec == "0" && ! -f .gp/bash/locks/starter.lock ]]; then
  bash .gp/bash/scaffold-react.sh && gp sync-done task2 &&
  yes | bash .gp/bash/configure-new.sh && gp sync-done task3 &&
  if [[ ! -d .gp/bash/locks ]]; then mkdir .gp/bash/locks; fi
  touch .gp/bash/locks/starter.lock
  bash -ic 'dserver start' & sleep 20 && gp sync-done server-ready
fi