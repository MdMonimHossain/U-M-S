create or replace package auth as
    procedure login(pass in number, user_type in varchar); -- 123, 'admin'
    procedure logout;
    function is_logged_in return number;
end auth;
/

create or replace package body auth as
    procedure login(pass in number, user_type in varchar) is
    begin
        auth.login@dept_site('1', pass, user_type);
        if(auth.get_status@dept_site = 1) then
            dbms_output.put_line('Login successful');
        else
            dbms_output.put_line('Login failed');
        end if;
    end login;

    procedure logout is
    begin
        auth.logout@dept_site;
        dbms_output.put_line('Logged out');
    end logout;

    function is_logged_in return number is
    begin
        return auth.get_status@dept_site;
    end is_logged_in;
end auth;
/