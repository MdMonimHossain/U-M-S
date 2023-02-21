create or replace trigger student_write_check
before insert or delete on student_cse
for each row
begin
    auth.role_check('admin');
    if inserting then 
            select ora_hash(:new."password") into :new."password" from dual;
    end if;
end;
/


create or replace trigger student_update_check
before update of student_id, student_name on student_cse
for each row
begin
    auth.role_check('admin');
end;
/



create or replace trigger student_update_check2
before update of completed_credit, cgpa on student_cse
for each row
begin
    auth.role_check('teacher');
end;
/



create or replace trigger student_pass_hash
before update of "password" on student_cse
for each row
begin
    auth.role_check('admin');
    select ora_hash(:new."password") into :new."password" from dual;
end;
/


create or replace trigger session_enrollment_write_check
before insert or delete on session_enrollment_cse
for each row
begin
    auth.role_check('admin');
end;
/


create or replace trigger session_enrollment_update_check
before update of gpa, total_credit on session_enrollment_cse
for each row
begin
    auth.role_check('teacher');
end;
/


-- not tested 
create or replace trigger session_enrollment_update_check2
before update of student_id, session_id on session_enrollment_cse
for each row
begin
    auth.role_check('admin');
end;
/

