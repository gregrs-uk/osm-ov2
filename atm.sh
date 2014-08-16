#!/bin/bash

# creates a filtered OSM file from a PBF input file
# includes [amenity=atm] and [amenity=bank & atm=yes]

# usage: ./atm.sh inputfile.pbf outputfile.osm

# osmosis binary
OSMOSIS="osmosis-latest/bin/osmosis"
# accepts PBF files
INPUT=$1
# outputs to OSM XML file
OUTPUT=$2

$OSMOSIS \
  --read-pbf $INPUT \
  --tf reject-relations \
  --tf reject-ways \
  --tf accept-nodes amenity=atm outPipe.0=atm \
  \
  --read-pbf $INPUT \
  --tf reject-relations \
  --tf reject-ways \
  --tf accept-nodes amenity=bank \
  --tf accept-nodes atm=yes outPipe.0=bank \
  \
  --merge inPipe.0=atm inPipe.1=bank \
  --write-xml $OUTPUT