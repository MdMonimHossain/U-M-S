exec auth.login(1, 123, 'teacher');

-- Adding courses
exec course.add_course('CSE-101', 'Introduction to Computer Science', 1, 'This course is an introduction to computer science', 1000, 3);
exec course.add_course('CSE-102', 'Introduction to Programming', 2, 'This course is an introduction to programming', 1000, 3);
exec course.add_course('CSE-201', 'Introduction to Algorithms', 3, 'This course is an introduction to database', 1000, 3);
exec course.add_course('CSE-202', 'Introduction to Data Stucture', 4, 'This course is an introduction to operating system', 1000, 3);
exec course.add_course('CSE-301', 'Introduction to Operating System', 5, 'This course is an introduction to computer architecture', 1000, 3);
exec course.add_course('CSE-302', 'Introduction to Database', 1, 'This course is an introduction to computer architecture', 1000, 3);
exec course.add_course('CSE-401', 'Networking', 2, 'This course is an introduction to computer networking', 1000, 3);
exec course.add_course('CSE-402', 'Artificial Intelligence', 3, 'This course is an introduction to Artificial Intelligence', 1000, 3);



exec auth.login(1, 123, 'teacher');

-- Enrolling students to course CSE-101

exec course.enroll_student(1, 'CSE-101', 1);
exec course.enroll_student(2, 'CSE-101', 1);
exec course.enroll_student(3, 'CSE-101', 1);

-- Grading students in CSE-101

exec course.update_grade(1, 'CSE-101', 1, 85);
exec course.update_grade(2, 'CSE-101', 1, 65);
exec course.update_grade(3, 'CSE-101', 1, 75);


-- Enrolling students to course CSE-301

exec course.enroll_student(1, 'CSE-302', 3);
exec course.enroll_student(2, 'CSE-302', 3);
exec course.enroll_student(3, 'CSE-302', 3);

-- Grading students in CSE-301

exec course.update_grade(1, 'CSE-302', 3, 58);
exec course.update_grade(2, 'CSE-302', 3, 47);
exec course.update_grade(3, 'CSE-302', 3, 37);




exec auth.login(2, 123, 'teacher');

-- Enrolling students to course CSE-102

exec course.enroll_student(1, 'CSE-102', 1);
exec course.enroll_student(2, 'CSE-102', 1);
exec course.enroll_student(3, 'CSE-102', 1);

-- Grading students in CSE-102

exec course.update_grade(1, 'CSE-102', 1, 70);
exec course.update_grade(2, 'CSE-102', 1, 77);
exec course.update_grade(3, 'CSE-102', 1, 87);


-- Enrolling students to course CSE-401

exec course.enroll_student(1, 'CSE-401', 4);
exec course.enroll_student(2, 'CSE-401', 4);
exec course.enroll_student(3, 'CSE-401', 4);

-- Grading students in CSE-401

exec course.update_grade(1, 'CSE-401', 4, 65);
exec course.update_grade(2, 'CSE-401', 4, 98);
exec course.update_grade(3, 'CSE-401', 4, 78);



exec auth.login(3, 123, 'teacher');

-- Enrolling students to course CSE-201

exec course.enroll_student(1, 'CSE-201', 2);
exec course.enroll_student(2, 'CSE-201', 2);
exec course.enroll_student(3, 'CSE-201', 2);

-- Grading students in CSE-201

exec course.update_grade(1, 'CSE-201', 2, 80);
exec course.update_grade(2, 'CSE-201', 2, 90);
exec course.update_grade(3, 'CSE-201', 2, 100);


-- Enrolling students to course CSE-402

exec course.enroll_student(1, 'CSE-402', 4);
exec course.enroll_student(2, 'CSE-402', 4);
exec course.enroll_student(3, 'CSE-402', 4);


-- Grading students in CSE-402
exec course.update_grade(1, 'CSE-402', 4, 65);
exec course.update_grade(2, 'CSE-402', 4, 65);
exec course.update_grade(3, 'CSE-402', 4, 79);



exec auth.login(4, 123, 'teacher');

-- Enrolling students to course CSE-202

exec course.enroll_student(1, 'CSE-202', 2);
exec course.enroll_student(2, 'CSE-202', 2);
exec course.enroll_student(3, 'CSE-202', 2);

-- Grading students in CSE-202

exec course.update_grade(1, 'CSE-202', 2, 81);
exec course.update_grade(2, 'CSE-202', 2, 92);
exec course.update_grade(3, 'CSE-202', 2, 71);



exec auth.login(5, 123, 'teacher');

-- Enrolling students to course CSE-301

exec course.enroll_student(1, 'CSE-301', 3);
exec course.enroll_student(2, 'CSE-301', 3);
exec course.enroll_student(3, 'CSE-301', 3);

-- Grading students in CSE-301

exec course.update_grade(1, 'CSE-301', 3, 29);
exec course.update_grade(2, 'CSE-301', 3, 98);
exec course.update_grade(3, 'CSE-301', 3, 60);





