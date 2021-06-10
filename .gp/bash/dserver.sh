#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# serverctl.sh
# Description:
# Starts puma and or webpack-dev-server via foreman
#
# Notes:
# The foreman gem will be installed if the current tty does not find an installation of foreman
# The server will not be started if an instace of it is already running

# Load spinner
. .gp/bash/spinner.sh

c_red='\e[38;5;124m'
c_end='\e[0m'

red() {
  echo -e "$c_red$1$c_end"
}

_version() {
  echo -e "dserver (MIT license) v1.0.0\nCopyright (C) 2021 Apolo Pena "
}

_help() {
  echo -e "Start and stop the development server"
  echo -e "  Usage:/n  dserver <[start | stop | -h | --help | -v | --version]>"
  echo -e "Example 1: Start puma and webpack-dev-server via foreman"
  echo -e "  dserver start"
  echo -e "Example 2: Stop puma and webpack-dev-server via foreman"
  echo -e "  dserver stop"
}

[[ $1 == '-v' || $1 == '--version' ]] && _version && exit 0
[[ -z $1 || $1 == '-h' || $1 == '--help' ]] && _help && exit 0
[[ $1 != 'start' && $1 != 'stop' ]] && red "Invalid command or flag: $1" && _help && exit 1
[[ $1 == 'start' && -n $(prgrep foreman) ]] && red "Foreman is already running, command aborted." && exit 1
[[ $1 == 'stop' && -z $(prgrep foreman) ]] && red "Foreman is not running, command aborted." && exit 1
[[ ! -f Procfile-dev-hmr ]] && red "Procfile-dev-hmr is required but not found, command Aborted." && exit 1

if [[ $(gem list foreman -i) == 'false' ]]; then
  msg="Installing gem: foreman"
  start_server "$msg"
  if gem install foreman; then stop_spinner 0; else stop_spinner 1 && exit 1; fi
fi

foreman start -f Procfile.dev-hmr