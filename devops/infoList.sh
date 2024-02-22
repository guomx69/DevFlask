#reverse proxy
<VirtualHost *:*>
  ProxyPreserverHost On

  ProxyPass /web1 http://localhost:8081/

  ProxyPassReverse /web1 http://localhost:8081/

  ProxyPass /web2 http://localhost:8082/

  ProxyPassReverse /web2 http://localhost:8082/

  ServerName localhost
</VirtualHost>

#forward proxy
<VirtualHost *:*>

  ProxyRequests On
  proxyvia On
</VirtualHost>

#load balancer  https://www.youtube.com/watch?v=eshV2whJrqk
<VirtualHost *:*>
  <Proxy "balancer://mycluster">
    BalancerMember "localhost:8081"
    BalancerMember "localhost:8082"
  </Proxy>
  
  ProxyPass "/web" "balancer://mycluster"
  ProxyPassReverse "/web" "balancer://mycluster"

</VirtualHost>


apache2ctl -S
sudo apachectl configtest && apachectl -t 
sudo journalctl -u apache2.service --since today --no-pager
sudo systemctl reload apache2


sudo systemctl restart nginx

#forget to enable proxy
sudo a2enmod proxy #sudo a2dismod proxy
#sudo a2enmod proxy_html #no need this module
sudo a2enmod proxy_http #I forgot to enable this one and waste me one day.

#enable sites
sudo a2ensite  memaptech.store.conf
