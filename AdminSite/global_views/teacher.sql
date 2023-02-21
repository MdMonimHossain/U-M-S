create or replace view teacher_view(teacher_id, teacher_name, department, designation, salary, "PASSWORD") as
select a.teacher_id, d.teacher_name, a.department, d.designation, a.salary, d."password" from teacher_admin a join teacher_cse@dept_site d on a.teacher_id = d.teacher_id;

select * from teacher_view;