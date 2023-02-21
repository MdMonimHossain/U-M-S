create or replace view student_view(student_id, student_name, department, "PASSWORD") as
select a.student_id, d.student_name, a.department, d."password" from student_admin a join student_cse@dept_site d on a.student_id = d.student_id;

select * from student_view;