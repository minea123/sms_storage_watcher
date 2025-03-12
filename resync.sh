SERVER_LIST="servers.list"

echo "start initial syncronize..."

for server in $(cat $SERVER_LIST); do
    echo "resync from server $server"
    SSH_SERVER=root@$server

    # scp to other dir
    sudo rsync -avz --progress --ignore-existing --exclude 'mpdf' $SSH_SERVER:/App/aii_school_prod/storage/app /App/aii_school_prod/storage
done