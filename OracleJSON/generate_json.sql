drop table author;
drop table visitor;
drop table library;
drop table book;
drop table given_books;
drop table book_queue;

CREATE TABLE author ( 
	author_id            int  NOT NULL  ,
	name                 varchar(100),
 	about                varchar(300)    ,
	born                 date    ,
	died                 date    ,
	CONSTRAINT pk_authors_authors_id PRIMARY KEY ( author_id )
 ) 
/
CREATE TABLE visitor( 
	visitor_id           int  NOT NULL  ,
	name                 varchar(100)    ,
	age                  int       ,
	passport             int    ,
	phone                varchar(15)    ,
	CONSTRAINT pk_person_id PRIMARY KEY ( visitor_id )
 )
/ 
CREATE TABLE library ( 
	library_id           int  NOT NULL  ,
	adress               varchar(100)    ,
	name                 varchar(100)    ,
	CONSTRAINT pk_library_library_id PRIMARY KEY ( library_id )
 ) 
/ 
CREATE TABLE book ( 
	book_id              int  NOT NULL  ,
	title                varchar(100)    ,
	author               int NOT NULL    ,
	release_date         date    ,
	publisher            varchar(50)    ,
	circulation          int    ,
	cost                 int    ,
	rare                 int    ,
	lirary_id            int    ,
	CONSTRAINT pk_book_book_id PRIMARY KEY ( book_id )
 ) 
/
CREATE TABLE given_books ( 
	order_id             int  NOT NULL  ,
	visitor_id           int    ,
	book_id              int    ,
	take_date            date   ,
	bring_date           date   ,
	returned             int    ,
	CONSTRAINT pk_given_books_order_id PRIMARY KEY ( order_id )
 ) 
/
CREATE TABLE book_queue ( 
	queue_id             int  NOT NULL  ,
	visitor_id           int    ,
	book_id              int    ,
	take_date            date    ,
	bring_date           date    ,
	CONSTRAINT pk_book_queue_queue_id PRIMARY KEY ( queue_id )
 ) 
/

-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Заполнение таблиц тестовыми данными
-------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO visitor(visitor_id, name, age, passport, phone) VALUES (1, 'Смирнов Александр Львович', 15, 40137591,'89119727982');
INSERT INTO visitor(visitor_id, name, age, passport, phone) VALUES (2, 'Литвинов Степан Сергеевич', 22, 63758264,'89210938070');
INSERT INTO visitor(visitor_id, name, age, passport, phone) VALUES (3, 'Жилкин Фёдор Игоревич', 12, 92758264,'88005553535');
INSERT INTO visitor(visitor_id, name, age, passport, phone) VALUES (4, 'Амрани Илиас Магомедович', 44, 82647834,'89212283645');
INSERT INTO visitor(visitor_id, name, age, passport, phone) VALUES (5, 'Филиппов Марк Дмитриевич', 60, 09473625,'83645346756');
INSERT INTO visitor(visitor_id, name, age, passport, phone) VALUES (6, 'Бодкин Вячеслав Сергеевич', 22, 75864354,'89992347654');

INSERT INTO library(library_id, adress, name) VALUES (1, 'Москва, р-н Арбат, ул. Воздвиженка, 3/5', 'Российская государственная библиотека');
INSERT INTO library(library_id, adress, name) VALUES (2, 'Санкт-Петербург, Садовая ул., 18', 'Российская национальная библиотека');
INSERT INTO library(library_id, adress, name) VALUES (3, 'Санкт-Петербург, Сенатская площадь, дом 3', 'Президентская библиотека имени Б. Н. Ельцина');

INSERT INTO author(author_id, name, about, born, died) VALUES (1, 'Нестор Летописец', 'Древнерусский летописец', DATE '1056-01-01', DATE '1114-01-01');
INSERT INTO author(author_id, name, about, born, died) VALUES (2, 'Фёдор Михайлович Достоевский', 'Русский писатель, мыслитель, философ и публицист. Член-корреспондент Петербургской АН с 1877 года', DATE '1821-10-30', DATE '1881-01-28');
INSERT INTO author(author_id, name, about, born, died) VALUES (3, 'Александр Сергеевич Пушкин', 'Русский поэт, драматург и прозаик, заложивший основы русского реалистического направления, критик и теоретик литературы, историк, публицист', DATE '1799-05-26', DATE '1837-01-29');
INSERT INTO author(author_id, name, about, born, died) VALUES (4, 'Карл Генрих Маркс', 'Немецкий философ, социолог, экономист, писатель, поэт, политический журналист, общественный деятель', DATE '1818-05-05', DATE '1883-03-14');
INSERT INTO author(author_id, name, about, born, died) VALUES (5, 'Джон Рональд Руэл Толкин', 'Английский писатель и поэт, переводчик, лингвист, филолог', DATE '1892-01-03', DATE '1973-09-02');

