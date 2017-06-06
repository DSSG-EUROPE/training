#!/bin/bash
grep USW00094846 2016.csv | sed s/PRCP/RAIN/ > ohare.csv
