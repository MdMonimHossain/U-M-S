set verify off;

drop database link dept_site;

create database link dept_site
 connect to system identified by "123"
 using '(DESCRIPTION =
       (ADDRESS_LIST =
         (ADDRESS = (PROTOCOL = TCP)
		 (HOST = 0.tcp.ap.ngrok.io)
		 (PORT = &port))
       )
       (CONNECT_DATA =
         (SID = XE)
       )
     )'
;  
