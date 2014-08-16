#!/bin/bash

# creates a filtered OSM file from a PBF input file

# usage: ./filter1key.sh inputfile.pbf outputfile.osm key=value

# osmosis binary
OSMOSIS="osmosis-latest/bin/osmosis"
# accepts PBF files
INPUT=$1
# outputs to OSM XML file
OUTPUT=$2
# tag to use for filter
FILTER=$3

$OSMOSIS \
  --read-pbf $INPUT \
  --tf reject-relations \
  --tf reject-ways \
  --tf accept-nodes $FILTER \
  --write-xml $OUTPUT