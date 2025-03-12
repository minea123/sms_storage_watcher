ps aux | grep './watch_dir_event' | grep -v grep | awk '{print $2}' | xargs -r sudo kill -9
