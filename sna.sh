#!/bin/bash

# Script to extract the standard names from the
# TEI header and grep the XML files for occurrences
# and print out the names

OUT=snaout
mkdir $OUT

cut -d',' -f2 characters.csv | while read line 
    do
        IFS=';' read -a chars <<< $line
        for j in $chars;do
            grep -lr "$j" data > $OUT/$j.txt
        done
    done

