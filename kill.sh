ps aux | grep './watch_sms_upload' | grep -v grep | awk '{print $2}' | xargs -r sudo kill -9
ps aux | grep './watch_sms_public' | grep -v grep | awk '{print $2}' | xargs -r sudo kill -9