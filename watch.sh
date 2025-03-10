if [ -s pid.txt ]; then
    sudo kill -9 $(cat pid.txt)
fi

echo $! > pid.txt

TARGET=/App/aii_school_prod/storage/app

inotifywait -m --exclude '^\.' -r "$TARGET" -e create -e modify 2>/dev/null | while read -r path event file; do
    # is event is file, not dir
    if [[ "$event" != *"ISDIR"* ]]; then
        file_path="$path$file"
        sh ./transfer.sh $file_path
    fi
done