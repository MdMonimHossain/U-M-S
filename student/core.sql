create or replace package student_pkg as
    function calculate_session_credit(p_student_id in number, p_session_id in number) return number;
    function calculate_gpa(p_student_id in number, p_session_id in number) return number;
    function calculate_total_credit(p_student_id in number) return number;
    function calculate_cgpa(p_student_id in number) return number;

    procedure update_stats(std_id in number, ses_id in number);
    procedure mark_sheet(p_session in varchar);
end student_pkg;
/



create or replace package body student_pkg as
    
    function calculate_session_credit(p_student_id in number, p_session_id in number) return number is
        v_flag number;
        v_credit number;
    begin
        -- if student is not enrolled in the session
        select count(*) into v_flag from session_enrollment_cse senr where senr.student_id = p_student_id and senr.session_id = p_session_id;
        if v_flag = 0 then
            return -1;
        end if;

        -- if student is enrolled in the session
        select sum(crs.credit) into v_credit from course_enrollment_cse cenr natural join course_cse crs 
            where cenr.student_id = p_student_id and cenr.session_id = p_session_id and cenr.grade is not null;
        return v_credit;
    end calculate_session_credit;


    
    function calculate_gpa(p_student_id in number, p_session_id in number) return number is
        v_flag number;
        v_gpa number;
    begin
        -- if student is not enrolled in the session
        select count(*) into v_flag from session_enrollment_cse senr where senr.student_id = p_student_id and senr.session_id = p_session_id;
        if v_flag = 0 then
            return 0;
        end if;

        -- if student is enrolled in the session
        select sum(cenr.grade * crs.credit) / sum(crs.credit) into v_gpa from course_enrollment_cse cenr natural join course_cse crs 
            where cenr.student_id = p_student_id and cenr.session_id = p_session_id and cenr.grade is not null;
        return v_gpa;
    end calculate_gpa;
    

    
    function calculate_total_credit(p_student_id in number) return number is
        v_flag number;
        v_credit number;
    begin
        -- if student is not enrolled in any session
        select count(*) into v_flag from session_enrollment_cse senr where senr.student_id = p_student_id;
        if v_flag = 0 then
            return 0;
        end if;

        -- if student is enrolled in any session
        select sum(crs.credit) into v_credit from course_enrollment_cse cenr natural join course_cse crs 
            where cenr.student_id = p_student_id and cenr.grade is not null;
        return v_credit;
    end calculate_total_credit;


    function calculate_cgpa(p_student_id in number) return number is

        v_flag number;
        v_cgpa number;

    begin
        -- if student is not enrolled in any session
        select count(*) into v_flag from session_enrollment_cse senr where senr.student_id = p_student_id;
        if v_flag = 0 then
            return 0;
        end if;

        -- if student is enrolled in any session
        select sum(cenr.grade * crs.credit) / sum(crs.credit) into v_cgpa from course_enrollment_cse cenr natural join course_cse crs 
            where cenr.student_id = p_student_id and cenr.grade is not null;
        return v_cgpa;
    end calculate_cgpa;



    procedure update_stats(std_id in number, ses_id in number) is

        v_session_credit number;
        v_gpa number;
        v_completed_credit number;
        v_cgpa number;

    begin

        dbms_output.put_line('student_id: ' || std_id);
        dbms_output.put_line('session_id: ' || ses_id);

        select student_pkg.calculate_session_credit(std_id, ses_id) into v_session_credit from dual;
        select student_pkg.calculate_gpa(std_id, ses_id) into v_gpa from dual;

        dbms_output.put_line('session_credit: ' || v_session_credit);
        dbms_output.put_line('gpa: ' || v_gpa);


        update session_enrollment_cse senr set senr.gpa = v_gpa, senr.total_credit = v_session_credit where senr.student_id = std_id and senr.session_id = ses_id;

        select student_pkg.calculate_total_credit(std_id) into v_completed_credit from dual;
        select student_pkg.calculate_cgpa(std_id) into v_cgpa from dual;

        dbms_output.put_line('total_credit: ' || v_completed_credit);
        dbms_output.put_line('cgpa: ' || v_cgpa);
        
        update student_cse std set std.completed_credit = v_completed_credit, std.cgpa = v_cgpa 
            where std.student_id = std_id;
    end update_stats;



    procedure mark_sheet(p_session in varchar) is
    
        flag number;

        std_name varchar(50);
        std_id number := auth.current_user_id;
        v_session_id number;
        
        v_completed_credit number;
        v_cgpa number;
        v_session_credit number;
        v_gpa number;
    
    begin

        select count(*) into flag from s_session@admin_site where session_name = p_session;
        
        if flag = 0 then
            dbms_output.put_line('Session does not exist');
            return;
        end if;

        select session_id into v_session_id from s_session@admin_site where session_name = p_session;
        
        -- if student is not enrolled in the session
        select count(*) into flag from session_enrollment_cse 
            where student_id = std_id and session_id = v_session_id;
        if flag = 0 then
            dbms_output.put_line('Student is not enrolled in the session');
            return;
        end if;


        -- if student is enrolled in the session
        select student_name, completed_credit, cgpa into std_name, v_completed_credit, v_cgpa from student_cse 
            where student_id = std_id;
        select gpa, total_credit into v_gpa, v_session_credit from session_enrollment_cse 
            where student_id = std_id and session_id = v_session_id;
        
        
        dbms_output.put_line('Name: ' || std_name);
        dbms_output.put_line('ID: ' || std_id);
        dbms_output.put_line('Total Completed Credit: ' || v_completed_credit);
        dbms_output.put_line('CGPA: ' || v_cgpa);
        
        dbms_output.put_line(chr(13));

        dbms_output.put_line('Session: ' || p_session);
        dbms_output.put_line('Session Total Credit: ' || v_session_credit);
        dbms_output.put_line('GPA: ' || v_gpa);

        dbms_output.put_line(chr(13));

        dbms_output.put_line('Course Code ' || chr(9) || ' Course Title ' || chr(9) || ' Credit ' || chr(9) || ' Grade');
        dbms_output.put_line('---------- ' || chr(9) || '----------- ' || chr(9) || ' ------ ' || chr(9) || ' -----');
        
        for crs in (select crs.course_id, crs.course_title, crs.credit, cenr.grade from course_cse crs 
            join course_enrollment_cse cenr on crs.course_id = cenr.course_id 
            where cenr.student_id = std_id and cenr.session_id = v_session_id and cenr.grade is not null)
        loop
            dbms_output.put_line(crs.course_id || ' ' || chr(9) || ' ' || crs.course_title || ' ' || chr(9) || ' ' || crs.credit || chr(9) || ' ' || crs.grade);
        end loop;

        
    end mark_sheet;

end student_pkg;
/

