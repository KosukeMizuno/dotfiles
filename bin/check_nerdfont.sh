#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 07 Dec 2018.

# Check Nerd fonts drawing on terminal.
# Nerd Fonts Version: 2.0.0
# Script Version: 1.0.0

PROGNAME=$(basename $0)
VERSION="1.0.0"


usage() {
  echo "usage: ${PROGNAME} [--font_option]"
  echo ""
  echo "Check Nerd fonts v.2.0.0 drawing on terminal."
  echo ""
  echo "optional arguments:"
  echo "  -h, --help            show this help message and exit"
  echo "  --dev                 Font Devicon"
  echo "  --fa                  Font Awesome"
  echo "  --fae                 Font Awesome Extension"
  echo "  --iec                 IEC Power Symbols"
  echo "  --linux, --fontlogos  Font Linux and other open source Glyphs"
  echo "  --material, --mdi     Material Design Icon"
  echo "  --oct                 Octicons"
  echo "  --pl                  Powerline"
  echo "  --ple                 Powerline Extra"
  echo "  --pom                 Pomicon"
  echo "  --seti                Seti-UI + Custom"
  echo "  --weather             Weather Icons"
  exit 1
}

# Given an array of decimal numbers print all unicode codepoint.
function print-decimal-unicode-range() {
  local originalSequence=("$@")
  local counter=0
  # Use alternating colors to see which symbols extend out of the bounding
  # box.
  local bgColorBorder='\033[48;5;8m'
  local bgColorCode='\033[48;5;246m'
  local alternateBgColorCode='\033[48;5;240m'
  local bgColorChar='\033[48;5;66m'
  local alternateBgColorChar='\033[48;5;60m'
  local underline='\033[4m'
  local currentColorCode="${bgColorCode}"
  local currentColorChar="${bgColorChar}"
  local reset_color='\033[0m'
  local allChars=""
  local allCodes=""
  local wrapAt=5
  local topLine="${bgColorBorder}╔══════╦══════╦══════╦══════╦══════╗${reset_color}"
  local bottomLine="${bgColorBorder}╚══════╩══════╩══════╩══════╩══════╝${reset_color}"
  local line="${bgColorBorder}╠══════╬══════╬══════╬══════╬══════╣${reset_color}"
  local bar="${bgColorBorder}║${reset_color}"
  local originalSequenceLength=${#originalSequence[@]}
  local leftoverSpaces=$((wrapAt - (originalSequenceLength % wrapAt)))

  # add fillers to array to maintain table:
  if [[ "$leftoverSpaces" < "$wrapAt" ]]; then
    # shellcheck disable=SC2034
    # needs rework without 'i' var?
    for i in $(seq 1 $leftoverSpaces); do
      originalSequence+=(0)
    done
  fi

  local sequenceLength=${#originalSequence[@]}

  printf "%b\\n" "$topLine"

  for decimalCode in "${originalSequence[@]}"; do
    local hexCode
    hexCode=$(printf '%x' "${decimalCode}")
    local code="${hexCode}"
    local char="\\u${hexCode}"

    # fill in placeholder cells properly formatted:
    if [ "${char}" = "\\u0" ]; then
      char=" "
      code="    "
    fi

    allCodes+="${currentColorCode} ${underline}${code}${reset_color}${currentColorCode} ${reset_color}$bar"
    allChars+="${currentColorChar}  ${char}   ${reset_color}$bar"
    counter=$((counter + 1))
    count=$(( (count + 1) % wrapAt))

    if [[ $count -eq 0 ]]; then

      if [[ "${currentColorCode}" = "${alternateBgColorCode}" ]]; then
        currentColorCode="${bgColorCode}"
        currentColorChar="${bgColorChar}"
      else
        currentColorCode="${alternateBgColorCode}"
        currentColorChar="${alternateBgColorChar}"
      fi

      printf "%b%b%b" "$bar" "$allCodes" "$reset_color"
      printf "\\n"
      printf "%b%b%b" "$bar" "$allChars" "$reset_color"
      printf "\\n"

      if [ "$counter" != "$sequenceLength" ]; then
        printf "%b\\n" "$line"
      fi

      allCodes=""
      allChars=""
    fi

  done

  printf "%b\\n" "$bottomLine"

}

function print-unicode-ranges() {
  echo ''

  local arr=($@)
  local len=$#
  local combinedRanges=()

  for ((j=0; j<len; j+=2)); do
    local start="${arr[$j]}"
    local end="${arr[(($j+1))]}"
    local startDecimal=$((16#$start))
    local endDecimal=$((16#$end))

    combinedRanges+=($(seq "${startDecimal}" "${endDecimal}"))

  done

  print-decimal-unicode-range "${combinedRanges[@]}"

}


for OPT in "$@"
do
  case $OPT in
    '-h' | '--help' )
      usage
      ;;

    '--dev' )
      echo "Nerd Fonts - Devicons"
      print-unicode-ranges e700 e7c5
      echo; echo
      ;;

    '--fa' )
      echo "Nerd Fonts - Font awesome" 
      print-unicode-ranges f000 f2e0
      echo; echo
      ;;

    '--fae' )
      echo "Nerd Fonts - Font awesome extension" 
      print-unicode-ranges e200 e2a9
      echo; echo
      ;;

    '--ice' )
      echo "Nerd Fonts - Font Power Symbols"
      print-unicode-ranges 23fb 23fe 2b58 2b58
      echo; echo
      ;;

    '--linux' | '--fontlogos')
      echo "Nerd Fonts - Font Linux"
      print-unicode-ranges f300 f31c
      echo; echo
      ;;

    '--material' | '--mdi')
      echo "Nerd Fonts - Material Design Icons"
      print-unicode-ranges f500 fd46
      echo; echo
      ;;

    '--oct' )
      echo "Nerd Fonts - Octicons"
      print-unicode-ranges 2665 2665 26A1 26A1 f400 f4a8 f67c f67c
      echo; echo
      ;;

    '--pl' )
      echo "Nerd Fonts - Powerline"
      print-unicode-ranges e0a0 e0a2 e0b0 e0b3
      echo; echo
      ;;

    '--ple' )
      echo "Nerd Fonts - Powerline Extra"
      print-unicode-ranges e0a3 e0a3 e0b4 e0c8 e0cc e0d2 e0d4 e0d4
      echo; echo
      ;;

    '--pom' )
      echo "Nerd Fonts - Pomicons"
      print-unicode-ranges e000 e00a
      echo; echo
      ;;

    '--seti' )
      echo "Nerd Fonts - Symbols original"
      print-unicode-ranges e5fa e62e
      echo; echo
      ;;

    '--weather' )
      echo "Nerd Fonts - Weather Icons"
      print-unicode-ranges e300 e3eb
      echo; echo
      ;;

    -*)
      echo "$PROGNAME: illegal option -- '$(echo $1 | sed 's/^-*//')'" 1>&2
      exit 1
      ;;

    *)
      usage
      ;;
  esac
done
