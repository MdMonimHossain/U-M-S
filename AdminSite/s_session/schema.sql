drop table s_session cascade constraints;
create table s_session
(
  session_id number,
  session_name varchar2(20) unique,
  session_fee number,
  primary key (session_id)
);
