#!/bin/sh

export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK='yes'
borg create --compression auto,lzma borg@192.168.122.39:proxy2_repo::example-`date +%Y%m%d_%H%M%S` /etc /usr /home /var/log
borg prune --keep-daily 7 --keep-weekly 4 --keep-monthly 1 borg@192.168.122.39:proxy2_repo

