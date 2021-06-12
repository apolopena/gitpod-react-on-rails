#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# ready.sh
# Description:
# opens an Initial preview or displays a welcome message

if [[ ! -f .gp/bash/lock/starter.lock ]]; then
  gp sync-await server-ready &&
  bash -ic 'op' && sleep 5 && bash -ic 'op hello_world'
else
  echo "Welcome!"
fi
