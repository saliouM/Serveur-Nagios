# Serveur-Nagios
Nagios est un système de surveillance open-source conçu pour suivre l'état et la performance des infrastructures informatiques. Il fournit une plateforme centralisée permettant aux administrateurs de surveiller divers aspects des serveurs, réseaux, applications et services.
Nagios est un système de surveillance open-source conçu pour suivre l'état et la performance des infrastructures informatiques. Il fournit une plateforme centralisée permettant aux administrateurs de surveiller divers aspects des serveurs, réseaux, applications et services. Voici une brève description des caractéristiques clés de Nagios :

1. **Surveillance Continue :** Nagios assure une surveillance continue des ressources informatiques, en vérifiant périodiquement l'état des hôtes (serveurs, routeurs, etc.) et des services (web, base de données, etc.).

2. **Alertes et Notifications :** En cas de détection d'un problème ou d'une anomalie, Nagios génère des alertes et envoie des notifications aux administrateurs par le biais de divers canaux tels que e-mails, messages texte ou intégration avec d'autres systèmes.

3. **Interface Web :** Nagios propose une interface web conviviale permettant aux administrateurs de visualiser rapidement l'état actuel de leur infrastructure. Les tableaux de bord, graphiques et rapports facilitent la compréhension des performances et des tendances.

4. **Extensibilité :** Nagios peut être étendu grâce à des plugins, qui permettent de surveiller une large gamme de services et de métriques spécifiques à l'application. Des plugins personnalisés peuvent également être développés pour répondre à des besoins particuliers.

5. **Planification des Maintenance :** Les administrateurs peuvent planifier des fenêtres de maintenance pour éviter la génération d'alertes lors de mises à jour ou d'opérations de maintenance planifiées.

6. **Gestion des Configurations :** Nagios offre des fonctionnalités avancées de gestion des configurations, permettant de définir les hôtes, services, contacts et autres paramètres de surveillance.

7. **Historique et Journalisation :** Il conserve un historique détaillé des événements et des performances, facilitant l'analyse rétrospective des problèmes et la planification future.

8. **Support de Protocoles :** Nagios prend en charge divers protocoles de surveillance tels que SNMP, NRPE, et d'autres, lui permettant de s'intégrer avec une variété de dispositifs réseau et de serveurs.

9. **Communauté Active :** Avec une communauté active d'utilisateurs et de développeurs, Nagios bénéficie d'une évolution constante, de correctifs de sécurité et de nouvelles fonctionnalités.

En résumé, Nagios est un outil de surveillance puissant qui offre une visibilité essentielle sur la santé et les performances des infrastructures informatiques, permettant ainsi aux administrateurs de réagir rapidement aux problèmes potentiels.

# Étapes d'installation de Nagios sur Ubuntu [4]

## Étape 1 : Mise à jour du système
```bash
sudo apt update
sudo apt upgrade
```

## Étape 2 : Installation des dépendances nécessaires
```bash
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
```

## Étape 3 : Création d'un utilisateur et d'un groupe pour Nagios
```bash
sudo useradd -m -s /bin/bash nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagcmd www-data
```

Déconnexion et connexion avec le compte Nagios.

## Étape 4 : Téléchargement et installation de Nagios Core
```bash
su - nagios
sudo mkdir download
cd download
```

