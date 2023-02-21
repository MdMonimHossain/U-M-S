create or replace trigger teacher_admin_insert_trigger
after insert on teacher_admin
for each row
begin
    dbms_output.put_line('New teacher added: ' || :new.teacher_id || ' in department: ' || :new.department);
end;
/

create or replace trigger teacher_admin_delete_trigger
after delete on teacher_admin
for each row
begin
    dbms_output.put_line('Teacher deleted: ' || :old.teacher_id);
end;
/

create or replace trigger teacher_admin_update_trigger
after update of salary on teacher_admin
for each row
begin
    dbms_output.put_line('Teacher salary updated: ' || :new.teacher_id || ' with new salary: ' || :new.salary);
end;
/
