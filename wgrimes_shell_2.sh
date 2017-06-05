#!/bin/bash
grep USW00094846 2016.csv > OHARE.csv
sed -i '1i a,b,c,d,e,f,g,h' OHARE.csv
csvgrep -c 4 -r "(^[7-9][0-9]|\d{3,})" OHARE.csv > OHARE_greater_than_70.csv

