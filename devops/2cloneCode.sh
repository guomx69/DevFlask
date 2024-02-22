
#!/bin/bash
source ./basicinfo_oci.sh
echo "clone code from github to $node" the server;

pwd=$(../../git_pwd)
ssh $prvKey $node  'echo "export PWDGITHUB='$pwd'" >> ~/.profile; . ~/.profile' #this part is done by other app

ssh $prvKey $node  '. ~/.profile; cd ~/projects; git clone --branch main https://guomx69:$PWDGITHUB@github.com/guomx69/DevFlask.git'
