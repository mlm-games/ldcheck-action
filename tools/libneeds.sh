#!/bin/bash
# list needed shared libs for Android lib along with their paths

# Initialize variables
LIB_PATHS=""
FILE=""

# Parse command-line options
while getopts "p:d:" opt; do
  case $opt in
    p) LIB_PATHS="$OPTARG" ;;
    d) FILE="$OPTARG" ;;
    *) echo "Usage: $0 [-p lib_paths] [-d file]" >&2
       exit 1 ;;
  esac
done

if [ -z "$FILE" ]; then
  echo "Error: No file specified." >&2
  echo "Usage: $0 [-p lib_paths] [-d file]" >&2
  exit 1
fi

# Split LIB_PATHS into an array (on ':')
IFS=':' read -r -a PATH_ARRAY <<< "$LIB_PATHS"

# Get the list of needed shared libraries
NEEDED_LIBS=$(readelf -d "$FILE" | grep '\(NEEDED\)' | sed -r 's/.*\[(.*)\]/\1/')

echo "Needed shared libraries and their paths:"

for LIB in $NEEDED_LIBS; do
  FOUND=0
  for DIR in "${PATH_ARRAY[@]}"; do
    if [ -f "$DIR/$LIB" ]; then
      echo "$LIB found in $DIR/$LIB"
      FOUND=1
      break
    fi
  done
  if [ $FOUND -eq 0 ]; then
    echo "$LIB not found in specified library paths"
  fi
done
