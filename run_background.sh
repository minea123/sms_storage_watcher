cd $PWD
sudo ./kill.sh
SERVER_LIST="servers.list"

echo "start initial syncronize..."

for server in $(cat $SERVER_LIST); do
    echo "resync from server $server"
    SSH_SERVER=root@$server

    # scp to other dir
    sudo rsync -avz --progress --ignore-existing $SSH_SERVER:/App/aii_school_prod/storage/app /App/aii_school_prod/storage
done

sudo nohup /bin/bash ./watch_sms_storage.sh >> app.log 2>> app.err.log &
