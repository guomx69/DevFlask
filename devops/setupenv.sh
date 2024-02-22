#!/bin/bash
source ./basicinfo_oci.sh


###########install python3.9 and create a virtual environment
sudo apt-get update &&\
sudo apt-get install -y python3.9 python3.9-venv && sudo ln -sf /usr/bin/python3.9 /usr/bin/python3 &&\
#=====the above way to install python3.9(sudo apt-get install -y python3.9) will cause a lot of problems when you run sudo apt-get update==here is the solution
cd /usr/lib/python3/dist-packages/  && sudo ln -s apt_pkg.cpython-36m-x86_64-linux-gnu.so apt_pkg.so
#=====pip install  flask-mysqldb it will be error === here is solution====
sudo apt-get install default-libmysqlclient-dev python3.9-dev -y &&\
#it is  python3.9-dev not python3-dev, otherwise will not work
 


###########set up an apache server and a reverse proxy
sudo apt install -y apache2  &&\
sudo cp memaptech.store.conf /etc/apache2/sites-available/ && sudo a2ensite  memaptech.store.conf &&\
sudo mkdir -p /var/www/memaptech.store/public_html && sudo cp index.html /var/www/memaptech.store/public_html &&\
sudo a2enmod proxy && sudo a2enmod proxy_http && sudo systemctl restart apache2

#install certbot and create a certificate for the apache server
#sudo apt install certbot python3-certbot-apache -y && sudo certbot --apache -d memaptech.store

#create a service to be used as a proxy in nginx or apache, not use https://localhost:7000 as a proxy
#sudo vi /etc/systemd/system/flask_test.service  #how to create a service,https://www.youtube.com/watch?v=KWIIPKbdxD0
# sudo systemctl daemon-reload
# sudo systemctl start flask_test
# sudo systemctl enable flask_test
# sudo systemctl status flask_test
# sudo systemctl restart flask_test


#install nginx for reverse proxy
#sudo vi /etc/nginx/sites-available/flask_test # it use unix service so be careful about proxy configuration
# location / {
#     include proxy_params;
#     proxy_pass  http://unix:/home/flasktasker/projects/FlaskTest.sock;
# }
# sudo chmod 775 /home/flasktasker #using sock to communicate with gunicorn because of unix service

#install apache for reverse proxy
