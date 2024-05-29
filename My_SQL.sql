CREATE TABLE student (student_id INT not null,
                      name VARCHAR(20) not null,
                      major VARCHAR(20) unique not null,
                      PRIMARY KEY (student_id));
SELECT * from student;
DROP table student;
DESCRIBE student;
ALTER table student ADD column GPA DECIMAL(3,2);
ALTER table student DROP column GPA;

INSERT INTO student VALUES (1, 'Jack', 'Biology'),
                           (2, 'Kate', 'Socialogy'),
                           (3, 'Clarie', 'English'),
                           (4, 'Jack', 'Chemistry'),
                           (5, 'Mike', 'Computer science');

UPDATE student set major = 'Bio' where major = 'Biology';
DELETE from student where name = 'Jack';

SELECT * from student ORDER BY name desc;