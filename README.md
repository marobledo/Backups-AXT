# Backups-AXT

General description:
This program perform backups for routers and switches of different vendors like CISCO, ALCATEL, REDBACK, etc. It runs different commands through a telnet connecion (It could be SSH too) and store the output into text files based on creation dates and hostnames.
At the end users can go and download these from a web page based on CGI.


Perl modules needed: 

Net::Telnet
It is to connect to the equipments.

fecha.pm 
Put it into the perl modules path like /usr/lib/perl5/5.8.8/ is used for know the date, hour and yesterday date


Scripts:

launchBackups.sh
Bash script that launches different backup scripts based on models. It search for equipment into the /etc/hosts and store the output       into a file that then splits into 100 equipments per execution.

BackupTotCISCO.pl
It performs CISCO Backups, based on an array of commands and store the output into the server based on hostnames and dates
  

  
