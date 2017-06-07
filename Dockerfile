FROM java:8-jre-alpine

MAINTAINER Shoma Nishitateno <shoma416@gmail.com>

ENV GITBUCKET_VERSION=4.12.1 GITBUCKET_HOME=/gitbucket

RUN set -ex \
    && ln -s ${GITBUCKET_HOME} /root/.gitbucket \
    && apk update \
    && apk add --no-cache \
        postgresql-client=9.5.6-r0

ADD https://github.com/gitbucket/gitbucket/releases/download/${GITBUCKET_VERSION}/gitbucket.war /opt/gitbucket.war

COPY files/database.conf $GITBUCKET_HOME/
COPY files/docker-entrypoint.sh /docker-entrypoint.sh

VOLUME $GITBUCKET_HOME

WORKDIR $GITBUCKET_HOME

# For web access
EXPOSE 8080

# For SSH access to git repository (Optional)
EXPOSE 29418

ENTRYPOINT ["/bin/sh"]

CMD ["/docker-entrypoint.sh"]