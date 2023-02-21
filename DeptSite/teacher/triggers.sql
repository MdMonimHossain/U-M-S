create or replace trigger teacher_write_check
before insert or update or delete on teacher_cse
for each row
begin
    auth.role_check('admin');
    if inserting then 
            select ora_hash(:new."password") into :new."password" from dual;
    end if;
end;
/



create or replace trigger teacher_pass_hash
before update of "password" on teacher_cse
for each row
begin
    select ora_hash(:new."password") into :new."password" from dual;
end;
/
