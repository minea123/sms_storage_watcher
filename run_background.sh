cd $PWD
sudo ./kill.sh
sudo ./resync.sh

sudo /bin/bash -c "nohup ./watch_sms_upload.sh >> app.log 2>> app.err.log &"
sudo /bin/bash -c "nohup ./watch_sms_public.sh >> app.log 2>> app.err.log &"
