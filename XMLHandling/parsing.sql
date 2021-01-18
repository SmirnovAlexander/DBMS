drop table departments_data
/
create table departments_data
( 
   id     number, 
   data   xmltype 
);
/
insert into departments_data
select 1, xmltype(blob_content, nls_charset_id('utf8')) 
from apex_application_files
where filename = 'departments_data.xml'
/
select * from departments_data
/
drop view surnames_marks;
/
create view surnames_marks as
select x.*
from
    departments_data t,
    xmltable(
        '
        for $x in /faculty_info/students/student, $y in $x/marks/mark/grade
       
        return 
            <student>
                <name>{$x/surname}</name>
                <grade>{$y}</grade>
            </student>
        '
        passing t.data
        columns 
            name varchar2(60) path '/student/name',
            grade integer path '/student/grade'
    ) x
where
    t.id = 1;
/
select * from surnames_marks;
/
drop view average_scores
/
create view average_scores as
select x.*
from
    departments_data t,
    xmltable(
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
        passing t.data
        columns 
            name varchar2(60) path '/student/name',
            grade varchar2(3) path '/student/grade'
    ) x
where
    t.id = 1;
/
select * from average_scores;
/
drop view all_subjects;
/
create view all_subjects as
select x.*
from
    departments_data t,
    xmltable(
        '
        for $x in /faculty_info/departments/department, $y in $x/subjects/subject
        order by $x/name, $y
        return 
            <department>
                <name>{$x/name}</name>
                <subject>{$y}</subject>
            </department>
        '
        passing t.data
        columns 
            name varchar2(100) path '/department/name',
            subject varchar2(100) path '/department/subject'
    ) x
where
    t.id = 1;
/
select * from all_subjects;
/
drop materialized view subjects_every_faculty;
/
create materialized view subjects_every_faculty as
    select x.*
    from
        departments_data t,
        xmltable(
            '
            for $x in /faculty_info/departments/department, $y in $x/subjects/subject
            return 
                <department>
                    <name>{$x/name}</name>
                    <subject>{$y}</subject>
                </department>
            '
            passing t.data
            columns name varchar2(100) path '/department/name',
                     subject varchar2(100) path '/department/subject'
        ) x
    where
        t.id = 1;
/
create view all_subjects_all as
select subject
from subjects_every_faculty
group by subject
having count(*) >= 2
/
select * from all_subjects_all
/
select xmlelement("books", xmlagg(xmlelement("book",
    xmlelement("book_id", book_id),
    xmlelement("title", title),
    xmlelement("author", name),
    xmlelement("release_date", release_date),
    xmlelement("publisher", publisher),
    xmlelement("circulation", circulation),
    xmlelement("cost", cost),
    xmlelement("rare", rare)))
) xml_doc from (select * from book) b
join author a
on a.author_id = b.author;

