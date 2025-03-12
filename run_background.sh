#!/bin/bash
cd $PWD
sudo ./kill.sh
sudo ./resync.sh

WATCH_PATH=/App/aii_school_prod/storage/app
CURRENT_DATE=$(date +"%Y/%m/%d")
WACH_LIST=""

while IFS= read -r path; do
    # Skip empty lines
    [ -z "$path" ] && continue
    path="$path/$CURRENT_DATE"
    echo "Processing directory: $path"

    if [ ! -d "$path" ]; then
        echo "Dir doesn't not exist $path, auto create.."
        sudo mkdir -p $path
    fi
    # Add your action here
    sudo nohup ./start_watch.sh $path >> app.log 2>&1 &

    WATCH_LIST+=" $path"
done < "./base_dir"

find "/App/aii_school_prod/storage/app" -type d -exec chown -R www-data:www-data {} \; -exec chmod 777 -R {} \;