#!/bin/bash

LIST="/tmp/filelist.txt"                 # List created on 1st
DELETED="/tmp/deleted_files.txt"         # Temp file to store deleted file names
EMAIL="jaradashish29@gmail.com"

> "$DELETED"   # clear old content if file exists

while read FILE
do
    if [ -f "$FILE" ]; then
        
        if [ "$FILE" -ot "$LIST" ]; then
            rm "$FILE"
            echo "$FILE" >> "$DELETED"
            echo "Deleted: $FILE"
        else
            echo "Skipped (modified after 1st): $FILE"
        fi

    else
        echo "File not found: $FILE"
    fi

done < "$LIST"


# Send mail report
if [ -s "$DELETED" ]; then
    mail -s "Deleted files report (5th cleanup)" "$EMAIL" < "$DELETED"
else
    echo "No files deleted." | mail -s "Cleanup report" "$EMAIL"
fi
