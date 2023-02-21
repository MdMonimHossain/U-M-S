create or replace trigger s_session_id_trigger
before insert on s_session
for each row
begin
  if :new.session_id is null then
    select count(*) + 1 into :new.session_id from s_session;
  end if;
end;
/

create or replace trigger s_session_insert_trigger
after insert on s_session
for each row
begin
    dbms_output.put_line('New session added: ' || :new.session_name || ' with fee: ' || :new.session_fee);
end;
/

create or replace trigger s_session_update_name_trigger
after update of session_name on s_session
for each row
begin
    dbms_output.put_line('Session name updated: previous name: ' || :old.session_name || ' new name: ' || :new.session_name);
end;
/

create or replace trigger s_session_update_fee_trigger
after update of session_fee on s_session
for each row
begin
    dbms_output.put_line('Session fee updated: previous fee: ' || :old.session_fee || ' new fee: ' || :new.session_fee);
end;
/

create or replace trigger s_session_delete_trigger
after delete on s_session
for each row
begin
    dbms_output.put_line('Session deleted: ' || :old.session_name);
end;
/