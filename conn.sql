set verify off;

drop database link admin_site;

create database link admin_site
    connect to system identified by "12345" using 
    '(
        DESCRIPTION =
        (
            ADDRESS_LIST =
                (ADDRESS = (PROTOCOL = TCP)
                (HOST = &host)
                (PORT = &port))
        )
        (
            CONNECT_DATA = (SID = XE)
        )
    )'
;  