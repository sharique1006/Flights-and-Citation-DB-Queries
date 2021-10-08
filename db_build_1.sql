create table airports
(
  airportid int,
  city text,
  state text,
  name text
);

create table flights
(
  flightid int,
  originairportid int,
  destairportid int,
  carrier text,
  dayofmonth int,
  dayofweek int,
  departuredelay int,
  arrivaldelay int
);

create table authordetails(
	authorid integer,
	authorname text,
	city text,
	gender text,
	age integer
);

create table paperdetails(
	paperid integer,
	papername text,
	conferencename text,
	score integer
);

create table authorpaperlist(
	authorid integer,
	paperid integer
);

create table citationlist(
	paperid1 integer,
	paperid2 integer
);

INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (10140, 'Albuquerque', 'New Mexico', 'Albuquerque International Sunport');
INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (2, 'Hobbs', 'New Mexico', 'Lea County Regional');
INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (3, 'Albany', 'Georgia', 'Southwest Georgia Regional');
INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (4, 'Santa Fe', 'New Mexico', 'Santa Fe Municipal');
INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (5, 'Augusta', 'Georgia', 'Augusta Regional at Bush Field');
INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (6, 'Chicago', 'Illinois', 'Chicago Midway International');
INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (7, 'Washington', 'Washington', 'Ronald Reagan Washington National');
INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (8, 'DC', 'Washington', 'Washington Dulles International');
INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (9, 'New York City', 'New York', 'John F. Kennedy International');
INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (10, 'Albany', 'New York', 'Albany International');
INSERT INTO airports
  (airportid, city, state, name)
VALUES
  (11, 'Buffalo', 'New York', 'Buffalo Niagara International');


INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (1, 10140, 3, 'Delta', 1, 2, 1, -1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (2, 3, 2, 'Delta', 1, 1, 1, 0);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (3, 2, 10140, 'Delta', 1, 1, 0, 2);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (4, 10140, 4, 'JetBlue', 2, 4, 1, 1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (5, 4, 5, 'Delta', 1, 4, 1, 1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (6, 3, 5, 'JetBlue', 1, 3, 1, 1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (7, 3, 5, 'PanAm', 1, 3, 1, 1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (8, 10140, 6, 'Delta', 3, 1, 1, 7);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (9, 3, 7, 'Delta', 1, 1, 1, 1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (10, 7, 6, 'Delta', 1, 1, 1, 1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (11, 9, 11, 'American Airlines', 1, 1, 1, 1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (12, 10, 9, 'American Airlines', 1, 1, 1, 1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (13, 10, 11, 'American Airlines', 1, 1, 1, 1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (14, 11, 9, 'American Airlines', 1, 1, 1, 1);
INSERT INTO flights
  (flightid, originairportid, destairportid, carrier, dayofmonth, dayofweek, departuredelay, arrivaldelay)
VALUES
  (15, 11, 10, 'American Airlines', 1, 1, 1, 1);

INSERT INTO citationlist(paperid1, paperid2)
VALUES
  (111, 108), (113, 108), (113, 111), (107, 108), (109, 108), (110, 108), (104, 108), (101, 111), 
  (102, 111), (103, 111), (106, 111), (105, 111), (128, 126), (128, 105);

INSERT INTO authorpaperlist(authorid, paperid)
VALUES
  (3552, 101), (3552, 102), (3552, 103), (3552, 104), (704, 101), (1558, 102),
  (1745, 103), (11, 128), (2, 104), (2, 105), (2, 128), (562, 104),
  (562, 105), (562, 126), (1436, 126), (2826, 107), (456, 109), (102, 110),
  (1235, 105), (1235, 106), (1235, 112), (6, 106), (6, 111), (6, 108),
  (321, 112), (321, 113), (921, 111), (921, 108), (9, 108), (9, 113),
  (9, 107), (9, 109), (9, 110);

INSERT INTO authordetails(authorid, authorname, city, gender, age)
VALUES
  (704, 'A1', 'Mumbai', 'Male', 40),
  (1558, 'A2', 'Chennai', 'Female', 40),
  (1745, 'A3', 'Hyderabad', 'Male', 42),
  (3552, 'A4', 'Kolkata', 'Male', 40),
  (11, 'A5', 'Pune', 'Female', 38),
  (2, 'A6', 'Delhi', 'Feale', 30),
  (562, 'A7', 'Delhi', 'Female', 45),
  (1436, 'A8', 'Mysuru', 'Male', 40),
  (1235, 'A9', 'Patna', 'Male', 36),
  (6, 'A10', 'Jaipur', 'Female', 40),
  (321, 'A11', 'Ranchi', 'Male', 50),
  (921, 'A12', 'Bhopal', 'Male', 50),
  (9, 'A13', 'Bengaluru', 'Male', 52),
  (2826, 'A14', 'Mumbai', 'Female', 54),
  (456, 'A15', 'Mumbai', 'Male', 50),
  (102, 'A16', 'Mumbai', 'Male', 45);


INSERT INTO paperdetails(paperid, papername, conferencename, score)
VALUES
  (101, 'P1', 'C1', 10),
  (102, 'P2', 'C1', 10),
  (103, 'P3', 'C1', 10),
  (104, 'P4', 'C1', 10),
  (105, 'P5', 'C2', 10),
  (126, 'P6', 'C2', 10),
  (128, 'P7', 'C2', 10),
  (111, 'P8', 'C2', 10),
  (106, 'P9', 'C1', 10),
  (108, 'P10', 'C1', 10),
  (112, 'P11', 'C1', 10),
  (113, 'P12', 'C1', 10),
  (107, 'P13', 'C3', 10),
  (109, 'P14', 'C3', 10),
  (110, 'P15', 'C3', 10);

--drop table airports cascade;--
--drop table flights cascade;--
--drop table if exists authordetails cascade;--
--drop table if exists paperdetails cascade;--
--drop table if exists authorpaperlist cascade;--
--drop table if exists citationlist cascade;--


