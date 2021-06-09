#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# scaffolding.sh
# Description:
# Conditionally install scaffolding for react on rails: 
# Includes: webpacker, webpacker react support and react on rails scaffolding

[[ $(pwd) != "$GITPOD_REPO_ROOT" ]] &&
echo -e "\e[1;31mThis command can only be run from the project root of a gitpod workspace:\e[0m $GITPOD_REPO_ROOT" &&
exit 1

. "$GITPOD_REPO_ROOT"/.gp/bash/spinner.sh

c_red='\e[38;5;124m'
c_orange='\e[38;5;208m'
c_green='\e[38;5;76m'
c_blue='\e[38;5;147m'
c_hot_pink="\e[38;5;213m"
c_end='\e[0m'

_pass_msg() {
  echo -e "$c_green""SUCCESS$c_end:$c_end $1"
}

_fail_msg() {
  local msg script_path prefix
  if [[ $1 == '--show-path' ]]; then
    msg="$2"
    prefix="ERROR "
    script_path=$(readlink -f "$0")
  else
    msg="$1"
    prefix="ERROR"
  fi
  echo -e "$c_red$prefix$c_end$c_blue$script_path$c_end$c_red:$c_end$c_orange $msg$c_end"
}

if [[ ! -d config/webpack ]]; then
  msg="Installing Webpacker"
  start_spinner "$msg"
  yes | rails webpacker:install --silent 2> >(grep -v warning 1>&2) > /dev/null 2>&1
  ec=$?
  if [[ $ec -eq 0 ]]; then
    stop_spinner $ec
    _pass_msg "$msg"
  else
    stop_spinner $ec
    _fail_msg "$msg"
  fi
else
  echo "Webpacker appears to be installed"
  echo "skipping Webpacker installation"
fi
if [[ ! -f babel.config.js ]]; then
  msg="Configuring Webpacker to support react.js"
  start_spinner "$msg"
  yes | rails webpacker:install:react --silent 2> >(grep -v warning 1>&2) > /dev/null 2>&1
  ec=$?
  if [[ $ec -eq 0 ]]; then
    stop_spinner $ec
    _pass_msg "$msg"
  else
    stop_spinner $ec
    _fail_msg "$msg"
  fi
else
  echo "Webpacker appears to already be configured to support react.js"
  echo "Skipping Webpack configuration to support react.js"
fi
if [[ -n $(git status -s) ]]; then
  if git add -A && git commit -m "Initial scaffolding"; then
    echo "Unstaged changes were committed to the git repository using the message 'Initial scaffolding'"
    echo "Please push these changes to your remote respoistory as soon as possible with: git push"
  fi
fi
if [[ ! -f config/initializers/react_on_rails.rb ]]; then
  msg="Generating React on Rails Scaffolding"
  [[ $1 == '--use-redux' ]] && optional_flag='--redux' && msg="${msg} with the flag $optional_flag"
  start_spinner "$msg"
  # rails generate react_on_rails:install $optional_flag
  yes | rails generate react_on_rails:install "$optional_flag" --ignore-warnings --skip --quiet 2> >(grep -v warning 1>&2) > /dev/null 2>&1
  ec=$?
  if [[ $ec -eq 0 ]]; then
    stop_spinner $ec
    _pass_msg "$msg"
  else
    stop_spinner $ec
    _fail_msg "$msg"
  fi
else
  echo "React on Rails Scaffolding appears to already be in place"
  echo "Skipping generation of React on Rails Scaffolding"
fi

