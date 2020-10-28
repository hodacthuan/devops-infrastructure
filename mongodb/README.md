# MONGODB

## Environments

Create file `[environment_name].env` in the project root folder
```
MONGODB_NAME=example
MONGODB_EXTERNAL_PORT=27018
BACKUP_S3_BUCKET=thuanho-database-backup
BACKUP_S3_ACCESS_KEY_ID=admin
BACKUP_S3_SECRET_ACCESS_KEY=secret
BACKUP_S3_REGION=ap-southeast-1
DB_NAME=example-database
DB_USER=example-user
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
## Credential Infomation

```
MongoDB localhost URL:
mongodb://example-user:example-password@localhost:27018/example-database

```
