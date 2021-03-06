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

## Available versions
- 4.13
- 4.14.1
- 4.15
- 4.16
- 4.17
- 4.18.0
- 4.19.3
- 4.20.0
- 4.21.2
- 4.22.0