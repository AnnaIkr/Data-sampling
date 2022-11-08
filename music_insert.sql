CREATE TABLE IF NOT EXISTS Artist (
	id_artist SERIAL PRIMARY key,
	Имя_исполнителя VARCHAR(60) NOT NULL unique
);
CREATE TABLE IF NOT EXISTS Album (
	id_album SERIAL PRIMARY key,
	Название_альбома VARCHAR(100)  NOT NULL, 
	Год_выпуска VARCHAR(4) NOT NULL
);
CREATE TABLE IF NOT EXISTS Treck (
	id_track SERIAL PRIMARY key,
	Название_трека VARCHAR(100)  NOT NULL,
	Длительность numeric(3,2) NOT NULL,
	id_album INTEGER REFERENCES Альбом(id_album) NOT NULL
);
CREATE TABLE IF NOT EXISTS Collection (
	id_collection SERIAL PRIMARY key,
	Название_сборника VARCHAR(100)  NOT NULL, 
	Год_выпуска VARCHAR(4) NOT NULL
);
CREATE TABLE IF NOT EXISTS Genre (
    id_genre SERIAL PRIMARY key,
	Название_жанра VARCHAR(100)  NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS Genre_artist (
    id_artist INTEGER REFERENCES Artist(id_artist) NOT null,
    id_genre INTEGER REFERENCES Genre(id_genre) NOT null
);
CREATE TABLE IF NOT EXISTS Album_artist (
    id_album INTEGER REFERENCES Album(id_album) NOT null,
	id_artist INTEGER REFERENCES Artist(id_artist) NOT null
);
CREATE TABLE IF NOT EXISTS Collection_artist (
    id_collection INTEGER REFERENCES Collection(id_collection) NOT null,
	id_track INTEGER REFERENCES Treck(id_track) NOT NULL
);
INSERT INTO Artist(id_artist, Имя_исполнителя)
VALUES
    (1,'artist_1'),
    (2,'artist_2'),
    (3,'artist_3'),
    (4,'artist_4'),
    (5,'artist_5'),
    (6,'artist_6'),
    (7,'artist_7'),
    (8,'artist_8');
INSERT INTO Album(id_album, Название_альбома, Год_выпуска)
VALUES
    (1,'album_1','2017'),
	(2,'album_2','2018'),
	(3,'album_3','2019'),
	(4,'album_4','2020'),
	(5,'album_5','2021'),
	(6,'album_6','2020'),
	(7,'album_7','2017'),
	(8,'album_8','2016');
INSERT INTO Treck(id_track, Название_трека, Длительность, id_album)
VALUES
	(1,'track_1','3.05',1),
	(2,'my_track_2','3.10',2),
	(3,'track_3','3.15',3),
	(4,'track_4','3.12',4),
	(5,'track_5','3.08',5),
	(6,'track_6','3.06',6),
	(7,'my_track_7','3.11',7),
	(8,'track_8','3.05',1),
	(10,'track_10','3.15',2),
	(11,'track_11','3.10',3),
	(12,'my_track_12','3.12',4),
	(13,'track_13','3.06',5),
	(14,'track_14','3.15',6),
	(15,'track_15','3.08',7),
	(16,'track_16','3.10',8);
INSERT INTO Collection(id_collection, Название_сборника, Год_выпуска) 
VALUES
	(1,'Сборник_1','2017'),
	(2,'Сборник_2','2018'),
	(3,'Сборник_3','2019'),
	(4,'Сборник_4','2020'),
	(5,'Сборник_5','2021'),
	(6,'Сборник_6','2022'),
	(7,'Сборник_7','2020'),
	(8,'Сборник_8','2017');
INSERT INTO Genre(id_genre, Название_жанра) 
VALUES
	(1,'genre_1'),
	(2,'genre_2'),
	(3,'genre_3'),
	(4,'genre_4'),
	(5,'genre_5');
