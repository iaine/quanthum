#!/bin/bash

# Script to download all XML files from the First Folio site

#lr has no person list. 
FF=('F-tem' 'F-tgv' 'F-wiv' 'F-mm' 'F-err' 'F-ado' 'F-lll' 'F-mnd' 'F-mv' 'F-ayl' 'F-shr' 'F-aww' 'F-tn' 'F-wt' 'F-jn' 'F-r2' 'F-1h4' 'F-2h4' 'F-h5' 'F-1h6' 'F-2h6' 'F-3h6' 'F-r3' 'F-h8' 'F-tro' 'F-cor' 'F-tit' 'F-rom' 'F-tim' 'F-jc' 'F-mac' 'F-ham' 'F-oth' 'F-ant' 'F-cym')

mkdir data


for i in "${FF[@]}"
do
    echo $i
    wget http://firstfolio.bodleian.ox.ac.uk/download/xml/$i.xml -Pdata
done

for i in "${FF[@]}"
do
    echo $i
    python extract.py data/$i.xml
done
