#!/bin/bash
FILE_PATH=$1
EVENT_TYPE=$2
SERVER_LIST="servers.list"

# check if file from symblic dir
# replace to original dir
#if [[ "$FILE_PATH" =~ "/public/storage" ]]; then
#    FILE_PATH=${FILE_PATH//\/public\/storage/\/storage\/app}
#    echo "NEW_PATH: $FILE_PATH"
#fi

DIR=$(dirname $FILE_PATH)

for server in $(cat $SERVER_LIST); do
    echo "$(date "+%Y-%m-%d %H:%M:%S"): New file detected $EVENT_TYPE, start uploading to server $server $FILE_PATH";
    SSH_SERVER=root@$server

    # check if file dir exists, if not auto create recursive?
    ssh $SSH_SERVER "[ -d $DIR ] || sudo -u www-data mkdir -p $DIR"

    if [[ "$EVENT_TYPE" = "MODIFY" ]]; then
        rsync -av --update $FILE_PATH $SSH_SERVER:$FILE_PATH
    else
        rsync -av --ignore-existing $FILE_PATH $SSH_SERVER:$FILE_PATH
    fi    
done