from sqlalshemy import create_engine

engine = create_engine('postgresql://localhost:5432/music')

connection = create_engine.connect()

#1.количество исполнителей в каждом жанре
select_1 = connection.execute('''
    SELECT  T.title, count(genre_artist.artist_id) 
    FROM Genre T
    JOIN Genre_artist GA ON T.id = GA.id_genre
    GROUP BY T.title
''').fetchall()
pprint(f'Количество исполнителей в каждом жанре: {select_1}')

#2.количество треков, вошедших в альбомы 2019-2020 годов
select_2 = connection.execute('''
    SELECT  a.title, a.year, count(s.id_track) 
    FROM Album a
    JOIN Songs s ON a.id = s.id_album
    WHERE a.year >= 2019 AND a.year <=2020
    GROUP BY a.title, a.year
''').fetchall()
pprint(f'Количество треков, вошедших в альбомы 2019-2020 годов: {select_2}')

#3.средняя продолжительность треков по каждому альбому
select_3 = connection.execute('''
    SELECT  a.title, roung(AVG(s.duration),2) 
    FROM Album a
    JOIN Songs s ON a.id = s.id_album
    GROUP BY a.title
''').fetchall()
pprint(f'Cредняя продолжительность треков по каждому альбому: {select_3}')

#4.все исполнители, которые не выпустили альбомы в 2020 году
select_4 = connection.execute('''
    SELECT  a.name, a.year
    FROM Artist a
    JOIN Album_artist aa ON a.id = aa.id_artist
    JOIN Album a ON aa_album.id = aa.id_artist
    WHERE a.year != 2020
''').fetchall()
pprint(f'Все исполнители, которые не выпустили альбомы в 2020 году: {select_4}')

#5.названия сборников, в которых присутствует конкретный исполнитель
select_5 = connection.execute('''
    SELECT  DISTINCT c.title
    FROM Collection c
    JOIN Collection_artist ca ON c.id = ca.id_collection
    JOIN Songs s ON ca_album.id = s.id_artist
    JOIN Album a ON s.id_album = a.id_artist
    JOIN Album_artist aa ON a.id = aa.id_album
    JOIN Artist a ON aa.id_artist = a.id_artist
    WHERE a.name LIKE artist_5
    GROUP BY a.title, a.year
''').fetchall()
pprint(f'Названия сборников, в которых присутствует конкретный исполнитель: {select_5}')

#6.название альбомов, в которых присутствуют исполнители более 1 жанра
select_6 = connection.execute('''
    SELECT a.title
    FROM Album a
    JOIN Album_artist aa ON a.id = aa.id_album
    JOIN Artist a ON aa.id_artis = a.id_artist
    JOIN Genre_artist ga ON a.id = ga.id_artist
    GROUP BY a.name, a.title
    HAVING COUNT(ga.id_ganre)>1
''').fetchall()
pprint(f'Название альбомов, в которых присутствуют исполнители более 1 жанра: {select_6}')

#7.наименование треков, которые не входят в сборники
select_7 = connection.execute('''
    SELECT  s.title 
    FROM Songs s
    LEFT JOIN Song_collection sc ON s.id = sc.id_songs
    WHERE sc.id_songs IS NULL
''').fetchall()
pprint(f'Hаименование треков, которые не входят в сборники: {select_7}')

#8.исполнителя(-ей), написавшего самый короткий по продолжительности трек
select_8 = connection.execute('''
    SELECT a.name, s.duration
    FROM Artist a
    JOIN Album_artist aa ON a.id = aa.id_artist
    JOIN Album a ON aa.id_album = a.id_artist
    JOIN Songs s ON a.id_artist = s.id_album
    WHERE s.duration IN (SELECT MIN(duration) FROM Songs)
''').fetchall()
pprint(f'Имя исполнителя(-ей), написавшего самый короткий по продолжительности трек: {select_8}')

#9.название альбомов, содержащих наименьшее количество треков
select_9 = connection.execute('''
    SELECT a.title, count(s.id)
    FROM Album a
    JOIN Songs s ON a.id_artist = s.id_album
    GROUP BY a.title
    HAVING COUNT(s.id) in (
        SELECT COUNT(s.id)
        FROM Album a
        JOIN Songs s ON a.id_artist = s.id_album
        GROUP BY a.title
        ORDER BY COUNT(s.id)\LIMIT 1
    )
''').fetchall()
pprint(f'Hазвание альбомов, содержащих наименьшее количество треков: {select_9}')
