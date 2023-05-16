#!/bin/bash

FOLDER_GLPI=glpi/
FOLDER_WEB=/srv/www/htdocs/

chown -R wwwrun:www ${FOLDER_WEB}${FOLDER_GLPI}
chmod 775 -R /srv/www/htdocs/glpi/

echo "ServerName localhost" >> /etc/apache2/httpd.conf

chmod 775 -R /etc/sysconfig/cron
chmod 775 -R /etc/sysconfig/apache2

#Adiciona tarefa no cron
echo "*/2 * * * * wwwrun /usr/bin/php /srv/www/htdocs/glpi/front/cron.php &>/dev/null" >> /etc/cron.d/glpi
#Inicia o serviço cron
service cron start

#Ativação do modulo rewrite do Apache
a2enmod rewrite #&& service apache2 start && service apache2 stop

#Lançamento do serviço Apache em primeiro plano
/usr/sbin/apache2ctl -D FOREGROUND