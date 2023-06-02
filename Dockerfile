FROM opensuse/leap:15

WORKDIR ./

RUN zypper --non-interactive refresh && zypper --non-interactive up \ 
&& zypper --non-interactive in nano \   
curl \
lynx \
w3m \
cron \
jq \
wget \
apache2 \
php8 \
php8-{cli,mysql,ldap,curl,gd,iconv,sqlite,phar} \
php8-{mbstring,zip,bz2,redis,pdo,gettext,sodium} \
php8-{opcache,APCu,exif,fileinfo,zlib,intl} \
php8-{openssl,ctype,dom,xmlreader,xmlwriter} \
apache2-mod_php8

COPY ./glpi/ /srv/www/htdocs/glpi/
COPY ./glpi.conf /etc/apache2/conf.d/
COPY ./start.sh /opt/
COPY ./pics /srv/www/htdocs/glpi/pics
COPY ./plugins /srv/www/htdocs/glpi/plugins
COPY ./templates /srv/www/htdocs/glpi/templates
#COPY ./config /srv/www/htdocs/config/
RUN chmod +x /opt/start.sh

ENTRYPOINT ["/opt/start.sh"]

EXPOSE 80
