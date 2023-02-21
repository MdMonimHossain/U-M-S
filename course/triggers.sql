create or replace trigger course_write_check
before insert or update or delete on course_cse
for each row
begin
    auth.role_check('teacher');
end;
/


create or replace trigger course_enrollment_write_check
before insert or update or delete on course_enrollment_cse
for each row

declare

    course_teacher_id number;
    is_enrolled number;

begin
    auth.role_check('teacher');
    
    -- now checking if the current_user is the one who is teaching the course
    select teacher_id into course_teacher_id from course_cse where course_id = :new.course_id;
    if course_teacher_id != auth.current_user_id then
        -- rollback;
        raise_application_error(-20001, 'You are not the teacher of this course!');
    end if;

    -- now checking if the student is enrolled in the session
    if inserting then
        select count(*) into is_enrolled from session_enrollment_cse where student_id = :new.student_id and session_id = :new.session_id;
        if is_enrolled = 0 then
            -- rollback;
            raise_application_error(-20001, 'Student is not enrolled in the session!');
        end if;
    end if;
end;
/


create or replace trigger auto_update_grade
before update of marks on course_enrollment_cse
for each row

declare

    session_credit number;
    gpa number;
    total_credit number;
    cgpa number;

begin
    select course.calculate_grade(:new.marks) into :new.grade from dual;    
end auto_update_grade;
/
