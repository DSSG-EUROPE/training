#!/bin/bash
grep USW00094846 2016.csv | grep PRCP | sed s/PRCP/RAIN/ > ohare_clean.csv
