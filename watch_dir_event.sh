inotifywait -m "$1" -r -e create -e modify --exclude '(^|/)((\.)|(mpdf(/|$)))' | while read -r path event file; do
    # is event is file, not dir
    if [[ "$event" != *"ISDIR"* ]]; then
        file_path="$path$file"
        sudo nohup /bin/bash ./transfer.sh $file_path $event &
    fi
done