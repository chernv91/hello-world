-- Создать БД "Издательство"
CREATE DATABASE publishing_house;

-- Выбрать БД для работы
USE publishing_house;

-- Создать таблицу "Автор"
CREATE TABLE author
(
	id_author SMALLINT(7) UNSIGNED NOT NULL AUTO_INCREMENT,
	name_surname VARCHAR(50) NOT NULL DEFAULT '',
	PRIMARY KEY (id_author)
);

-- Создать таблицу "Книга"
CREATE TABLE book
(
	isbn CHAR(13) NOT NULL,
	name VARCHAR(80) NOT NULL,
	num_pages SMALLINT(7) UNSIGNED NOT NULL,
	PRIMARY KEY (isbn)
);

-- Создать таблицу "Жанр"
CREATE TABLE genre
(
	id_genre TINYINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_genre)
);

-- Создать таблицу "Книга_автор"
CREATE TABLE book_author
(
	isbn CHAR(13) NOT NULL,
	id_author SMALLINT(7) UNSIGNED NOT NULL,
	PRIMARY KEY (isbn, id_author),
	CONSTRAINT num_i FOREIGN KEY(isbn) REFERENCES book(isbn) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT num_a FOREIGN KEY(id_author) REFERENCES author(id_author) ON DELETE RESTRICT
);

-- Создать таблицу "Книга_жанр"
CREATE TABLE book_genre
(
	isbn CHAR(13) NOT NULL,
	id_genre TINYINT(5) UNSIGNED NOT NULL,
	PRIMARY KEY (isbn, id_genre),
	CONSTRAINT num_is FOREIGN KEY(isbn) REFERENCES book(isbn) ON UPDATE CASCADE  ON DELETE RESTRICT,
	CONSTRAINT num_g FOREIGN KEY(id_genre) REFERENCES genre(id_genre) ON DELETE RESTRICT
);

-- Заполнить данными таблицу "Автор"
INSERT INTO author(name_surname)
	VALUES 	('Илья Ильф'),
			('Евгений Петров'),
			('Жюль Верн'),
			('Рэй Брэдбэри'),
			('Франц Кафка'),
			('Эрнест Хемингуэй'),
			('Сергей Лукьяненко'),
			('Владимир Васильев'),
			('Макс Фрай'),
			('Линор Горалик'),
			('Сергей Есенин'),
			('Александр Пушкин'),
			('Артур Хейли');
			
-- Заполнить данными таблицу "Книга"
INSERT INTO book
	VALUES 	('9785170983049', 'Иметь и не иметь', 288),
			('9785171011369', 'Пропавший без вести', 352),
			('9785699815371', 'Вино из одуваничков', 320),
			('9785367009354', 'Книга одиночеств', 300),
			('9785745410444', 'Библия', 290),
			('5170258836325', 'Дневной Дозор', 192),
			('9785170749669','12 стульев', 608),
			('9785170931712', 'Золотой телёнок', 416),
			('9788561234701','Путешествие к центру Земли', 350),
			('9785214734789','Пять недель на воздушном шаре', 180);
			
-- Заполнить данными таблицу "Жанр"
INSERT INTO genre(name)
	VALUES 	('Фантастика'),
			('Роман'),
			('Поэзия'),
			('Религия'),
			('Сказки'),
			('Мировая классика'),
			('Детектив');
			
-- Заполнить данными таблицу "Книга_автор"
INSERT INTO book_author
	VALUES	('9785170983049', 6),
			('9785171011369', 5),
			('9785699815371', 4),
			('9785367009354', 9),
			('9785367009354', 10),
			('9785367009354', 13),
			('5170258836325', 7),
			('5170258836325', 8),
			('9785170749669', 1),
			('9785170749669', 2),
			('9785170931712', 1),
			('9785170931712', 2),
			('9788561234701', 3),
			('9785214734789', 3),
			('9785171011369', 9),
			('9785171011369', 13);

-- Заполнить данными таблицу "Книга_жанр"
INSERT INTO book_genre
	VALUES 	('9785170983049', 6),
			('9785171011369', 6),
			('9785699815371', 6),
			('9785367009354', 1),
			('9785745410444', 4),
			('5170258836325', 1),
			('9785170749669', 2),
			('9785170931712', 2),
			('9788561234701', 1),
			('9788561234701', 2),
			('9785214734789', 1),
			('9785214734789', 2);

-- Вывести название книги и ее авторов для жанра “Фантастика”
SELECT b.name, a.name_surname
	FROM book AS b
		INNER JOIN book_author AS b_a ON b.isbn=b_a.isbn 
		INNER JOIN author AS a ON b_a.id_author=a.id_author
		INNER JOIN book_genre AS b_g ON b_g.isbn=b.isbn
		INNER JOIN genre AS g ON g.id_genre=b_g.id_genre
	WHERE g.name='Фантастика';
			
-- Вывести все книги, где больше 2-х авторов
SELECT name 
FROM book
WHERE isbn IN(
			SELECT isbn
			FROM book_author
			GROUP BY isbn
			HAVING COUNT(*) > 2
			);

-- Вывести количество книг по каждому жанру			
SELECT g.name, COUNT(b.isbn) AS num_books
FROM genre AS g
	LEFT JOIN book_genre AS b ON g.id_genre=b.id_genre
GROUP BY g.name;
  