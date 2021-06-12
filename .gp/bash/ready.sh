#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# ready.sh
# Description:
# opens an Initial preview or displays a welcome message

. .gp/bash/spinner.sh

c_green='\e[38;5;76m'
c_blue='\e[38;5;147m'
c_end='\e[0m'

blue() {
  echo -e "$c_blue$1$c_end"
}

green () {
  echo -e "$c_green$1$c_end"
}

pink () {
  echo -e "$c_hot_pink$1$c_end"
}

setup_msg() {
  pink "Welcome!"
  green "Setting up your starter project now..."
  green "This will take a couple of minutes."
}

task1() {
  blue "Installing project gems and creating database..."
  gp sync-await task1 > /dev/null 2>&1
}

task2() {
  blue "Scaffolding react_on_rails..."
  gp sync-await task2 > /dev/null 2>&1
}

task3() {
  blue "Configuring starter project..."
  gp sync-await task3 > /dev/null 2>&1
}

preview() {
  start_spinner "$c_green""Opening preview when server is ready$c_end"
  gp sync-await server-ready > /dev/null 2>&1  && stop_spinner 0
  bash -ic 'op' && sleep 5 && bash -ic 'op hello_world'
}

if [[ ! -f .gp/bash/locks/starter.lock ]]; then
  setup_msg; task1; task2; task3; preview
else
  echo "Welcome!"
fi
