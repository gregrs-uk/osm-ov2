#!/bin/bash

# creates a filtered OSM file from a PBF input file

# usage: ./filter2keys.sh inputfile.pbf outputfile.osm key1=value1 key2=value2

# osmosis binary
OSMOSIS="osmosis-latest/bin/osmosis"
# accepts PBF files
INPUT=$1
# outputs to OSM XML file
OUTPUT=$2
# tags to use for filter
FILTER1=$3
FILTER2=$4

$OSMOSIS \
  --read-pbf $INPUT \
  --tf reject-relations \
  --tf reject-ways \
  --tf accept-nodes $FILTER1 \
  --tf accept-nodes $FILTER2 \
  --write-xml $OUTPUT