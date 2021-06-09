#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# helpers.sh
# Description:
# A variety of useful functions that depend on Gitpod
# and other outside entities
#

# Begin: gitpod persistance hacks
get_store_root() {
  echo "/workspace/$(basename "$GITPOD_REPO_ROOT")--store"
}

persist_file() {
  local err="helpers.sh: persist: error:"
  local store dest file
  store=$(get_store_root)
  dest="$store/$(dirname "${1#/}")"
  file="$dest/$(basename "$1")"
  mkdir -p "$store" && mkdir -p "$dest"
  [[ -f $1 ]] && cp "$1" "$file" || echo "$err $1 does not exist"
}

# For some reason $GITPOD_REPO_ROOT is not available when this is called (from before task)
# So just pass it in from there as $1
restore_persistent_files() {
  local err="helpers.sh: restore_persistent_files: error:"
  # TODO make this dynamic
  local init_log_orig=/var/log/workspace-init.log
  local store
  store="/workspace/$(basename "$1")--store"
  local init_log="$store$init_log_orig"
  [[ -e $init_log ]] && cp "$init_log" $init_log_orig || echo "$err $init_log NOT FOUND"
}

inited_file () {
  echo "$(get_store_root)/is_inited.lock"
}

mark_as_inited() {
  local file store
  file=$(inited_file)
  store=$(get_store_root)
  mkdir -p "$(get_store_root)"
  [[ ! -e $file ]] && touch "$file"
}

is_inited() {
  [[ -e $(inited_file) ]] && echo 1 || echo 0
}
# End: gitpod persistance hacks

# Call functions from this script gracefully
if declare -f "$1" > /dev/null
then
  # call arguments verbatim
  "$@"
else
  echo "helpers.sh: '$1' is not a known function name." >&2
  exit 1
fi