drop table student_admin cascade constraints;
create table student_admin
(
  student_id number,
  department varchar2(10),
  primary key (student_id)
);
