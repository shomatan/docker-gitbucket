#!/bin/sh
#
# -----------------------------------------------------------------------------
set +e

echo "** Preparing GitBucket"

echo "** Waiting for ${GITBUCKET_DB_TYPE}"

if [ "${GITBUCKET_DB_TYPE}" == "postgresql" ]; then
    export PGPASSWORD=$GITBUCKET_DB_PASS

    until psql -h "${GITBUCKET_DB_HOST}" -p "${GITBUCKET_DB_PORT}" -U "${GITBUCKET_DB_USER}" -c '\l'; do
        >&2 echo "**** PostgreSQL is unavailable - sleeping"
        sleep 1
    done
elif [ "${GITBUCKET_DB_TYPE}" == "mysql" ]; then
    until echo '\q' | mysql -h"${GITBUCKET_DB_HOST}" -P "${GITBUCKET_DB_PORT}" -u"${GITBUCKET_DB_USER}" -p"${GITBUCKET_DB_PASS}" "${GITBUCKET_DB_NAME}" ; do
        >&2 echo "**** MySQL is unavailable - sleeping"
        sleep 1
    done
else
    echo "**** Unsupported database type"
    exit 1
fi

echo "########################################################"

echo "** Executing java -jar /opt/gitbucket.war"

exec java -jar /opt/gitbucket.war --port="${GITBUCKET_PORT}" "$@"