create table student_cse (
    student_id number,
    student_name varchar(20),
    "password" number,
    cgpa float,
    completed_credit number,
    primary key(student_id)
);

create table session_enrollment_cse(
    student_id number,
    session_id number,
    gpa number,
    total_credit number,
    primary key(student_id, session_id),
    foreign key(student_id) references student_cse(student_id)
);

