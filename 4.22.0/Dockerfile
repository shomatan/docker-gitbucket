FROM java:8-jre-alpine

LABEL maintainer="shoma416@gmail.com"

ENV GITBUCKET_VERSION=4.22.0 GITBUCKET_HOME=/gitbucket GITBUCKET_PORT=8080
ENV GITBUCKET_DB_TYPE="postgresql" GITBUCKET_DB_HOST="db" GITBUCKET_DB_PORT=5432
ENV GITBUCKET_DB_NAME="gitbucket" GITBUCKET_DB_USER="gitbucket" GITBUCKET_DB_PASS="gitbucket"

RUN set -ex \
    && ln -s ${GITBUCKET_HOME} /root/.gitbucket \
    && apk update \
    && apk add --no-cache \
        postgresql-client \
        mysql-client

ADD https://github.com/gitbucket/gitbucket/releases/download/${GITBUCKET_VERSION}/gitbucket.war /opt/gitbucket.war

COPY database.conf $GITBUCKET_HOME/
COPY docker-entrypoint.sh /docker-entrypoint.sh

VOLUME $GITBUCKET_HOME

WORKDIR $GITBUCKET_HOME

# For web access
EXPOSE 8080

# For SSH access to git repository (Optional)
EXPOSE 29418

ENTRYPOINT ["/docker-entrypoint.sh"]