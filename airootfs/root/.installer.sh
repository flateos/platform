#! /bin/bash

# Copyright (c) 2021 Romullo @hiukky.

# This file is part of Arch
# (see https://github.com/hiukky/arch).

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

export NEWT_COLORS='
root=#0d1117,#0d1117
title=#0d1117,#ff5d8f
window=#0d1117,#0d1117
border=#23d18c,#0d1117
textbox=white,#0d1117
button=#0d1117,#eab464
'

function parse_list() {
  declare -a SOURCE=("$@")
  declare -a TARGET

  local idx=0

  for option in "${SOURCE[@]}"
  do
    position=$(( idx + 1 ))
    TARGET[$idx]="$position $option"
    idx=$position
  done

  echo "${TARGET[@]}"
}

function set_common_settings() {
  timedatectl set-ntp true
}

function set_keymap() {
  declare -a KEYMAPS=(`localectl list-keymaps`)
  declare -a OPTIONS=(`parse_list ${KEYMAPS[@]}`)

  KEYMAP=$(whiptail --title "Keyboard" \
          --separate-output \
          --menu "Select a standard:" 25 53 15 ${OPTIONS[@]} \
          3>&1 1>&2 2>&3)

  echo ${KEYMAPS[$(( KEYMAP - 1 ))]}
}

function set_locale() {
  declare -a LOCALES=(`tail --lines=+24 /etc/locale.gen | sed -e 's/#//g' | awk '{print $1}'`)
  declare -a OPTIONS=(`parse_list ${LOCALES[@]}`)

  LOCALE=$(whiptail --title "Locale" \
          --separate-output \
          --menu "Select a standard:" 25 53 15 ${OPTIONS[@]} \
          3>&1 1>&2 2>&3)

  echo ${LOCALES[$(( LOCALE - 1 ))]}
}

function main() {
  # COMMON SETTINGS
  set_common_settings

  # KEYMAP
  loadkeys $(set_keymap)

  # LOCALE
  sed -i "/#$(set_locale)/s/^#//g" /etc/locale.gen
  locale-gen

  echo "DONE!!"
}

main
