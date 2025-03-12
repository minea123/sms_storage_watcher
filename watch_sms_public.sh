PUBLIC_DIR=/home/mjqedu/Code/aii_school_prod/public/storage


inotifywait -m "$PUBLIC_DIR" -r -e create -e modify --exclude '(^|/)((\.)|(mpdf(/|$)))' | while read -r path event file; do
    # is event is file, not dir
    if [[ "$event" != *"ISDIR"* ]]; then
        file_path="$path$file"
        sh ./transfer.sh $file_path $event
    fi
done