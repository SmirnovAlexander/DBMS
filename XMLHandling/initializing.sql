CREATE TABLE facult
( 
   id     NUMBER, 
   data   XMLTYPE 
);
/
insert into facult
select 1, xmltype(blob_content, nls_charset_id('UTF8')) 
from apex_application_files
where filename = 'departments_data.xml'
/
select * from facult
/
drop view T_13_a;
/
-- a) фамилии студентов и оценки
CREATE VIEW T_13_a AS
SELECT x.*
FROM
    facult t,
    XMLTABLE(
        '
        for $x in /faculty_info/students/student, $y in $x/marks/mark/grade
       
        return 
            <student>
                <name>{$x/surname}</name>
                <grade>{$y}</grade>
            </student>
        '
        PASSING t.data
        COLUMNS 
            name VARCHAR2(60) PATH '/student/name',
            grade INTEGER PATH '/student/grade'
    ) x
WHERE
    t.id = 1;
/
SELECT * FROM T_13_a;
/
drop view T_13_a
/
CREATE VIEW T_13_a AS
SELECT x.*
FROM
    facult t,
    XMLTABLE(
        '
        for $x in /faculty_info/students/student
        let $y := avg($x/marks/mark/grade)
        order by $y descending
        return 
            <student>
                <name>{$x/surname}</name>
                <grade>{$y}</grade>
            </student>
        '
        PASSING t.data
        COLUMNS 
            name VARCHAR2(60) PATH '/student/name',
            grade VARCHAR2(3) PATH '/student/grade'
    ) x
WHERE
    t.id = 1;
/
SELECT * FROM T_13_a;
/

drop view T_13_a
/
-- a) фамилии студентов и оценки
CREATE VIEW T_13_a AS
SELECT x.*
FROM
    facult t,
    XMLTABLE(
        '
        for $x in /faculty_info/departments/department, $y in $x/subjects/subject
        order by $x/name, $y
        return 
            <department>
                <name>{$x/name}</name>
                <subject>{$y}</subject>
            </department>
        '
        PASSING t.data
        COLUMNS 
            name VARCHAR2(100) PATH '/department/name',
            subject VARCHAR2(100) PATH '/department/subject'
    ) x
WHERE
    t.id = 1;
/
SELECT * FROM T_13_a;
/

drop MATERIALIZED view T_13_a
/
CREATE MATERIALIZED VIEW T_13_a AS
    SELECT x.*
    FROM
        facult t,
        XMLTABLE(
            '
            for $x in /faculty_info/departments/department, $y in $x/subjects/subject
            return 
                <department>
                    <name>{$x/name}</name>
                    <subject>{$y}</subject>
                </department>
            '
            PASSING t.data
            COLUMNS name VARCHAR2(100) PATH '/department/name',
                     subject VARCHAR2(100) PATH '/department/subject'
        ) x
    WHERE
        t.id = 1
/
SELECT subject
FROM T_13_a
group by subject
having count(*) >= 2
