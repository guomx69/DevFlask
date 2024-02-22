## before run this code first run the following lines: not .bashrc  (.bashrc vs .bash_profile vs .profile)
#echo "export PWDGITHUB=ghp_AfjhGtJMGBOsaBJvzsShQqZ6dl7QGoKHH" >> ~/.profile

localsecret=./git_pwd

echo "start to commit, push to remote repo"
 git add . &&\
 git commit -m "devop temporary saving " &&\
 
GIT_ASKPASS=$localsecret git push -f &&\
printf "\033[0;31m git push is done locally \033[0m\n\n"

#ssh into the following computers and git pull(in order to passwordless. copy local public key to these servers)
# ssh-copy-id dong@hp32.local; ssh-copy-id xin@dell5570.local
nodes=(#  "dong@thinkpadtwist.local" 
       #  "dong@hp32.local" 
       #  "ming@dell.local"
       #  "mint@hp2014.local"
       )

for node in "${nodes[@]}"; do 
    ssh $node '. ~/.profile; cd ~/projects/worklogs; remotesecret=./.pwdlogremote.secret; GIT_ASKPASS=$remotesecret git pull; git reset --hard origin/master'
    printf "\033[0;31m git pull is done @remote $node \033[0m\n\n"
done;