#!/bin/bash

#mkdir -p docker-exist-data
mkdir -p docker-solr-data/nomisma/data
mkdir -p docker-solr-data/nomisma-fuseki/data
mkdir -p docker-nomisma-data/nomisma-data/id
mkdir -p docker-nomisma-data/nomisma-data/ontology
mkdir -p docker-nomisma-data/nomisma/dump
mkdir -p docker-nomisma-data/NUDS
mkdir -p docker-fuseki-data/
cd docker-nomisma-data/NUDS
wget https://github.com/ewg118/NUDS/archive/master.zip
unzip master.zip
mv NUDS-master/nuds.xsd .
rm master.zip
rm -rf NUDS-master
cd ../..
#mkdir -p docker-loris-data/images
#mkdir -p loris

chown -R 8983:8983 docker-solr-data

docker-compose up
