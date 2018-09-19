#!/bin/bash

mkdir -p docker-exist-data
mkdir -p docker-solr-data/numishare-published/data
mkdir -p docker-loris-data/images
mkdir -p loris

chown -R 8983:8983 docker-solr-data

docker-compose up
