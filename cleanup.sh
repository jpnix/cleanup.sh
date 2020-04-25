#!/bin/bash
#Cleanup script                 jmp@linuxmail.org
#-----------------------------------------------#
#script takes in a directory and file age as parameter
#removes files that are older than file age

set -o posix

DIR=$1
FILEAGE=$2
ROOT_UID=0
E_NOTROOT=87

ROOT_CHECK()
{
    if [ "$UID" -ne "$ROOT_UID" ]; then
        echo "Must be root to run this script."
        exit $E_NOTROOT
    fi      
}

USAGE()
{
    echo "Missing Arguments: "
    echo 1>&2 "Usage: $0 [Directory] [File Age in days]"
    
   
}

ARG_CHECK()
{
    if [ "$DIR" == '' ] || [ "$FILEAGE" == '' ]; then
	    USAGE
            exit
    fi
}

CLEANUP()
{
    find $DIR/* -mtime +$FILEAGE -exec rm -rf {} \;
}

main()
{
  
  ROOT_CHECK	
  ARG_CHECK
  if [ -d "$DIR" ]; then
     trap CLEANUP EXIT 
  else
     echo "Error: Directory ${DIR} not found."
     exit 1
   fi
}

main

