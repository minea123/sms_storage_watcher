cd $PWD
sudo ./kill.sh
sudo nohup ./watch_sms_storage.sh >> app.log 2>> app.err.log &
