sudo rm watch.tmp
WATCH_PATH=/App/aii_school_prod/storage/app
CURRENT_DATE=$(date +"%Y/%m/%d")

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

    echo $path >> watch.tmp
done < "./base_dir"

sudo chown www-data:www-data -R /App/aii_school_prod/storage/app
sudo chmod 777 -R /App/aii_school_prod/storage/app

while IFS= read -r path; do
    # Skip empty lines
    echo "Watching $WATCH_DIR"
    sudo nohup /bin/bash ./watch_dir_event.sh $path &
done < "./watch.tmp"