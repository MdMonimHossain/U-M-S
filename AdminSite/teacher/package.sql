create or replace package teacher as
    procedure add(tid in number, tname in varchar2, pass in number, dept in varchar2, desig in varchar2, sal in number);
    procedure remove(tid in number);
    procedure update_name(tid in number, tname in varchar2);
    procedure update_salary(tid in number, sal in number);
    procedure update_designation(tid in number, desig in varchar2);
    procedure show(tid in number);
    procedure show_all;

end teacher;
/

create or replace package body teacher as
    procedure add(tid in number, tname in varchar2, pass in number, dept in varchar2, desig in varchar2, sal in number) is
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            insert into teacher_admin values (tid, dept, sal);
            if dept = 'cse' then
                insert into teacher_cse@dept_site(teacher_id,teacher_name,"password",designation) values(tid, tname, pass, desig);
            --else
                --insert into teacher_eee@dept_site(teacher_id,teacher_name,"password",designation) values(tid, tname, pass, desig);
            end if;
        end if;
        commit;
    exception
        when dup_val_on_index then
            dbms_output.put_line('Teacher with id ' || tid || ' already exists');
        when others then
            dbms_output.put_line('Error occured');
    end add;

    procedure remove(tid in number) is
    dept varchar2(10);
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            select department into dept from teacher_admin where teacher_id = tid;
            delete from teacher_admin where teacher_id = tid;
            if dept = 'cse' then
                delete from teacher_cse@dept_site where teacher_id = tid;
            --else
                --delete from teacher_eee@dept_site where teacher_id = tid;
            end if;
        end if;
        commit;
    exception
        when no_data_found then
            dbms_output.put_line('No teacher with id ' || tid);
        when others then
            dbms_output.put_line('Error occured');
    end remove;

    procedure update_salary(tid in number, sal in number) is
    begin
        update teacher_admin set salary = sal where teacher_id = tid;
        commit;
    exception
        when no_data_found then
            dbms_output.put_line('No teacher with id ' || tid);
        when others then
            dbms_output.put_line('Error occured');
    end update_salary;

    procedure update_name(tid in number, tname in varchar2) is
    dept varchar2(10);
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            select department into dept from teacher_admin where teacher_id = tid;
            if dept = 'cse' then
                update teacher_cse@dept_site set teacher_name = tname where teacher_id = tid;
            --else
                --update teacher_eee@dept_site set teacher_name = tname where teacher_id = tid;
            end if;
        end if;
        commit;
    exception
        when no_data_found then
            dbms_output.put_line('No teacher with id ' || tid);
        when others then
            dbms_output.put_line('Error occured');
    end update_name;

    procedure update_designation(tid in number, desig in varchar2) is
    dept varchar2(10);
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            select department into dept from teacher_admin where teacher_id = tid;
            if dept = 'cse' then
                update teacher_cse@dept_site set designation = desig where teacher_id = tid;
            --else
                --update teacher_eee@dept_site set designation = desig where teacher_id = tid;
            end if;
        end if;
        commit;
    exception
        when no_data_found then
            dbms_output.put_line('No teacher with id ' || tid);
        when others then
            dbms_output.put_line('Error occured');
    end update_designation;

    procedure show(tid in number) is
    tname varchar2(20);
    dept varchar2(10);
    desig varchar2(20);
    sal number;
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            select department, salary into dept, sal from teacher_admin where teacher_id = tid;
            if dept = 'cse' then
                select teacher_name, designation into tname, desig from teacher_cse@dept_site where teacher_id = tid;
            --else
                --select teacher_name, designation into tname, desig from teacher_eee@dept_site where teacher_id = tid;
            end if;
            dbms_output.put_line('Teacher id: ' || tid || ' name: ' || tname || ' department: ' || dept || ' designation: ' || desig || ' salary: ' || sal);
        end if;
    exception
        when no_data_found then
            dbms_output.put_line('No teacher with id ' || tid);
        when others then
            dbms_output.put_line('Error occured');
    end show;

    procedure show_all is
    begin
        for i in (select * from teacher_admin) loop
            show(i.teacher_id);
        end loop;
    exception
        when others then
            dbms_output.put_line('Error occured');
    end show_all;

end teacher;
/
