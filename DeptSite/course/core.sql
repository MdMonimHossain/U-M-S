create or replace package course as
    procedure add_course(course_id in varchar, course_title in varchar, teacher_id in number, description in varchar, course_fee in number, credit in number);
    procedure enroll_student(student_id in number, course_id in varchar, session_id in number);
    procedure update_grade(std_id in number, crs_id in varchar, ses_id in number, mrks in number);
    function calculate_grade(marks in number) return number;

    procedure grade_graph(cid in varchar2, snname in varchar2);
end course;
/



create or replace package body course as
    
    procedure add_course(course_id in varchar, course_title in varchar, teacher_id in number, description in varchar, course_fee in number, credit in number) is
    begin
        insert into course_cse values(course_id, course_title, teacher_id, description, course_fee, credit);
    end add_course;



    procedure enroll_student(student_id in number, course_id in varchar, session_id in number) is
    begin
        insert into course_enrollment_cse values(student_id, course_id, session_id, null, null);
    end enroll_student;


    
    procedure update_grade(std_id in number, crs_id in varchar, ses_id in number, mrks in number) is
    begin
        update course_enrollment_cse set marks = mrks where student_id = std_id and course_id = crs_id and session_id = ses_id;
        student_pkg.update_stats(std_id, ses_id);
    end update_grade;



    function calculate_grade(marks in number) return number is
    begin
        if marks >= 80 then
            return 4;
        elsif marks >= 75 then
            return 3.75;
        elsif marks >= 70 then
            return 3.5;
        elsif marks >= 65 then
            return 3.25;
        elsif marks >= 60 then
            return 3;
        elsif marks >= 55 then
            return 2.75;
        elsif marks >= 50 then
            return 2.5;
        elsif marks >= 45 then
            return 2.25;
        elsif marks >= 40 then
            return 2;
        else
            return 0;
        end if;
    end calculate_grade;


    procedure grade_graph(cid in varchar2, snname in varchar2) is
        type grade_points_array is varray(10) of float;
        type grade_letters_array is varray(10) of varchar2(2);
        grade_points grade_points_array;
        grade_letters grade_letters_array;
        c int := 0;
        total int := 0;
        snid number;
    begin
        grade_points := grade_points_array(0.00, 2.00, 2.25, 2.50, 2.75, 3.00, 3.25, 3.50, 3.75, 4.00);
        grade_letters := grade_letters_array('F ', 'D ', 'C ', 'C+', 'B-', 'B ', 'B+', 'A-', 'A ', 'A+');
        snid := s_sessions.get_id@admin_site(snname);
        select count(*) into total from course_enrollment_cse where course_id=cid and session_id=snid;
        if total = 0 then
            dbms_output.put_line('No student enrolled in this course in the gives session.');
            return;
        end if;
        dbms_output.put_line('Total students : ' || total);
        for i in 1..10 loop
            select count(*) into c from course_enrollment_cse where course_id=cid and session_id=snid and grade = grade_points(i);
            dbms_output.put(grade_letters(i) || ':' || c || '    ');
        end loop;
        dbms_output.put_line('Grade Distribution Graph: ');
        for i in 1..10 loop
            select round(count(*)/total*100, 0) into c from course_enrollment_cse where course_id=cid and session_id=snid and grade = grade_points(i);
            dbms_output.put_line(grade_letters(i) || ' : ' || rpad('*', c*2, '*'));
        end loop;
    end grade_graph;

end course;
/
