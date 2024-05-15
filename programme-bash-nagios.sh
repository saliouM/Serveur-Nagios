```bash
sudo apt update
sudo apt upgrade

sudo apt install wget apache2 php openssl perl make gcc libc6 libgd-dev
sudo apt install mailutils 
sudo apt install bsd-mailx
sudo apt install build-essential
sudo apt-get install apache2 
sudo apt-get install php php-mysql
sudo apt-get install php-pear php-ldap php-snmp php-gd
sudo apt install libmariadb-dev
sudo apt-get install rrdtool 
sudo apt install librrds-perl
sudo apt-get install libconfig-inifiles-perl libcrypt-des-perl libdigest-hmac-perl 
sudo apt-get install libdigest-perl libgd-gd2-perl
sudo apt-get install snmp snmpd libnet-snmp-perl libsnmp-perl
sudo apt-get install libgd-dev libpng-dev
sudo apt-get install dnsutils fping
sudo apt-get install openssh-server
sudo apt install libssl-dev

sudo useradd -m -s /bin/bash nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagcmd www-data

su - nagios
sudo mkdir download
cd download

# Téléchargez Nagios depuis le lien dans le navigateur.

sudo cp /chemin/vers/le/fichier/nagios-4.5.0.tar.gz /home/nagios/download/
sudo tar -zxvf nagios-4.5.0.tar.gz
cd nagios-4.5.0
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all
sudo make install
sudo make install-init
sudo make install-commandmode
sudo make install-config
sudo make install-webconf

cd ..
sudo cp /chemin/vers/le/fichier/nagios-plugins-2.4.8.tar.gz /home/nagios/download/
sudo tar xvzf nagios-plugins-2.4.8.tar.gz
cd nagios-plugins-2.4.8
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagcmd --with-openssl=/usr/bin/openssl
sudo make all
sudo make install

sudo nano /usr/local/nagios/etc/objects/contacts.cfg

sudo nano /usr/local/nagios/etc/objects/commands.cfg

sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

sudo nano /etc/apache2/httpd.conf

sudo a2enmod cgi
sudo systemctl restart apache2
sudo systemctl start nagios
sudo systemctl enable nagios

sudo chown -R nagios:nagios /usr/local/nagios
sudo chmod -R 775 /usr/local/nagios
sudo chown -R nagios:www-data /usr/local/nagios/etc
sudo chmod -R 775 /usr/local/nagios/etc
sudo chown -R nagios:www-data /usr/local/nagios/share
sudo chmod -R 775 /usr/local/nagios/share

cd ..
sudo wget http://prdownloads.sourceforge.net/sourceforge/nagios/ndoutils-2.0.0.tar.gz
sudo tar xvzf ndoutils-2.0.0.tar.gz
cd ndoutils-2.0.0
sudo ./configure --prefix=/usr/local/nagios/ --enable-mysql --disable-pgsql \\
--with-ndo2db-user=nagios --with-ndo2db-group=nagcmd
sudo make
sudo make all
sudo cp ./src/ndomod-3x.o /usr/local/nagios/bin/ndomod.o
sudo cp ./src/ndo2db-3x /usr/local/nagios/bin/ndo2db
sudo cp ./config/ndo2db.cfg-sample /usr/local/nagios/etc/ndo2db.cfg
sudo cp ./config/ndomod.cfg-sample /usr/local/nagios/etc/ndomod.cfg
sudo chmod 775 /usr/local/nagios/bin/ndo*
sudo chown nagios:nagios /usr/local/nagios/bin/ndo*

sudo nano /etc/init.d/ndo2db

sudo update-rc.d ndo2db defaults
sudo chmod +x /etc/init.d/ndo2db

sudo service apache2 restart
sudo service nagios start

sudo apt update
sudo service apache2 restart
sudo service nagios start

sudo nano /etc/init.d/nagios

sudo chmod +x /etc/init.d/nagios
sudo service apache2 restart
sudo service nagios start

cd /usr/local/nagios/etc/servers
sudo nano hosts.cfg

sudo service nagios restart

# Monitoring Avec Nagios [5]

sudo nano /usr/local/nagios/etc/nagios.cfg

sudo mkdir -p /usr/local/nagios/etc/servers

sudo nano /usr/local/nagios/etc/objects/contacts.cfg

sudo a2enmod rewrite
sudo a2enmod cgi

sudo ln -s /etc/apache2/sites-available/nagios.config /etc/apache2/sites-enabled

sudo service apache2 restart
sudo service nagios start

sudo apt update
sudo service apache2 restart
sudo service nagios start

sudo nano /etc/init.d/nagios

sudo chmod +x /etc/init.d/nagios
sudo service apache2 restart
sudo service nagios start

cd /usr/local/nagios/etc/servers
sudo nano hosts.cfg

sudo service nagios restart

# Configuration du client NSclient sur Windows [6]

sudo nano /usr/local/nagios/etc/nagios.cfg

sudo systemctl restart nagios.service

# Modifier la configuration pour activer les modules suivants sur Windows:

# Redémarrer les services NSClient++ sur Windows.

sudo systemctl restart nagios.service
```
