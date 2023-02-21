set serveroutput on;

drop table studenttest cascade constraints;
create table studenttest(id int, grade float);

insert into studenttest(id, grade) values(1, 2.00);
insert into studenttest(id, grade) values(2, 2.25);
insert into studenttest(id, grade) values(3, 2.50);
insert into studenttest(id, grade) values(4, 2.75);
insert into studenttest(id, grade) values(5, 3.00);
insert into studenttest(id, grade) values(6, 3.25);
insert into studenttest(id, grade) values(7, 3.50);
insert into studenttest(id, grade) values(8, 3.75);
insert into studenttest(id, grade) values(9, 4.00);
insert into studenttest(id, grade) values(10, 3.50);
insert into studenttest(id, grade) values(11, 3.50);
insert into studenttest(id, grade) values(12, 2.50);
insert into studenttest(id, grade) values(13, 2.75);
insert into studenttest(id, grade) values(14, 3.00);
insert into studenttest(id, grade) values(15, 3.25);
insert into studenttest(id, grade) values(16, 3.50);
insert into studenttest(id, grade) values(17, 3.75);
insert into studenttest(id, grade) values(18, 3.25);
insert into studenttest(id, grade) values(19, 3.25);
insert into studenttest(id, grade) values(20, 3.50);
insert into studenttest(id, grade) values(21, 3.50);
insert into studenttest(id, grade) values(22, 2.75);
insert into studenttest(id, grade) values(23, 3.00);
insert into studenttest(id, grade) values(24, 3.25);
insert into studenttest(id, grade) values(25, 3.50);
insert into studenttest(id, grade) values(26, 2.75);
insert into studenttest(id, grade) values(27, 3.00);
insert into studenttest(id, grade) values(28, 3.25);
insert into studenttest(id, grade) values(29, 3.50);
insert into studenttest(id, grade) values(30, 3.25);

commit;


create or replace procedure grade_graph
is
type grade_points_array is varray(10) of float;
type grade_letters_array is varray(10) of varchar2(2);
grade_points grade_points_array;
grade_letters grade_letters_array;
c int := 0;
total int := 0;
snid int;
begin
    grade_points := grade_points_array(0.00, 2.00, 2.25, 2.50, 2.75, 3.00, 3.25, 3.50, 3.75, 4.00);
    grade_letters := grade_letters_array('F ', 'D ', 'C ', 'C+', 'B-', 'B ', 'B+', 'A-', 'A ', 'A+');
    select count(*) into total from studenttest;
    dbms_output.put_line('Total students : ' || total);
    for i in 1..10 loop
        select count(*) into c from studenttest where grade = grade_points(i);
        dbms_output.put(grade_letters(i) || ':' || c || '    ');
    end loop;
    dbms_output.put_line('Grade Distribution Graph: ');
    for i in 1..10 loop
        select round(count(*)/total*100, 0) into c from studenttest where grade = grade_points(i);
        dbms_output.put_line(grade_letters(i) || ' : ' || rpad('*', c*2, '*'));
    end loop;
end grade_graph;
/

begin
    grade_graph;
end;
/
