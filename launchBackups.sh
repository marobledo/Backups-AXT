#!/usr/bin/bash

HOME_HOSTS=/opt/respaldos/command/data/hosts
HOME_LOGS=/opt/respaldos/command/data/log

#### Borramos los logs del dia anterior ####
cp $HOME_LOGS/error.log $HOME_LOGS/error.log.1
cat /dev/null > $HOME_LOGS/error.log

##### CISCO #####
FILE_CISCO=$HOME_HOSTS/hosts_CISCO
FILES_SPLIT_CISCO=$HOME_HOSTS/hosts_CISCO_
FILES_EXEC_CISCO=$HOME_HOSTS/hosts_CISCO_*

cat /etc/hosts | egrep -i "CISCO|FTP" | egrep -v "^#|ALCATEL|SERVER|DPI|SSH|DTC" | sort | uniq | awk '{print $2}' > $FILE_CISCO
split -l 100 $FILE_CISCO $FILES_SPLIT_CISCO

for f in $FILES_EXEC_CISCO
do
  /usr/bin/perl /opt/respaldos/command/BackupTotCISCO.pl  $f & 
  sleep 10
done
 
##### ALCATEL #####
FILE_ALCATEL=$HOME_HOSTS/hosts_ALCATEL
FILES_SPLIT_ALCATEL=$HOME_HOSTS/hosts_ALCATEL_
FILES_EXEC_ALCATEL=$HOME_HOSTS/hosts_ALCATEL_*

cat /etc/hosts | egrep -i "ALCATEL" | egrep -v "^#|7250|IGNORE" | sort | uniq | awk '{print $2}' > $FILE_ALCATEL
split -l 100 $FILE_ALCATEL $FILES_SPLIT_ALCATEL

for f in $FILES_EXEC_ALCATEL

do
  /usr/bin/perl /opt/respaldos/command/BackupALCATEL.pl  $f &
  sleep 10
done

##### ALCATEL7250 #####
FILE_ALCATEL7250=$HOME_HOSTS/hosts_ALCATEL7250
FILES_SPLIT_ALCATEL7250=$HOME_HOSTS/hosts_ALCATEL7250_
FILES_EXEC_ALCATEL7250=$HOME_HOSTS/hosts_ALCATEL7250_*

cat /etc/hosts | egrep -i "ALCATEL" | egrep -i "7250" | sort | uniq | awk '{print $2}' > $FILE_ALCATEL7250
split -l 100 $FILE_ALCATEL7250 $FILES_SPLIT_ALCATEL7250

for f in $FILES_EXEC_ALCATEL7250

do
  /usr/bin/perl /opt/respaldos/command/BackupALCATEL7250.pl  $f &
  sleep 10
done

##### DPI #####
FILE_DPI=$HOME_HOSTS/hosts_DPI
FILES_SPLIT_DPI=$HOME_HOSTS/hosts_DPI_
FILES_EXEC_DPI=$HOME_HOSTS/hosts_DPI_*

cat /etc/hosts | grep -i "DPI" | grep -v "^#" | sort | uniq | awk '{print $2}' > $FILE_DPI
split -l 100 $FILE_DPI $FILES_SPLIT_DPI

for f in $FILES_EXEC_DPI

do
  /usr/bin/perl /opt/respaldos/command/BackupDPI.pl  $f &
  sleep 10
done

##### REDBACK #####
FILE_REDBACK=$HOME_HOSTS/hosts_REDBACK
FILES_SPLIT_REDBACK=$HOME_HOSTS/hosts_REDBACK_
FILES_EXEC_REDBACK=$HOME_HOSTS/hosts_REDBACK_*


cat /etc/hosts | grep -i "REDBACK" | grep -v "^#" | sort | uniq | awk '{print $2}' > $FILE_REDBACK
split -l 100 $FILE_REDBACK $FILES_SPLIT_REDBACK

for f in $FILES_EXEC_REDBACK

do
  /usr/bin/perl /opt/respaldos/command/BackupREDBACK.pl  $f &
  sleep 10
done

##### FOUNDRY #####
FILE_FOUNDRY=$HOME_HOSTS/hosts_FOUNDRY
FILES_SPLIT_FOUNDRY=$HOME_HOSTS/hosts_FOUNDRY_
FILES_EXEC_FOUNDRY=$HOME_HOSTS/hosts_FOUNDRY_*


cat /etc/hosts | grep -i "FOUNDRY" | grep -v "^#" | sort | uniq | awk '{print $2}' > $FILE_FOUNDRY
split -l 100 $FILE_FOUNDRY $FILES_SPLIT_FOUNDRY

for f in $FILES_EXEC_FOUNDRY

do
  /usr/bin/perl /opt/respaldos/command/BackupFOUNDRY.pl  $f &
  sleep 10
done

#####  DTC  #####
FILE_DTC=$HOME_HOSTS/hosts_DTC
FILES_SPLIT_DTC=$HOME_HOSTS/hosts_DTC_
FILES_EXEC_DTC=$HOME_HOSTS/hosts_DTC_*


cat /etc/hosts | grep -i "DTC" | grep -v "^#" | sort | uniq | awk '{print $2}' > $FILE_DTC
split -l 100 $FILE_DTC $FILES_SPLIT_DTC

for f in $FILES_EXEC_DTC

do
  /usr/bin/perl /opt/respaldos/command/BackupDTC.pl  $f &
  sleep 10
done
