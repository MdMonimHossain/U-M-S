create or replace trigger student_admin_insert_trigger
after insert on student_admin
for each row
begin
    dbms_output.put_line('New student added: ' || :new.student_id || ' in department: ' || :new.department);
end;
/

create or replace trigger student_admin_delete_trigger
after delete on student_admin
for each row
begin
    dbms_output.put_line('Student deleted: ' || :old.student_id);
end;
/
