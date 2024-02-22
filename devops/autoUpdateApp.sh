
#!/bin/bash
#AutoUpdateRemoteApp.sh
echo "Start to Set up the App";
source ./basicinfo_oci.sh

cd ../ && source git_push.sh &&\

ssh $prvKey $node '. ~/.profile; cd '$projectPath'; remotesecret=./git_pwd; GIT_ASKPASS=$remotesecret git pull origin main; git reset --hard origin/main'
printf "\033[0;31m git pull is done @remote $node \033[0m\n\n"
ssh $prvKey $node 'sudo reboot'
echo "Rebooting and wait for 60 seconds!"
sleep 60
echo "Rebooting should be done $projectPath" 

ssh $prvKey $node 'cd '$projectPath';source  ~/.profile; source startLocalEnv.sh; sleep 10; gunicorn --bind 0.0.0.0:9091 wsgi:app > /dev/null 2>&1 &' & #
printf "\033[0;31m sleep 10 seconds for Database Ready and then start API SERVER ready \033[0m\n\n"
sleep 3
echo "APIServer should be ready!"
#tes curl http://localhost:9091/products

