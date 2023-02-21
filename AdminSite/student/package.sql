create or replace package student as
    procedure add(stid in number, stname in varchar2, pass in number, dept in varchar2);
    procedure remove(stid in number);
    procedure update_name(stid in number, stname in varchar2);
    procedure show(stid in number);
    procedure show_all;
    procedure total_fees(stid in number, snname in varchar2);
    procedure total_fees_all(dept in varchar2, snname in varchar2);

end student;
/

create or replace package body student as
    procedure add(stid in number, stname in varchar2, pass in number, dept in varchar2) is
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            insert into student_admin values (stid, dept);
            if dept = 'cse' then
                insert into student_cse@dept_site(student_id,student_name,"password") values(stid, stname, pass);
            --else
                --insert into student_eee@dept_site(student_id,student_name,"password") values(stid, stname, pass);
            end if;
        end if;
        commit;
    exception
        when dup_val_on_index then
            dbms_output.put_line('Student with id ' || stid || ' already exists');
        when others then
            dbms_output.put_line('Error occured');
    end add;

    procedure remove(stid in number) is
    dept varchar2(10);
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            select department into dept from student_admin where student_id = stid;
            delete from student_admin where student_id = stid;
            if dept = 'cse' then
                delete from student_cse@dept_site where student_id = stid;
            --else
                --delete from student_eee@dept_site where student_id = stid;
            end if;
        end if;
        commit;
    exception
        when no_data_found then
            dbms_output.put_line('No student with id ' || stid);
        when others then
            dbms_output.put_line('Error occured');
    end remove;

    procedure update_name(stid in number, stname in varchar2) is
    dept varchar2(10);
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            select department into dept from student_admin where student_id = stid;
            if dept = 'cse' then
                update student_cse@dept_site set student_name = stname where student_id = stid;
            --else
                --update student_eee@dept_site set student_name = stname where student_id = stid;
            end if;
        end if;
        commit;
    exception
        when no_data_found then
            dbms_output.put_line('No student with id ' || stid);
        when others then
            dbms_output.put_line('Error occured');
    end update_name;

    procedure show(stid in number) is
    stname varchar2(20);
    dept varchar2(10);
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            select department into dept from student_admin where student_id = stid;
            if dept = 'cse' then
                select student_name into stname from student_cse@dept_site where student_id = stid;
            --else
                --select student_name into stname from student_eee@dept_site where student_id = stid;
            end if;
            dbms_output.put_line('Student id: ' || stid || ' name: ' || stname || ' department: ' || dept);
        end if;
    exception
        when no_data_found then
            dbms_output.put_line('No student with id ' || stid);
        when others then
            dbms_output.put_line('Error occured');
    end show;

    procedure show_all is
    begin
        for i in (select * from student_admin) loop
            show(i.student_id);
        end loop;
    exception
        when others then
            dbms_output.put_line('Error occured');
    end show_all;

    procedure total_fees(stid in number, snname in varchar2) is
    dept varchar2(10);
    sname varchar2(20);
    s_fee number;
    total number;
    snid number;
    begin
        if auth.is_logged_in = 0 then
            dbms_output.put_line('You are not logged in');
        else
            select department into dept from student_admin where student_id = stid;
            snid := s_sessions.get_id(snname);
            if dept = 'cse' then
                select student_name into sname from student_cse@dept_site where student_id = stid;
                select s.session_fee into s_fee from s_session s join session_enrollment_cse@dept_site se on s.session_id = se.session_id where se.student_id = stid and se.session_id = snid;
                select sum(c.course_fee) into total from course_cse@dept_site c join course_enrollment_cse@dept_site ce on c.course_id = ce.course_id where ce.student_id = stid;
            --else
                --select student_name into sname from student_eee@dept_site where student_id = stid;
                --select s.session_fee into s_fee from s_session s join session_enrollment_eee@dept_site se on s.session_id = se.session_id where se.student_id = stid and se.session_id = snid;
                --select sum(c.course_fee) into total from course_eee@dept_site c join course_enrollment_eee@dept_site ce on c.course_id = ce.course_id where ce.student_id = stid;
            end if;
            if total is null then
                total := 0;
            end if;
            total := total + s_fee;
            dbms_output.put_line('Total fees of student ' || sname || ' with id ' || stid || ' is ' || total);
        end if;
    exception
        when no_data_found then
            dbms_output.put_line('No student with id ' || stid || ' enrolled in session ' || snname);
        when others then
            dbms_output.put_line('Error occured');
    end total_fees;

    procedure total_fees_all(dept in varchar2, snname in varchar2) is
    begin
        for i in (select student_id from student_admin where department = dept) loop
            total_fees(i.student_id, snname);
        end loop;
    exception
        when others then
            dbms_output.put_line('Error occured');
    end total_fees_all;

end student;
/
