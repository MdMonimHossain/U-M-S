create or replace package s_sessions as
    procedure add(snname in varchar2, snfee in number);
    procedure remove(snid in number);
    procedure update_name(snid in number, snname in varchar2);
    procedure update_fee(snid in number, snfee in number);
    procedure show(snid in number);
    procedure show_all;

    function get_fee(snid in number) return number;
    function get_name(snid in number) return varchar2;
    function get_id(sname in varchar2) return number;

    procedure enroll(stid in number, snname in varchar2);
end s_sessions;
/

create or replace package body s_sessions as
    procedure add(snname in varchar2, snfee in number) is
    begin
        insert into s_session(session_name, session_fee) values (snname, snfee);
        commit;
    exception
        when dup_val_on_index then
            dbms_output.put_line('Session with name ' || snname || ' already exists');
        when others then
            dbms_output.put_line('Error occured');
    end add;

    procedure remove(snid in number) is
    is_valid int;
    begin
        select count(*) into is_valid from s_session where session_id = snid;
        delete from s_session where session_id = snid;
        commit;
    exception
        when no_data_found then
            dbms_output.put_line('No session with ID ' || snid);
        when others then
            dbms_output.put_line('Error occured');
    end remove;

    procedure update_name(snid in number, snname in varchar2) is
    is_valid int;
    begin
        select count(*) into is_valid from s_session where session_id = snid;
        update s_session set session_name = snname where session_id = snid;
        commit;
    exception
        when no_data_found then
            dbms_output.put_line('No session with ID ' || snid);
        when others then
            dbms_output.put_line('Error occured');
    end update_name;

    procedure update_fee(snid in number, snfee in number) is
    is_valid int;
    begin
        select count(*) into is_valid from s_session where session_id = snid;
        update s_session set session_fee = snfee where session_id = snid;
        commit;
    exception
        when no_data_found then
            dbms_output.put_line('No session with ID ' || snid);
        when others then
            dbms_output.put_line('Error occured');
    end update_fee;

    procedure show(snid in number) is
    name varchar2(20);
    fee number;
    begin
        select session_name, session_fee into name, fee from s_session where session_id = snid;
        dbms_output.put_line('Session Name: ' || name || ' Session Fee: ' || fee);
    exception
        when no_data_found then
            dbms_output.put_line('No session with ID ' || snid);
        when others then
            dbms_output.put_line('Error occured');
    end show;

    procedure show_all is
    data_found int := 0;
    begin
        for r in (select session_id, session_name, session_fee from s_session) loop
            data_found := 1;
            dbms_output.put_line('Session ID: ' || r.session_id || ' Session Name: ' || r.session_name || ' Session Fee: ' || r.session_fee);
        end loop;
        if data_found = 0 then
            dbms_output.put_line('No sessions found');
        end if;
    end show_all;

    function get_fee(snid in number) return number is
    fee number;
    begin
        select session_fee into fee from s_session where session_id = snid;
        return fee;
    exception
        when no_data_found then
            return -1;
    end get_fee;

    function get_name(snid in number) return varchar2 is
    name varchar2(20);
    begin
        select session_name into name from s_session where session_id = snid;
        return name;
    exception
        when no_data_found then
            return 'Not Found';
    end get_name;

    function get_id(sname in varchar2) return number is
    id number;
    begin
        select session_id into id from s_session where session_name = sname;
        return id;
    exception
        when no_data_found then
            return -1;
    end get_id;

    procedure enroll(stid in number, snname in varchar2) is
    snid number;
    dept varchar2(20);
    invalid_session exception;
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            snid := get_id(snname);
            if snid = -1 then
                raise invalid_session;
            end if;
            select department into dept from student_admin where student_id = stid;
            if dept = 'cse' then
                insert into session_enrollment_cse@dept_site(student_id, session_id) values (stid, snid);
            --else
                --insert into session_enrollment_eee@dept_site(student_id, session_id) values (stid, snid);
            end if;
        end if; 
        commit;
    exception
        when invalid_session then
            dbms_output.put_line('No session with name ' || snname);
        when no_data_found then
            dbms_output.put_line('No student with ID ' || stid);
        when others then
            dbms_output.put_line('Error occured');
    end enroll;

end s_sessions;
/