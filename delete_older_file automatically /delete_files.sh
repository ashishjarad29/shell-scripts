#!/bin/bash

LIST="/tmp/filelist.txt"   #File that contains list of files saved on 1st

while read FILE            #Read file names one by one from list
do
    if [ -f "$FILE" ]; then      #Check if file still exists
        
        if [ "$FILE" -ot "$LIST" ]; then   #Check if file is older than list file (not modified after 1st)
            rm "$FILE"            #Delete file
            echo "Deleted: $FILE" #Print deleted file name
        else
            echo "Skipped (modified after 1st): $FILE"  #Do not delete if modified later
        fi

    else
        echo "File not found: $FILE"  #If file already deleted or moved
    fi

done < "$LIST"   #Input comes from filelist.txt