INSERT INTO book(book_id, title, author, release_date, publisher, circulation, cost, rare, lirary_id) VALUES (1, 'Повесть временных лет', 1, DATE '1110-01-21', 'Перо', 1, 1000000, 1, 2);
INSERT INTO book(book_id, title, author, release_date, publisher, circulation, cost, rare, lirary_id) VALUES (2, 'Руслан и Людмила', 3, DATE '1820-01-01', 'Сын отечества', 100, 728000, 0, 2);
INSERT INTO book(book_id, title, author, release_date, publisher, circulation, cost, rare, lirary_id) VALUES (3, 'Манифест Коммунистической партии', 4, DATE '1848-02-21', 'Союз справедливых', 1, 215000, 1, 3);
INSERT INTO book(book_id, title, author, release_date, publisher, circulation, cost, rare, lirary_id) VALUES (4, 'Борис Годунов', 3, DATE '1831-01-01', 'Игра слов', 5000, 500, 0, 1);
INSERT INTO book(book_id, title, author, release_date, publisher, circulation, cost, rare, lirary_id) VALUES (5, 'Капитал. Критика политической экономии', 4, DATE '1867-01-01', 'Dietz Verlag Berlin', 1, 825000, 1, 2);
INSERT INTO book(book_id, title, author, release_date, publisher, circulation, cost, rare, lirary_id) VALUES (6, 'Властелин колец', 5, DATE '1955-01-01', 'George Allen & Unwin', 500, 378000, 0, 3);
INSERT INTO book(book_id, title, author, release_date, publisher, circulation, cost, rare, lirary_id) VALUES (7, 'Преступление и наказание', 2, DATE '1866-01-01', 'Русский вестник', 10000, 550000, 0, 1);

INSERT INTO book_queue(queue_id, visitor_id, book_id, take_date, bring_date) VALUES (1, 3, 2, DATE '2018-01-22', DATE '2018-01-28');
INSERT INTO book_queue(queue_id, visitor_id, book_id, take_date, bring_date) VALUES (2, 1, 3, DATE '2018-02-10', DATE '2018-02-13');
INSERT INTO book_queue(queue_id, visitor_id, book_id, take_date, bring_date) VALUES (3, 1, 4, DATE '2018-06-22', DATE '2018-06-29');
INSERT INTO book_queue(queue_id, visitor_id, book_id, take_date, bring_date) VALUES (4, 4, 5, DATE '2018-09-01', DATE '2018-10-01');

INSERT INTO given_books(order_id, visitor_id, book_id, take_date, bring_date, returned) VALUES (1, 2, 5, DATE '2017-09-12', DATE '2017-10-12', 1);
INSERT INTO given_books(order_id, visitor_id, book_id, take_date, bring_date, returned) VALUES (2, 2, 4, DATE '2017-01-01', DATE '2017-01-12', 1);
INSERT INTO given_books(order_id, visitor_id, book_id, take_date, bring_date, returned) VALUES (3, 3, 3, DATE '2017-02-12', DATE '2017-04-21', 1);
INSERT INTO given_books(order_id, visitor_id, book_id, take_date, bring_date, returned) VALUES (4, 4, 2, DATE '2017-05-13', DATE '2017-06-05', 0);
INSERT INTO given_books(order_id, visitor_id, book_id, take_date, bring_date, returned) VALUES (5, 6, 1, DATE '2017-09-11', DATE '2017-10-17', 0);

select * from author;
select * from visitor;
select * from library;
select * from book;
select * from given_books;
select * from book_queue;

select json_object(
 'author_id' VALUE author_id,
 'name' VALUE name,
 'about' VALUE about,
 'born' VALUE cast (born as varchar(50)),
 'died' VALUE cast (died as varchar(50)) FORMAT JSON) json_data FROM author;

select a.name, b.title
from author a
join book b on a.author_id = b.author;

select json_object(
 'author' VALUE name,
 'title' VALUE title FORMAT JSON) json_data 
from author a
join book b on a.author_id = b.author;
