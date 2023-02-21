create table course_cse (
    course_id varchar(20),
    course_title varchar(80),
    teacher_id number,
    description varchar(300),
    course_fee number,
    credit number,
    primary key(course_id)
);


create table course_enrollment_cse(
    student_id number,
    course_id varchar(20),
    session_id number,
    marks number,
    grade number,
    primary key(student_id, course_id, session_id),
    foreign key(student_id) references student_cse(student_id),
    foreign key(course_id) references course_cse(course_id)
);

