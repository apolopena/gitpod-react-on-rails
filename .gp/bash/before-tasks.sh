#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# before-tasks.sh
# Description:
# Tasks that should be run everytime the worspace is created or started.
# 
# Notes:
# Gitpod currently does not persist files in the home directory so files such
# as /var/log/workspace-init.log will get wiped out on workspace restart
# file persistence in gitpod can be done but the kludge is not worth it right now

# Load logger
. .gp/bash/workspace-init-logger.sh

# Aliases for git
msg="git aliases have been written"
bash .gp/bash/utils.sh add_file_to_file_after "\\[alias\\]" .gp/snippets/git/emoji-log ~/.gitconfig &&
bash .gp/bash/utils.sh add_file_to_file_after "\\[alias\\]" .gp/snippets/git/aliases ~/.gitconfig &&
log_silent "$msg" &&
log_silent "try: git a    or: git aliases to see what is available."