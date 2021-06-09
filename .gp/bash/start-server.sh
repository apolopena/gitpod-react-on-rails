#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# open-preview.sh
# Description:
# Starts the server once PostgreSQL is ready.

# Load spinner
. .gp/bash/spinner.sh

if [[ $(bash .gp/bash/helpers.sh is_inited) == 1 ]]; then
  gp sync-done gitpod-inited
fi;

UP=$(pgrep postgres | wc -l)
if [[ $UP -ne 1 ]]; then
  start_spinner "Initializing PostgreSQL..." &&
  gp await-port 5432 &&
  stop_spinner $?
fi 

gp await-port 5432 &&
start_spinner "Starting server when system is ready..." &&
gp sync-await gitpod-inited &&
stop_spinner $? &&
bash -c "foreman start -f Procfile.dev-hmr" & sleep 8 && gp sync-done system-ready
