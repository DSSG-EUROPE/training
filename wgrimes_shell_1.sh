#!/bin/bash
grep USW00094846 2016.csv > OHARE.csv
grep PRCP OHARE.csv > OHARE_rain.csv
sed -i 's/PRCP/RAIN/g' OHARE_rain.csv
