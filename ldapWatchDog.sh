#!/bin/bash

RCLDAP=/usr/sbin/rcldap
LOGFILESOURCE="/var/log/ldap"
LOGFILETARGET="/var/log/ldap_"$(date +"%d%m%y_%H%M")

test -x $RCLDAP || exit 1

$RCLDAP status &>/dev/null
RETURNCODE=$?

# Folgende Aktionen:
# return 1 oder 2: status -> dead, also Log-File sichern, neu starten und Mail schreiben
# return 3: status -> not running, tue nichts
# return 0: status -> running, tue nichts
if [[ $RETURNCODE -eq 1 || $RETURNCODE -eq 2 ]]
then
    $RCLDAP stop
    /bin/mv $LOGFILESOURCE $LOGFILETARGET
    /usr/bin/touch $LOGFILESOURCE
    $RCLDAP start
    if [[ $? -eq 0 ]]
    then
        echo "LDAP Server erfolgreich neu gestartet. Logfile nach ${LOGFILETARGET} gesichert." | mail -s "[ERROR] LDAP Server lief nicht" michael.schaarschmidt@urz.uni-halle.de     
    else
        echo "LDAP Server erfolglos neu gestartet. Logfile nach ${LOGFILETARGET} gesichert." | mail -s "[ERROR] LDAP Server laeuft nicht" michael.schaarschmidt@urz.uni-halle.de     
    fi
fi