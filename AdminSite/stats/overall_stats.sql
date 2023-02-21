create or replace procedure stats is
    cse_student_count number;
    cse_teacher_count number;
    cse_course_count number;
begin
    if auth.is_logged_in = 0 then
        dbms_output.put_line('You are not logged in');
    else
        dbms_output.put_line('CSE Department:');
        select count(*) into cse_student_count from student_admin where department = 'cse';
        select count(*) into cse_teacher_count from teacher_admin where department = 'cse';
        select count(*) into cse_course_count from course_cse@dept_site;
        dbms_output.put_line(cse_student_count || ' students, ' || cse_teacher_count || ' teachers and ' || cse_course_count || ' courses');
    end if;
end stats;
/