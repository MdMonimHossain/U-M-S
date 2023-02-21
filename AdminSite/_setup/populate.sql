set serveroutput on;

exec auth.login@dept_site('1', 123, 'admin');


exec student.add(1, 'student1', 123, 'cse');
exec student.add(2, 'student2', 123, 'cse');
exec student.add(3, 'student3', 123, 'cse');
exec student.add(4, 'student4', 123, 'cse');
exec student.add(5, 'student5', 123, 'cse');
exec student.add(6, 'student6', 123, 'cse');
exec student.add(7, 'student7', 123, 'cse');
exec student.add(8, 'student8', 123, 'cse');
exec student.add(9, 'student9', 123, 'cse');
exec student.add(10, 'student10', 123, 'cse');
exec student.add(11, 'student11', 123, 'cse');
exec student.add(12, 'student12', 123, 'cse');
exec student.add(13, 'student13', 123, 'cse');
exec student.add(14, 'student14', 123, 'cse');
exec student.add(15, 'student15', 123, 'cse');
exec student.add(16, 'student16', 123, 'cse');
exec student.add(17, 'student17', 123, 'cse');
exec student.add(18, 'student18', 123, 'cse');
exec student.add(19, 'student19', 123, 'cse');
exec student.add(20, 'student20', 123, 'cse');


exec teacher.add(1, 'teacher1', 123, 'cse', 'professor', 100000);
exec teacher.add(2, 'teacher2', 123, 'cse', 'assistant professor', 80000);
exec teacher.add(3, 'teacher3', 123, 'cse', 'assistant professor', 80000);
exec teacher.add(4, 'teacher4', 123, 'cse', 'lecturer', 40000);
exec teacher.add(5, 'teacher5', 123, 'cse', 'lecturer', 40000);


exec s_sessions.add('spring 21', 82300);
exec s_sessions.add('fall 21', 82300);
exec s_sessions.add('spring 22', 102300);
exec s_sessions.add('fall 22', 102300);


exec s_sessions.enroll(1, 'spring 21');
exec s_sessions.enroll(2, 'spring 21');
exec s_sessions.enroll(3, 'spring 21');
exec s_sessions.enroll(4, 'spring 21');
exec s_sessions.enroll(1, 'fall 21');
exec s_sessions.enroll(2, 'fall 21');
exec s_sessions.enroll(3, 'fall 21');
exec s_sessions.enroll(4, 'fall 21');
exec s_sessions.enroll(1, 'spring 22');
exec s_sessions.enroll(2, 'spring 22');
exec s_sessions.enroll(3, 'spring 22');
exec s_sessions.enroll(4, 'spring 22');
exec s_sessions.enroll(1, 'fall 22');
exec s_sessions.enroll(2, 'fall 22');
exec s_sessions.enroll(3, 'fall 22');
exec s_sessions.enroll(4, 'fall 22');
exec s_sessions.enroll(5, 'spring 21');
exec s_sessions.enroll(6, 'spring 21');
exec s_sessions.enroll(7, 'spring 21');
exec s_sessions.enroll(8, 'spring 21');
exec s_sessions.enroll(9, 'spring 21');
exec s_sessions.enroll(10, 'spring 21');
exec s_sessions.enroll(11, 'fall 21');
exec s_sessions.enroll(12, 'fall 21');
exec s_sessions.enroll(13, 'fall 21');
exec s_sessions.enroll(14, 'spring 22');
exec s_sessions.enroll(15, 'spring 22');
exec s_sessions.enroll(16, 'spring 22');
exec s_sessions.enroll(17, 'fall 22');
exec s_sessions.enroll(18, 'fall 22');
exec s_sessions.enroll(19, 'fall 22');
exec s_sessions.enroll(20, 'fall 22');
