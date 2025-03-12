cd $PWD
sudo ./kill.sh
sudo ./resync.sh

sudo nohup /bin/bash ./watch_sms_upload.sh >> app.log 2>> app.err.log &
sudo nohup /bin/bash ./watch_sms_public.sh >> app.log 2>> app.err.log &
