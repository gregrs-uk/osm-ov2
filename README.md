osm-ov2
=======

BASH (Linux) scripts to download Geofabrik OpenStreetMap data, extract points of interest and convert to OV2 for use in TomTom satnavs

Requirements
------------

* osmosis - used to filter data - place osmosis-latest directory in same directory as the script files or change path in filter scripts
* osmconvert - used to convert PBF to nodes-only and filtered OSMs to CSV
* gpsbabel - used to convert CSV to OV2
* awk - included with Linux systems
* wget - included with Linux systems

RAM
---

The programs used require a reasonable amount of memory. I had to create a ~/.osmosis file and use the line ‘JAVACMD_OPTIONS=-Xm768M’ to increase the RAM available to Osmosis, and also increase its maximum number of objects using an option in poi.sh. You may need to tweak these values as the OSM database grows.

Usage
-----

Make sure your system meets the requirements above. If you would like a different region that Great Britain, change the appropriate lines in poi.sh to download and use a different region from Geofabrik. If you would like different POI categories, alter the poi.sh script. Run the poi.sh script to download and filter the data. The ov2 files appear in the output directory, which is freshly created each time the script runs.

Files
-----

* poi.sh - this is the master script
* filter1key.sh – uses osmosis to filter nodes based on a key-value pair
* filter2key.sh – uses osmosis to filter nodes based on two key-value pairs
* atm.sh - uses osmosis to filter nodes for ATMs
* fuel.awk - awk script to format names of petrol stations nicely
* output directory will be created by the poi.sh script

Icons
-----

For my TomTom, I used icons from http://www.sjjb.co.uk/mapicons/. I downloaded SVG files and (for TomTom NavCore 9) converted them to 44x44 PNG files using the scripts provided, then converted them to BMP files using the Imagemagick convert tool. (These may need to have no alpha channel but I haven’t checked this.)

TODO
----

At the moment, the poi.sh script uses osmconvert to convert the PBF file to a nodes-only PBF file before osmosis filters it. It would be possible to use osmosis to also filter ways and keep the used nodes, and then use osmconvert to convert the ways to nodes. However, this converted file would need to be run through osmosis again to remove nodes that were used by ways but which aren’t POIs in their own right. Although this requires more steps, it may be quicker as osmconvert would be converting a series of small files to nodes instead of one large file. This needs testing.
