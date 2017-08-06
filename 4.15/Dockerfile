FROM java:8-jre-alpine

MAINTAINER Shoma Nishitateno <shoma416@gmail.com>

ENV GITBUCKET_VERSION=4.15 GITBUCKET_HOME=/gitbucket GITBUCKET_PORT=8080
ENV GITBUCKET_DB_TYPE="postgresql" GITBUCKET_DB_HOST="db" GITBUCKET_DB_PORT=5432
ENV GITBUCKET_DB_NAME="gitbucket" GITBUCKET_DB_USER="gitbucket" GITBUCKET_DB_PASS="gitbucket"
ENV GITBUCKET_DB_URL "jdbc:${GITBUCKET_DB_TYPE}://${GITBUCKET_DB_HOST}:${GITBUCKET_DB_PORT}/${GITBUCKET_DB_NAME}"

RUN set -ex \
    && ln -s ${GITBUCKET_HOME} /root/.gitbucket \
    && apk update \
    && apk add --no-cache \
        postgresql-client=9.5.7-r0 \
        mysql-client=10.1.22-r0

ADD https://github.com/gitbucket/gitbucket/releases/download/${GITBUCKET_VERSION}/gitbucket.war /opt/gitbucket.war

COPY docker-entrypoint.sh /docker-entrypoint.sh

VOLUME $GITBUCKET_HOME

WORKDIR $GITBUCKET_HOME

# For web access
EXPOSE 8080

# For SSH access to git repository (Optional)
EXPOSE 29418

ENTRYPOINT ["/docker-entrypoint.sh"]