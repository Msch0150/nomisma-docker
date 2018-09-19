# nomisma-docker

> docker-solr-data directory need to be writable by id=8983.

To setup nomisma in a Linux environment with Docker installed:

    export TARGET_DIR=/home/docker/nomisma
    mkdir -p ${TARGET_DIR} && cd ${TARGET_DIR} && \
    wget https://github.com/Msch0150/nomisma-docker/archive/master.zip && \
    unzip master.zip && \
    rm master.zip && \
    cd nomisma-docker-master && \
    chmod +x setup.sh && \
    ./setup.sh

The following links can be used:

    http://localhost:10400/orbeon/nomisma/admin/
    #http://localhost:10402/exist
    http://localhost:10404/solr
    
> If required, change "localhost" to your local IP address.
> By default the "admin" user is setup without password. Don't forget to change it (in web/tomcat-users.xml).

## Overview

![numishare_overview_20180910](https://user-images.githubusercontent.com/37273467/45276680-05e0ac00-b4c4-11e8-9211-a20f4d271d66.jpg)

## Post Installation Tasks

When creating a new collection set the "Public Site" to:

    http://localhost:10400/orbeon/nomisma/<collection name>/
    
In "Modify Setting" > Theme URL:

    http://localhost:10200/orbeon/nomisma/

> If required, change "localhost" to your local IP address.
    
(Image created using cat ${TARGET_DIR}/docker-compose.yml | docker run -i funkwerk/compose_plantuml --link-graph --boundaries| docker run -i think/plantuml > out.svg)

## Backup

Backup the following directories:

    ${TARGET_DIR}/nomisma-docker-master/docker-solr-data
    #${TARGET_DIR}/nomisma-docker-master/docker-exist-log
    #${TARGET_DIR}/nomisma-docker-master/docker-exist-data
    #${TARGET_DIR}/nomisma-docker-master/docker-loris-data
