#!/bin/bash

usage()
{
cat << EOF
usage: $0 options

OPTIONS:
   -h  Show this message
   -I  ID
   -R  Run
   
EOF
}

while getopts "hI:R:" OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    I)
      ID=$OPTARG
      ;;
    R)
      RUN=$OPTARG
      ;;
    ?)
      usage
      exit
      ;;
  esac
done

STUDYDIR=/PATH_TO_STUDY_DIRECTORY
SUITDIR=$STUDYDIR/SUIT/$ID

fslmaths $SUITDIR/filtered_func_suit_run${RUN} -nan $SUITDIR/filtered_func_suit_run${RUN}
fslmaths $SUITDIR/mean_func_suit_run${RUN} -nan $SUITDIR/mean_func_suit_run${RUN}
