# Only write the file if it does not already exist, else risk overwriting existing data
if [ ! -e noaa_OHARE_RAIN.csv ]; then
    # Read the airport weather data file,
    # Search for entries matching OHARE airport
    # Substitute instances of PRCP to RAIN for the sake of legibility
    # & write a new file
    cat 2016.csv | grep USW00094846 | sed s/PRCP/RAIN/ > noaa_OHARE_RAIN.csv;
fi
