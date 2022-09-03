#!/bin/bash

##
#   This program handles arguments like so
#   tsc-terser.sh tsc [all tsc arguments] terser [all terser arguments]
#   Example:
#     tsc-terser.sh tsc --lib "DOM" "ES2021" --outFile "./main.js" --rootDir "./src" terser "./main.js" -o "./main-min.js"
#
#  It will execute tsc first, then it will do terser afterwards
##

helpmenu () {
   echo "tsc-terser, application to combine typescript and terser"
   echo "Basic usage:"
   echo "  \$ tsc-terser tsc [all tsc arguments] terser [all terser arguments]"
   echo ""
   echo 'After "tsc" is provided as an argument, all arguments after that up until it hits "terser" argument will be added to tsc'
   echo "Example:"
   echo '  tsc-terser tsc --lib "DOM" "ES2021" --rootDir "./src" --outFile "./main.js" terser "./main.js" -o "./main-min.js"'
   echo "  tsc-terser terser \"./main.js\" -o \"./main-min.js\" tsc --lib \"DOM\" \"ES2021\" --rootDir \"./src\" --outFile \"./main.js\" # Tho the reverse doesn't make a lot of sense"
   echo '  tsc-terser tsc --lib "DOM" "ES2021" --rootDir "./src" --outFile "./main.js" # Skip terser completely'
}


apps=()

# Check what apps are involved
for i in "$@"
do
    if [ "$i" = "terser" ] ; then
        apps+=("terser")
    fi
    if [ "$i" = "tsc" ] ; then
        apps+=("tsc")
    fi
done


# Check if no application was provided
if (( ${#apps[@]} == 0 )); then
    helpmenu
    exit
fi


# Append tsc commands
tsc_args=()

start=0
for i in "$@"
do
    if [ "$i" = "terser" ] ; then
        start=0
    fi
    if (( $start == 1 )) ; then
        tsc_args+=($i)
    fi
    if [ "$i" = "tsc" ] ; then
        start=1
    fi
done


# Append terser commands
terser_args=()

start=0
for i in "$@"
do
    if [ "$i" = "tsc" ] ; then
        start=0
    fi
    if (( $start == 1 )) ; then
        terser_args+=($i)
    fi
    if [ "$i" = "terser" ] ; then
        start=1
    fi
done


# Check what application to run first
first=""
for i in "$@"
do
    if [ "$i" = "tsc" ] ; then
        first="tsc"
        break
    fi
    if [ "$i" = "terser" ] ; then
        first="terser"
        break
    fi
done



# Execute
for i in "${apps[@]}"
do
	if [ "$i" = "tsc" ] ; then
        tsc ${tsc_args[@]} || { echo 'tsc failed' ; exit 1; }
    elif [ "$i" = "terser" ] ; then
        terser ${terser_args[@]} || { echo 'terser failed' ; exit 1; }
    fi
done