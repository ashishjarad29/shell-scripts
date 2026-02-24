#!/bin/bash

DIR="/path/to/folder"   #Folder where files are stored

LIST="/tmp/filelist.txt"  #This stores list of files found

EMAIL="jaradashish29@gmail.com"

find "$DIR" -type f -mtime +90 > "$LIST"  #So it finds files older than 3 months and saves list.

mail -s "Files older than 3 months" "$EMAIL" < "$LIST"  #Send mail
