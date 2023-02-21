create or replace package auth as
    is_logged_in number := 0;
    current_user_id varchar(20);
    current_user_type varchar(20);

    procedure login(user_id in varchar, psw in number, user_type in varchar);
    procedure logout;
    procedure display;
    procedure role_check(user_type in varchar);
    function get_status return number;
end auth;
/



create or replace package body auth as
    
    procedure login(user_id in varchar, psw in number, user_type in varchar) is
    hashed_pass number;
    begin
        select ora_hash(psw) into hashed_pass from dual;
        if user_type = 'student' then
            select count(*) into is_logged_in from student_cse where student_id = user_id and "password" = hashed_pass;
            if is_logged_in = 1 then
                dbms_output.put_line('[*] Succesfully logged in as ' || user_id);
                current_user_id := user_id;
                current_user_type := user_type;
            else
                dbms_output.put_line('[!] Invalid user-id-password combination');
            end if;
        
        elsif user_type = 'teacher' then
            select count(*) into is_logged_in from teacher_cse where teacher_id = user_id and "password" = hashed_pass;
            if is_logged_in = 1 then
                dbms_output.put_line('[*] Succesfully logged in as ' || user_id);
                current_user_id := user_id;
                current_user_type := user_type;
            else
                dbms_output.put_line('[!] Invalid user-id-password combination');
            end if;
        elsif user_type = 'admin' then
            if hashed_pass = 1865268886 then
                is_logged_in := 1;
                current_user_type := 'admin';
            end if;
        else 
            dbms_output.put_line('[!] Invalid user_type!');
        end if;
    end login;

    
    
    procedure logout is
    begin
        is_logged_in := 0;
        current_user_id := '';
        current_user_type := '';
        dbms_output.put_line('[*] Succesfully logged out');
    end logout;


    
    procedure display is
        user_name varchar(20);
    begin
        if is_logged_in = 1 then
            if current_user_type = 'student' then
                select student_name into user_name from student_cse where student_id = current_user_id;
            elsif current_user_type = 'teacher' then
                select teacher_name into user_name from teacher_cse where teacher_id = current_user_id;
            end if;
            dbms_output.put_line('[*] Current User Info');
            dbms_output.put_line('user_id: ' || current_user_id);
            dbms_output.put_line('user_name: ' || user_name);
            dbms_output.put_line('user_type: ' || current_user_type);
        else
            dbms_output.put_line('Not logged in currently!');
        end if;
    end display;



    procedure role_check(user_type in varchar) is
    begin
        if not (is_logged_in = 1 and current_user_type = user_type) then
            -- rollback;
            raise_application_error(-20001, 'Not logged in or Permission Denied!');
        end if;
    end role_check;


    function get_status return number is
    begin
        return is_logged_in;
    end get_status;

end auth;
/
