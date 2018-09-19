FROM solr:5.5

ENV TEMP_DIR=/var/tmp
ENV SolrHost=solr
ENV SolrPort=8983
ENV SolrUserId=8983
ENV SolrGroupId=8983
ENV SolrHome=/opt/solr/server/solr/
   
### Download numishare

RUN cd ${TEMP_DIR} && \
    wget https://github.com/ewg118/numishare/archive/master.zip && \
    unzip master.zip && \
    rm master.zip && \
    mv numishare-master/solr-home/1.5 ${SolrHome}/numishare-published && \
    cd ${SolrHome}/numishare-published && \
    mkdir data && \
    sed -i s%"<checkIntegrityAtMerge>false</checkIntegrityAtMerge>"%%g conf/solrconfig.xml
RUN cd ${SolrHome}/numishare-published && \
    sed -i s%'<requestHandler name="/admin/" class="solr.admin.AdminHandlers"/>'%%g conf/solrconfig.xml
RUN cd ${SolrHome}/numishare-published && \
    sed -i s%4.10.2%5.5.5%g conf/solrconfig.xml
RUN cd ${SolrHome}/numishare-published && \
    sed -i s/units=/distanceUnits=/g conf/schema.xml
RUN cd ${SolrHome}/ && \
    chown -R ${SolrUserId}:${SolrGroupId} numishare-published

### Use prepared core configuration 

COPY core.properties ${SolrHome}/numishare-published/
