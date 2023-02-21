drop table teacher_admin cascade constraints;
create table teacher_admin
(
  teacher_id number,
  department varchar2(10),
  salary number,
  primary key (teacher_id)
);
