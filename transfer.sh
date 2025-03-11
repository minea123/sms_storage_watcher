#!/bin/bash
FILE_PATH=$1
EVENT_TYPE=$2
SERVER_LIST="servers.list"
DIR=$(dirname $FILE_PATH)

echo "new file detected $EVENT_TYPE, start uploading $FILE_PATH";

for server in $(cat $SERVER_LIST); do
    echo "sending $FILE_PATH to server $server"
    SSH_SERVER=root@$server

    # check if file dir exists, if not auto create recursive?
    ssh $SSH_SERVER "[ -d $DIR ] || sudo -u www-data mkdir -p $DIR"


    # scp to other dir
    rsync -av --ignore-existing $FILE_PATH $SSH_SERVER:$FILE_PATH
done