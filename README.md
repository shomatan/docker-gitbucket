# Docker: GitBucket

Docker image of GitBucket which based on the latest official java image.

## Supported database
By default use `PostgreSQL`

- PostgreSQL
- MySQL

## Environments

|Name|Default|Description|
|:---|:------|:----------|
|GITBUCKET_PORT|8080|Gitbucket web port|
|GITBUCKET_DB_TYPE|PostgreSQL|Selectable from the following `PostgreSQL`, `MySQL`|
|GITBUCKET_DB_HOST|db|Database host|
|GITBUCKET_DB_PORT|5432|Database port|
|GITBUCKET_DB_NAME|gitbucket|Database name|
|GITBUCKET_DB_USER|gitbucket|Database user name|
|GITBUCKET_DB_PASS|gitbucket|Database user password|