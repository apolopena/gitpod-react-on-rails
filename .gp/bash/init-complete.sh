#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-complete.sh
# Description:
# Code to be run just once at the very end of workspace initialization.
# 
# Notes:
# Always call this file last from the 'init' command in .gitpod.yml


# Set initialized flag - Keep this at the bottom of the file
#bash .gp/bash/helpers.sh mark_as_inited
gp sync-done gitpod-inited