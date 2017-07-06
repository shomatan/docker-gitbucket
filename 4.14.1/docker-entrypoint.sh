set +e

# Default Listen port
GITBUCKET_PORT=${GITBUCKET_PORT:-"8080"}
# Default GitBucket database type
GITBUCKET_DB_TYPE=${GITBUCKET_DB_TYPE:-"postgresql"}
# Default GitBucket database host
GITBUCKET_DB_HOST=${GITBUCKET_DB_HOST:-"db"}
# Default GitBucket database name
GITBUCKET_DB_NAME=${GITBUCKET_DB_NAME:-"gitbucket"}
# Default GitBucket database user name
GITBUCKET_DB_USER=${GITBUCKET_DB_USER:-"gitbucket"}
# Default GitBucket database password
GITBUCKET_DB_PASS=${GITBUCKET_DB_PASS:-"gitbucket"}

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
else
    echo "**** Unsupported database type"
    exit 1
fi

echo "########################################################"

echo "** Executing java -jar /opt/gitbucket.war"

exec java -jar /opt/gitbucket.war --port="${GITBUCKET_PORT}"