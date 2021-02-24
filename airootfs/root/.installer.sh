#!/usr/bin/env bash

echo "ARCH INSTALLER"

export NEWT_COLORS='
root=#0d1117,#0d1117
title=#0d1117,#ff5d8f
window=#0d1117,#0d1117
border=#23d18c,#0d1117
textbox=white,#0d1117
button=#0d1117,#eab464
'

# K E Y M A P

setKeymap() {
  declare -a KEYMAPS=(`localectl list-keymaps`)
  declare -a OPTIONS

  local idx=0

  for option in "${KEYMAPS[@]}" 
  do
  position=$(( idx + 1 ))
  OPTIONS[$idx]="$position $option"
  idx=$position
  done

  KEYMAP=$(whiptail --title "Keyboard" \
          --separate-output \
          --menu "Select a standard:" 25 53 15 ${OPTIONS[@]} \
          3>&1 1>&2 2>&3)

  echo ${KEYMAPS[$(( KEYMAP - 1 ))]}
}

loadkeys $(setKeymap)