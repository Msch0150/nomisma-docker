FROM solr:5.5

ENV TEMP_DIR=/var/tmp
ENV SolrHost=solr
ENV SolrPort=8983
ENV SolrUserId=8983
ENV SolrGroupId=8983
ENV SolrHome=/opt/solr/server/solr/
   
### Download numishare

RUN cd ${TEMP_DIR} && \
    wget https://github.com/nomisma/framework/archive/master.zip && \
    unzip master.zip && \
    rm master.zip && \
    mv framework-master/solr-home/1.5/nomisma ${SolrHome}/nomisma && \
    mv framework-master/solr-home/1.5/nomisma-fuseki ${SolrHome}/nomisma-fuseki && \
    cd ${SolrHome}/nomisma && \
    mkdir data && \
    sed -i s%"<checkIntegrityAtMerge>false</checkIntegrityAtMerge>"%%g conf/solrconfig.xml && \
    cd ${SolrHome}/nomisma-fuseki && \
    mkdir data && \
    sed -i s%"<checkIntegrityAtMerge>false</checkIntegrityAtMerge>"%%g conf/solrconfig.xml
RUN cd ${SolrHome}/nomisma && \
    sed -i s%'<requestHandler name="/admin/" class="solr.admin.AdminHandlers"/>'%%g conf/solrconfig.xml
RUN cd ${SolrHome}/nomisma-fuseki && \
    sed -i s%'<requestHandler name="/admin/" class="solr.admin.AdminHandlers"/>'%%g conf/solrconfig.xml
RUN cd ${SolrHome}/nomisma && \
    sed -i s%4.10.2%5.5.5%g conf/solrconfig.xml
RUN cd ${SolrHome}/nomisma-fuseki && \
    sed -i s%4.10.2%5.5.5%g conf/solrconfig.xml
RUN cd ${SolrHome}/nomisma && \
    sed -i s/units=/distanceUnits=/g conf/schema.xml
RUN cd ${SolrHome}/nomisma-fuseki && \
    sed -i s/units=/distanceUnits=/g conf/schema.xml
RUN cd ${SolrHome}/ && \
    chown -R ${SolrUserId}:${SolrGroupId} nomisma && \
    chown -R ${SolrUserId}:${SolrGroupId} nomisma-fuseki

### Use prepared core configuration 

COPY core.properties.nomisma ${SolrHome}/nomisma/core.properties
COPY core.properties.nomisma-fuseki ${SolrHome}/nomisma-fuseki/core.properties
