ps aux | grep './watch_sms_storage' | grep -v grep | awk '{print $2}' | xargs -r sudo kill -9
