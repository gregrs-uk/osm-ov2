#!/bin/bash

# creates TomTom ov2 POI files from latest GB OSM data

# --------------------

# accepts PBF files
INPUT="great-britain-latest.osm.pbf"
#INPUT="west-midlands-latest.osm.pbf"

# remove old OSM input file
#test -e $INPUT && rm $INPUT

# download latest OSM input file for GB
#wget http://download.geofabrik.de/europe/great-britain-latest.osm.pbf || exit 1
#wget http://download.geofabrik.de/europe/great-britain/england/west-midlands-latest.osm.pbf || exit 1

# temporary PBF file to store nodes-only version
NODES="nodes.osm.pbf"

# if output directory exists, remove it
test -e output && rm -rf output

# create new output directory
mkdir output

# convert ways and relations into nodes and store in temp file
osmconvert $INPUT --all-to-nodes --max-objects=100000000 -o=$NODES || exit 2

# --------------------

# filter nodes file based on keys provided
# convert filtered nodes to CSV with lat, long and name fields
# convert CSV to TomTom ov2 format

./filter1key.sh $NODES - amenity=fuel |
osmconvert - --csv="@lat @lon name brand operator" --csv-separator="," |
# use awk script to format names nicely
awk -F "," -f fuel.awk |
gpsbabel -i csv -f - -o tomtom -F "output/Petrol_station.ov2"

./filter1key.sh $NODES - highway=services |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Services.ov2"

./filter2keys.sh $NODES - amenity=parking access=yes,public |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Parking.ov2"

./filter1key.sh $NODES - aeroway=aerodrome |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Airport.ov2"

./filter1key.sh $NODES - railway=station |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Train_station.ov2"

./filter1key.sh $NODES - shop=supermarket |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Supermarket.ov2"

./filter1key.sh $NODES - shop=convenience |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Convenience_store.ov2"

./filter1key.sh $NODES - amenity=post_office |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Post_office.ov2"

./filter1key.sh $NODES - amenity=post_box |
osmconvert - --csv="@lat @lon ref" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Postbox.ov2"

./filter1key.sh $NODES - tourism=hotel,guest_house,motel,hostel,chalet,bed_and_breakfast |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Accommodation.ov2"

./filter1key.sh $NODES - tourism=caravan_site,camp_site |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Caravan_park_or_campsite.ov2"

./filter1key.sh $NODES - tourism=attraction |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Tourist_attraction.ov2"

./filter1key.sh $NODES - tourism=museum |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Museum.ov2"

./filter1key.sh $NODES - amenity=cinema |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Cinema.ov2"

./filter1key.sh $NODES - amenity=hospital |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Hospital.ov2"

./filter1key.sh $NODES - amenity=pharmacy |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Pharmacy.ov2"

./filter1key.sh $NODES - amenity=fast_food |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Food_&_drink_-_Fast_food.ov2"

./filter1key.sh $NODES - amenity=restaurant |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Food_&_drink_-_Restaurant.ov2"

./filter1key.sh $NODES - amenity=cafe |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Food_&_drink_-_Cafe.ov2"

./filter1key.sh $NODES - amenity=pub |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Food_&_drink_-_Pub.ov2"

./filter2keys.sh $NODES - amenity=place_of_worship religion=christian |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/Church.ov2"

# use special script for ATMs
./atm.sh $NODES - |
osmconvert - --csv="@lat @lon name" --csv-separator="," |
gpsbabel -i csv -f - -o tomtom -F "output/ATM.ov2"

rm $NODES
