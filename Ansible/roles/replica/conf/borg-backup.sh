#!/bin/sh

export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK='yes'
set PGPASSWORD="postgres" psql -h localhost -U postgres
pg_dumpall -U postgres > /home/postgres/pg_all_bases.sql

borg create --compression auto,lzma borg@192.168.122.39:postgres_repo::pg_sql-`date +%Y%m%d_%H%M%S` pg_all_bases.sql
borg prune --keep-daily 7 --keep-weekly 4 --keep-monthly 1 --glob-archives 'pg_sql*' borg@192.168.122.39:replica_repo
rm -rf pg_all_bases.sql

borg create --compression auto,lzma borg@192.168.122.39:postgres_repo::example-`date +%Y%m%d_%H%M%S` /etc /usr /home /var/log 
borg prune --keep-daily 7 --keep-weekly 4 --keep-monthly 1 --glob-archives 'example*' borg@192.168.122.39:replica_repo

unset PGPASSWORD

