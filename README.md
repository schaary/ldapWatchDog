LDAP Watch Dog - Ueberwachung des LDAP Servers
==============================================

Der LDAP Server soll durch dieses Skript ueberwacht werden. Dabei sollen 
folgende Handlungen ausgefuehrt werden, falls der Dienst nicht laeuft:

* rcldap status -> return 2 oder return 3
  1. stoppe des LDAP Server mit rcldap stop
  2. sichere das LOG-File /var/log/ldap nach /var/log/ldap{CrashTimeStamp}.crashlog
  3. versuche des LDAP Server erneut zu starten mit rcldap start
  4. schreibe eine Mail an den Admin