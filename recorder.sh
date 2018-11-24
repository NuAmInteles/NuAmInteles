#!/bin/bash

WORDS_FILE=${1:-words}
uuid=$(uuidgen)
retries=3
OUT_PATH="files"

mkdir -p $OUT_PATH

clear
echo "Salut!"
echo -e "Te rugam sa urmaresti instructiunile:\n"
echo -e "\t * Apesi ENTER pentru a incepe inregistra."  
echo -e "\t * Rostesti cuvantul afisat."
echo -e "\t * Apesi ENTER pentru a opri inregistrarea."
echo -e "\t * Vei repeta acesti pasi de $retries ori pentru fiecare cuvant. \n \n \n"
echo -e "ID utilizator: $uuid ."

function kill_recording() {
  while : ; do 
  read -n 1 key <&1
  if [[ $key = "" ]] ; then
  kill "$1"
    break
  fi
  done
}

readarray -t WORDS < $WORDS_FILE

for word in "${WORDS[@]}"
do

  for ((i=1; i <= $retries; i++))
  do
 
  FILENAME="${OUT_PATH}/${word}_${uuid}_${i}.wav"
  
  echo -e "Cuvantul este '$word'. Apasa ENTER pentru a inregistra. "
  
  while : ; do
    read -n 1 key <&1
    if [[ $key = "" ]] ; then
      break
    fi
  done

  echo "se inregistreaza... apasa ENTER pentru a opri"
  arecord -t wav $FILENAME > /dev/null 2>&1 &
  pid=$!
  kill_recording $pid
  done
  echo "Multumesc"

done