Téléchargez Nagios depuis le [lien](https://www.nagios.org/downloads/) dans le navigateur.

```bash
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
```

## Étape 5 : Installation de plugins Nagios
```bash
cd ..
sudo cp /chemin/vers/le/fichier/nagios-plugins-2.4.8.tar.gz /home/nagios/download/
sudo tar -zxvf nagios-plugins-2.4.8.tar.gz
cd nagios-plugins-2.4.8
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagcmd --with-openssl=/usr/bin/openssl
sudo make all
sudo make install
```

## Étape 6 : Configuration de Nagios
A- Configuration du fichier "Contacts.cfg":

```bash
sudo nano /usr/local/nagios/etc/objects/contacts.cfg
```

Modifiez les informations de contact selon vos besoins.

B- Vérification des commandes:

```bash
sudo nano /usr/local/nagios/etc/objects/commands.cfg
```

Vérifiez et modifiez si nécessaire.

C- Configuration du mot de passe pour l'utilisateur admin de Nagios:

```bash
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
```

D- Édition du fichier httpd.conf:

```bash
sudo nano /etc/apache2/httpd.conf
```

Collez le script.

```bash
ScriptAlias /nagios/cgi-bin /usr/local/nagios/sbin
<Directory "/usr/local/nagios/sbin">
Options ExecCGI
AllowOverride None
Order allow,deny
Allow from all
AuthName "Nagios Access"
AuthType Basic
AuthUserFile /usr/local/nagios/etc/htpasswd.users
Require valid-user
</Directory>
Alias /nagios /usr/local/nagios/share
<Directory "/usr/local/nagios/share">
Options None
AllowOverride None
Order allow,deny
Allow from all
AuthName "Nagios Access"
AuthType Basic
AuthUserFile /usr/local/nagios/etc/htpasswd.users
Require valid-user
</Directory>
```


E- Redémarrez le serveur Apache:

```bash
sudo a2enmod cgi
sudo systemctl restart apache2
sudo systemctl start nagios
sudo systemctl enable nagios
```

## creer un login nagios
```bash
htpasswd /usr/local/nagios/etc/htpasswd.users nagios
```

## Étape 7 : Vérification de l'installation et changement des droits utilisateurs
```bash
sudo chown -R nagios:nagcmd /usr/local/nagios
sudo chmod -R 775 /usr/local/nagios
sudo chown -R nagios:www-data /usr/local/nagios/etc
sudo chmod -R 775 /usr/local/nagios/etc
sudo chown -R nagios:www-data /usr/local/nagios/share
sudo chmod -R 775 /usr/local/nagios/share
```

## Étape 8 : Installation de NDO et NDO2DB
```bash
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
```

## Étape 9 : Création d'un daemon ndo2db
```bash
sudo nano /etc/init.d/ndo2db
```

## Copiez-collez le script et enregistrez. Ajoutez le daemon au démarrage.

```
#!/bin/sh
#
#
# chkconfig: 345 99 01
# description: Nagios to mysql
#
# Author : Gaëtan Lucas
# Realase : 07/02/08
# Version : 0.1 b
# File : ndo2db
# Description: Starts and stops the Ndo2db daemon
# used to provide network services status in a database.
#
status_ndo ()
{
if ps -p $NdoPID > /dev/null 2>&1; then
return 0
else
return 1
fi
return 1
}
printstatus_ndo()
{
if status_ndo $1 $2; then
echo "ndo (pid $NdoPID) is running..."
else
echo "ndo is not running"
fi
}
killproc_ndo ()
{
echo "kill $2 $NdoPID"
kill $2 $NdoPID
}
pid_ndo ()
{
if test ! -f $NdoRunFile; then
echo "No lock file found in $NdoRunFile"
echo -n " checking runing process..."
NdoPID=`ps h -C ndo2db -o pid`
if [ -z "$NdoPID" ]; then
echo " No ndo2db process found"
exit 1
else
echo " found process pid: $NdoPID"
echo -n " reinit $NdoRunFile ..."
touch $NdoRunFile
chown $NdoUser:$NdoGroup $NdoRunFile
echo "$NdoPID" > $NdoRunFile
echo " done"
fi
fi
NdoPID=`head $NdoRunFile`
}
#Source function library
# Solaris doesn't have an rc.d directory, so do a test first
if [ -f /etc/rc.d/init.d/functions ]; then
. /etc/rc.d/init.d/functions
elif [ -f /etc/init.d/functions ]; then
. /etc/init.d/functions
fi
prefix=/usr/local/nagios
exec_prefix=${prefix}
NdoBin=${exec_prefix}/bin/ndo2db
NdoCfgFile=${prefix}/etc/ndo2db.cfg
NdoRunFile=${prefix}/var/ndo2db.run
NdoLockDir=/var/lock/subsys
NdoLockFile=ndo2db.lock
NdoUser=nagios
NdoGroup=nagios

#Check that ndo exists.
if [ ! -f $NdoBin ]; then
echo "Executable file $NdoBin not found. Exiting."
exit 1
fi
# Check that ndo.cfg exists.
if [ ! -f $NdoCfgFile ]; then
echo "Configuration file $NdoCfgFile not found. Exiting."
exit 1
fi
# See how we were called.
case "$1" in
start)
echo -n "Starting ndo:"
touch $NdoRunFile

chown $NdoUser:$NdoGroup $NdoRunFile
$NdoBin -c $NdoCfgFile
if [ -d $NdoLockDir ]; then
touch $NdoLockDir/$NdoLockFile;
fi
ps h -C ndo2db -o pid > $NdoRunFile
if [ $? -eq 0 ]; then
echo " done."
exit 0
else
echo " failed."
$0 stop
exit 1
fi
;;
stop)
echo -n "Stopping ndo: "
pid_ndo
killproc_ndo
# now we have to wait for ndo to exit and remove its
# own NdoRunFile, otherwise a following "start" could
# happen, and then the exiting ndo will remove the
# new NdoRunFile, allowing multiple ndo daemons
# to (sooner or later) run
# echo -n 'Waiting for ndo to exit .'
for i in 1 2 3 4 5 6 7 8 9 10 ; do
if status_ndo > /dev/null; then
echo -n '.'
sleep 1
else
break
fi
done
if status_ndo > /dev/null; then
echo
echo 'Warning - ndo did not exit in a timely manner'
else
echo 'done.'
fi
rm -f $NdoRunFile $NdoLockDir/$NdoLockFile
;;
status)
pid_ndo
printstatus_ndo ndo
;;
restart)
$0 stop
$0 start
;;
*)
echo "Usage: ndo {start|stop|restart|status}"
exit 1
;;
esac
# End of this script

```

```bash
sudo update-rc.d ndo2db defaults
sudo chmod +x /etc/init.d/ndo2db
```

Le daemon ndo2db est prêt.

# Monitoring Avec Nagios [5]

## 1- Configuration pour le monitoring

1. Aller dans le fichier "/usr/local/nagios/etc/nagios.cfg":

```bash
sudo nano /usr/local/nagios/etc/nagios.cfg
```

Décommenter la ligne spécifiée.

2. Créer un fichier "servers":

```bash
sudo mkdir -p /usr/local/nagios/etc/servers
```

3. Définir une adresse e-mail pour les notifications:

```bash
sudo nano /usr/local/nagios/etc/objects/contacts.cfg
```

4. Activer les modules d'Apache2:

```bash
sudo a2enmod rewrite
sudo a2enmod cgi
```

5. Activer la virtualisation de Nagios:

```bash
sudo ln -s /etc/apache2/sites-available/nagios.config /etc/apache2/sites-enabled
```

6. Redémarrer les services:

```bash
sudo service apache2 restart
sudo service nagios start
sudo apt update
sudo service apache2 restart
sudo service nagios start
```

7. Modification du fichier Nagios:

Accéder au fichier:

```bash
sudo nano /etc/init.d/nagios
```

## Ajouter le contenu spécifié, rendre le fichier exécutable et démarrer Nagios:

```
DESC="Nagios"
NAME=nagios
DAEMON=/usr/local/nagios/bin/$NAME
DAEMON_ARGS=".d /usr/local/nagios/etc/nagios.cfg"
PIDFILE=/usr/local/nagios/var/$NAME.lock
```


```bash
sudo chmod +x /etc/init.d/nagios
sudo service apache2 restart
sudo service nagios start
```

8. Création d'un fichier "host":

```bash
cd /usr/local/nagios/etc/servers
sudo nano hosts.cfg
```

## Ajouter le contenu spécifié et redémarrer Nagios:

```
define host{
	use			linux-server
	host_name		laptop_windows
	alias			My Windows Server
	address			192.168.11.106
	max_check_attempts	5
	check_period		24x7
	notification_interval	30
	notification_period	24x7
}
define host{
	use			linux-server
	host_name		Iphone
	alias			My Iphone
	address			192.168.11.105
	max_check_attempts	5
	check_period		24x7
	notification_interval	30
	notification_period	24x7
}
```


```bash
sudo service nagios restart
```

## 2- Configuration du client NSclient sur Windows [6]

1. Monitoring de Windows avec NSClient++ Nagios Core Agent:

Installer [NSClient++ Nagios Core Agent](https://nsclient.org/) sur Windows.

2. Configuration de Nagios:

Éditer le fichier nagios.cfg:

```bash
sudo nano /usr/local/nagios/etc/nagios.cfg
```

Décommenter la ligne spécifiée et mettre l'adresse IP du serveur Nagios.

Redémarrer le système:

```bash
sudo systemctl restart nagios.service
```

3. Modifier la configuration pour activer les modules:

Modifier le fichier nsclient.ini sous C:\Program Files\NSClient++\nsclient.

Redémarrer les services NSClient++ sur Windows.

Redémarrer Nagios sur Ubuntu:

```bash
sudo systemctl restart nagios.service
```

------------------------------------------------------------------------------------

2-2 Configuration du client NSclient sur windows [6]

1- Monitoring windows de windows

Installer NSClient++ Nagios core Agent sur windows : https://nsclient.org/

2. Configuration de Nagios
 on édit le fichier nagios.cfg
```
sudo nano /usr/local/nagios/etc/nagios.cfg
```
décommenter la ligne:


#cfg_file=/usr/local/nagios/etc/objects/windows.cfg
Modifier mettre l'adresse IP  du serveur nagios :
```
define host{
	use		windows-server	; Inherit default values from a Windows server template (make sure you keep this line!)
	host_name		winserver
	alias		My Windows Server
	address		192.168.11.106
	}
```

Redémarrage du système:



