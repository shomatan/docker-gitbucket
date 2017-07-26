#!/bin/sh
#
# -----------------------------------------------------------------------------
set +e

echo "** Preparing GitBucket"

sed -i -e "s/_GITBUCKET_DB_TYPE_/${GITBUCKET_DB_TYPE}/" database.conf
sed -i -e "s/_GITBUCKET_DB_HOST_/${GITBUCKET_DB_HOST}/" database.conf
sed -i -e "s/_GITBUCKET_DB_NAME_/${GITBUCKET_DB_NAME}/" database.conf
sed -i -e "s/_GITBUCKET_DB_USER_/${GITBUCKET_DB_USER}/" database.conf
sed -i -e "s/_GITBUCKET_DB_PASS_/${GITBUCKET_DB_PASS}/" database.conf

echo "** Waiting for ${GITBUCKET_DB_TYPE}"

if [ "${GITBUCKET_DB_TYPE}" == "postgresql" ]; then
    export PGPASSWORD=$GITBUCKET_DB_PASS

    until psql -h "${GITBUCKET_DB_HOST}" -U "${GITBUCKET_DB_USER}" -c '\l'; do
        >&2 echo "**** PostgreSQL is unavailable - sleeping"
        sleep 1
    done
elif [ "${GITBUCKET_DB_TYPE}" == "mysql" ]; then
    until mysql -h"${GITBUCKET_DB_HOST}" -u"${GITBUCKET_DB_USER}" -p"${GITBUCKET_DB_PASS}" &> /dev/null do
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