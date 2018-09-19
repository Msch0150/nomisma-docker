FROM tomcat:8

ENV OrbeonTag="2017.2" OrbeonRelease="ce" OrbeonDateString="201712300816"
ENV OrbeoanDownloadLink="https://github.com/orbeon/orbeon-forms/releases/download"
ENV CATALINA_HOME=/usr/local/tomcat
ENV TEMP_DIR=/var/tmp
ENV ExistHost=db
ENV ExistPort=8080 
ENV SolrHost=solr
ENV SolrPort=8983
ENV ProjectsDir=/usr/local/projects
   
### Download Orbeon

RUN cd ${TEMP_DIR} && \
    wget ${OrbeoanDownloadLink}/tag-release-${OrbeonTag}-${OrbeonRelease}/orbeon-${OrbeonTag}.${OrbeonDateString}-$(echo ${OrbeonRelease} | tr /a-z/ /A-Z/).zip && \
    unzip orbeon-${OrbeonTag}.${OrbeonDateString}-$(echo ${OrbeonRelease} | tr /a-z/ /A-Z/).zip orbeon-${OrbeonTag}.${OrbeonDateString}-$(echo ${OrbeonRelease} | tr /a-z/ /A-Z/)/orbeon.war 
    
### Expand orbeon.war, remove properties-local.xml.template, add properties-local.xml.
### Example: orbeon-2017.2.201712300816-CE/WEB-INF/resources/config/properties-local.xml.
### Info: adding an attribute like 'as="xs:anyURI' does not work with python because "as" is a keyword. Search of a workaround later.
### Meanwhile add a prepared file manually:
### Expand orbeon war file
### Additional: Adjust orbeon.log location

RUN cd ${TEMP_DIR}/orbeon-${OrbeonTag}.${OrbeonDateString}-$(echo ${OrbeonRelease} | tr /a-z/ /A-Z/)/ && \
    unzip orbeon.war && \
    rm WEB-INF/resources/config/properties-local.xml.template && \
    sed -i s%../logs/orbeon.log%logs/orbeon.log%g ./WEB-INF/resources/config/log4j.xml && \
    rm orbeon.war && \
    cd .. && \
    mv orbeon-${OrbeonTag}.${OrbeonDateString}-$(echo ${OrbeonRelease} | tr /a-z/ /A-Z/) ${CATALINA_HOME}/webapps/orbeon


### Download nomisma

RUN mkdir -p ${ProjectsDir}/nomisma && \
    mkdir -p ${ProjectsDir}/nomisma-data && \
    cd ${TEMP_DIR} && \
    wget https://github.com/nomisma/framework/archive/master.zip && \
    unzip master.zip && \
    rm master.zip && \
    mv framework-master ${CATALINA_HOME}/webapps/orbeon/WEB-INF/resources/apps/nomisma
RUN cd ${TEMP_DIR} && \
    sed -i s!localhost:8080/solr/nomisma/!${SolrHost}:${SolrPort}/solr/nomisma/!g ${CATALINA_HOME}/webapps/orbeon/WEB-INF/resources/apps/nomisma/xforms/admin.xhtml
RUN cd ${TEMP_DIR} && \
    sed -i s!localhost:8080/solr/nomisma-fuseki/!${SolrHost}:${SolrPort}/solr/nomisma-fuseki/!g ${CATALINA_HOME}/webapps/orbeon/WEB-INF/resources/apps/nomisma/xforms/admin.xhtml
RUN cd ${TEMP_DIR} && \
    sed -i s!/usr/local/projects/nomisma!/usr/local/tomcat/webapps/orbeon/WEB-INF/resources/apps/nomisma!g ${CATALINA_HOME}/webapps/orbeon/WEB-INF/resources/apps/nomisma/xforms/admin.xhtml

### Creating themes

RUN cd ${CATALINA_HOME}/webapps/orbeon/WEB-INF/resources/apps/nomisma/ && \
    ln -s ui default

### Install vim/vi

RUN apt-get update && \
    apt-get install vim -y

COPY tomcat-users.xml ${CATALINA_HOME}/conf/
COPY orbeon.xml ${CATALINA_HOME}/conf/Catalina/localhost/
COPY properties-local.xml ${CATALINA_HOME}/webapps/orbeon/WEB-INF/resources/config/
# To do: replace the following line with regular xml processing to modify existing web.xml to match the the user authorization:
COPY web.xml ${CATALINA_HOME}/webapps/orbeon/WEB-INF/
COPY log4j.properties ${CATALINA_HOME}/lib/
