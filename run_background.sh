cd $PWD
sudo ./kill.sh
sudo ./resync.sh

sudo nohup /bin/bash ./watch_sms_storage.sh >> app.log 2>> app.err.log &
