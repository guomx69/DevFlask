
#!/bin/bash
source ./basicinfo_oci.sh
#pip install gunicorn or include it in requirements.txt
#create a wsgi.py for gunicorn

ssh $prvKey $node 'cd '$projectPath';source  ~/.profile; source startLocalEnv.sh;pip install -r requirements.txt; sleep 10; gunicorn --bind 0.0.0.0:9091 wsgi:app > /dev/null 2>&1 &' & #
printf "\033[0;31m sleep 10 seconds for Database Ready and then start API SERVER ready \033[0m\n\n"
sleep 3
echo "APIServer should be ready!"