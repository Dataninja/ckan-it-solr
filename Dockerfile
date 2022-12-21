FROM solr:6.6.6

# Set vars
ENV SOLR_CORE ckan

# Set running user
USER root

# Create Directories
RUN mkdir -p /opt/solr/server/solr/$SOLR_CORE/conf
RUN mkdir -p /opt/solr/server/solr/$SOLR_CORE/data

# Adding Files
ADD ./log4j.properties /opt/solr/server/resources/
ADD ./solrconfig.xml \
    ./schema.xml \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/6.6.6/solr/server/solr/configsets/basic_configs/conf/currency.xml \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/6.6.6/solr/server/solr/configsets/basic_configs/conf/synonyms.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/6.6.6/solr/server/solr/configsets/basic_configs/conf/stopwords.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/6.6.6/solr/server/solr/configsets/basic_configs/conf/protwords.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/6.6.6/solr/server/solr/configsets/data_driven_schema_configs/conf/elevate.xml \
    /opt/solr/server/solr/$SOLR_CORE/conf/

# Create core.properties
RUN echo name=$SOLR_CORE > /opt/solr/server/solr/$SOLR_CORE/core.properties 

# Add spatial support
ADD https://repo1.maven.org/maven2/com/vividsolutions/jts-core/1.14.0/jts-core-1.14.0.jar /opt/solr/server/solr-webapp/webapp/WEB-INF/lib/

# Giving ownership to Solr
RUN chown -R $SOLR_USER:$SOLR_USER /opt/solr/server/

# User
USER $SOLR_USER:$SOLR_USER
