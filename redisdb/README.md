# REDISDB

## Environments

Create file `[environment_name].env` in the project root folder
```
REDISDB_NAME=example
REDISDB_EXTERNAL_PORT=6378
BACKUP_S3_BUCKET=thuanho-database-backup
BACKUP_S3_ACCESS_KEY_ID=admin
BACKUP_S3_SECRET_ACCESS_KEY=secret
BACKUP_S3_REGION=ap-southeast-1
DB_PASSWORD=example-password

```
## Up database
```
./up.sh DEPLOY_ENV
```
## Down database
```
./down.sh DEPLOY_ENV
```
## Execute to database
```
./down.sh DEPLOY_ENV
```
## Connection
Test connection by redis-cli
```
redis-cli -h localhost -p 6379 -a secure
set test test

```
