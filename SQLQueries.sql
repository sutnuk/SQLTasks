CREATE DATABASE tasks;

CREATE TABLE hotels
(
hotelsID int NOT NULL PRIMARY KEY,
name varchar(100) NOT NULL,
foundationYear int NOT NULL,
address varchar(100) NOT NULL,
isActive bit
);

CREATE TABLE rooms
(
roomsID int NOT NULL PRIMARY KEY,
hotelsID int NOT NULL,
number int NOT NULL,
price money NOT NULL,
comfortLevel int NOT NULL,
capability int NOT NULL
);

CREATE TABLE users
(
usersID int NOT NULL PRIMARY KEY,
firstName varchar(100) NOT NULL,
lastName varchar(100) NOT NULL,
email varchar(100) NOT NULL
);

CREATE TABLE rezervation
(
rezervationID int NOT NULL PRIMARY KEY,
roomsID int NOT NULL,
usersID int NOT NULL,
startRezervation date NOT NULL,
endRezervation date NOT NULL
);

/*1) Add 3 hotels to DB, one with name 'Edelweiss':*/

INSERT INTO hotels(hotelsID, name, foundationYear, address, isActive)
VALUES
(1, 'Edelweiss', 2010, 'Chernivtsi, st. Holovna 110', 1),
(2, 'Tyrist', 1998, 'Chernivtsi, st. Heroiyv Maidany 87', 1),
(3, 'Cheremosh', 2005, 'Chernivtsi, st. Komarova 43', 1);

/*2) Get All hotels from DB:*/

SELECT * FROM hotels;

/*3) Update first hotel foundation year from existing value to 1937:*/

UPDATE hotels
SET foundationYear = 1937
WHERE hotelsId = 1;

/*4) Delete 3d hotel from DB by Id:*/

DELETE hotels
WHERE hotelsId = 3;

/*5)Insert 10 users to Database, but have at least 2 users with Name Andrew or Anton:*/

INSERT INTO users(usersID, firstName, lastName, email)
VALUES
(1, 'Andrew', 'Ivanov', 'Ivanov@gmail.com'),
(2, 'Anton', 'Petrov', 'Petrov@gmail.com' ),
(3, 'Boris', 'Panchenko', 'Panchenko@gmail.com' ),
(4, 'Nazar', 'Sytnyk', 'Sytnyk@gmail.com'),
(5, 'Ira', 'Lavrinok', 'Lavrinok@gmail.com' ),
(6, 'Max', 'Pislar', 'Pislar@gmail.com' ),
(7, 'Misha', 'Fediv', 'Fediv@gmail.com'),
(8, 'Tania', 'Deretorska', 'Deretorska@gmail.com' ),
(9, 'Max', 'Dreneyka', 'Dreneyka@gmail.com' ),
(10, 'Ivan', 'Fors', 'Fors@gmail.com' );

/*6) Get all users which name starts from "A"*/

SELECT * FROM users
WHERE firstName LIKE 'A%';

/*7) Insert 10 rooms in DB. 7 to first hotel and 3 to other. Make sure both hotels have room number 101. Make sure 'Edelweiss' has room number 301, but other hotel no.
 Also make sure 'Edelweiss' do not have rooms with comfort level 3, but second hotel has at least one room with such comfort level*/

 INSERT INTO rooms(roomsID, hotelsID, number, price, comfortLevel, capability)
VALUES
(1, 1, 101, 400, 1, 2),
(2, 1, 102, 500, 2, 4),
(3, 1, 103, 750, 2, 3),
(4, 1, 104, 400, 1, 2),
(5, 1, 201, 500, 2, 4),
(6, 1, 202, 250, 1, 3),
(7, 1, 301, 430, 1, 2),
(8, 3, 101, 520, 2, 1),
(9, 3, 101, 950, 2, 3),
(10, 3, 102, 1150, 3, 3);

/*8) Select All rooms from DB sorted by Price*/

SELECT * FROM rooms
ORDER BY price DESC;

/*9) Select All rooms from DB that belong to 'Edelweiss' hotel and sorted by price*/

SELECT rooms.roomsID, rooms.hotelsID, rooms.number, rooms.price, rooms.comfortLevel, rooms.capability
FROM rooms
JOIN hotels ON rooms.hotelsID = hotels.name;

SELECT * FROM rooms
WHERE hotelsId = 1
ORDER BY price DESC;

/*10) Select Hotels that have rooms with comfort level 3*/

SELECT hotels.name, rooms.comfortLevel, rooms.hotelsID
FROM hotels
INNER JOIN rooms ON hotels.hotelsID = rooms.hotelsID
AND comfortLevel = 3;

/*11) Select Hotelname and room number for rooms that have comfort level 1*/

SELECT hotels.name, rooms.number, rooms.hotelsID, rooms.comfortLevel
FROM hotels
INNER JOIN rooms ON rooms.hotelsID = hotels.hotelsID
AND comfortLevel = 1;

/* 12) Select Hotel names and count of hotel rooms*/

SELECT hotels.name, COUNT(rooms.roomsID) AS count_of_hotel_rooms
FROM rooms
INNER JOIN hotels ON hotels.hotelsID = rooms.hotelsID
GROUP BY hotels.name;

/* 13) Insert 10 different reservations to db.*/

INSERT INTO rezervation(rezervationID, roomsID, usersID, startRezervation, endRezervation)
VALUES
(1, 1, 2, '2018-05-23', '2018-05-25'),
(2, 2, 4, '2018-04-12', '2018-04-15'),
(3, 6, 2, '2018-03-27', '2018-03-29'),
(4, 4, 1, '2018-02-23', '2018-02-25'),
(5, 5, 8, '2018-01-12', '2018-01-15'),
(6, 4, 6, '2018-11-27', '2018-11-29'),
(7, 2, 7, '2018-08-23', '2018-08-25'),
(8, 8, 3, '2018-07-12', '2018-07-15'),
(9, 9, 9, '2018-08-27', '2018-08-29'),
(10, 6, 2, '2018-03-27', '2018-03-29');
 
/*14) Select Username, room number, reservation period.*/

SELECT users.firstName, users.lastName, rooms.number, DATEDIFF(DAY, rezervation.startRezervation, rezervation.endRezervation)
FROM rezervation
INNER JOIN users ON users.usersID = rezervation.usersID
INNER JOIN rooms ON rooms.roomsID = rezervation.roomsID;