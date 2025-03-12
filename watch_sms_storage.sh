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

    WATCH_LIST+=" $path"
done < "./base_dir"

find "/App/aii_school_prod/storage/app" -type d -exec chown -R www-data:www-data {} \; -exec chmod 777 -R {} \;

inotifywait $WATCH_LIST -m -r -e create -e modify --exclude '(^|/)((\.)|(mpdf(/|$)))' | while read -r path event file; do
    # is event is file, not dir
    if [[ "$event" != *"ISDIR"* ]]; then
        file_path="$path$file"
        sudo /bin/bash ./transfer.sh $file_path $event
    fi
done