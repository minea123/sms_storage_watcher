#!/bin/bash
FILE_PATH=$1
SERVER_LIST="servers.list"
DIR=$(dirname $FILE_PATH)

echo "new file detected, start uploading $FILE_PATH";

for server in $(cat $SERVER_LIST); do
    echo "sending $FILE_PATH to server $server"
    SSH_SERVER=root@$server

    # check if file dir exists, if not auto create recursive?
    ssh $SSH_SERVER "[ -d $DIR ] || sudo -u www-data mkdir -p $DIR"


    # scp to other dir
    rsync -avz --progress $FILE_PATH $SSH_SERVER:$FILE_PATH
done