
#!/bin/bash
source ./basicinfo_oci.sh

echo "Set up the Server Env";

ssh $prvKey $node  'echo "export DbMySQLUser='"'"$DbMySQLUser"'"'" >> ~/.profile'
ssh $prvKey $node  'echo "export DbMySQLServer='"'"$DbMySQLServer"'"'" >> ~/.profile' #save them into the OS .profile, the following way is better
#scp $prvKey $projectPath'/.env' $node':'$projectPath'/.env'  
#it is a good way to save Env Variables in .env file(not in repository) and copy it to the server for the app not docker-compose

#manually copy .env file(not in the repository) to the production server for docker-compose.
scp $prvKey $projectPath'/DbSrc/.env' $node':'$projectPath'/DbSrc/.env'
ssh $prvKey $node  'sudo apt update && sudo apt install docker.io -y && sudo apt install docker-compose -y'
ssh $prvKey $node  'cd '$projectPath'/DbSrc;docker-compose up'  #install mysql by docker way and start it



ssh $prvKey $node  '. ~/.profile;cd '$projectPath'/devops; source setupenv.sh'
