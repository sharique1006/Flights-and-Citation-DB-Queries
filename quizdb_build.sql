create table authordetails
(
  authorid integer,
  authorname text,
  city text,
  gender text,
  age integer
);

create table paperdetails
(
  paperid integer,
  papername text,
  conferencename text,
  score integer
);

create table authorpaperlist
(
  authorid integer,
  paperid integer
);

create table citationlist
(
  paperid1 integer,
  paperid2 integer
);

create table airports
(
  airportid int,
  city text,
  state text,
  name text
);

alter table airports add PRIMARY KEY (airportid);

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

INSERT INTO authorpaperlist
  (authorid, paperid)
VALUES
  (1, 102),
  (2, 102),
  (3, 101),
  (2, 101),
  (2, 103),
  (8, 103),
  (4, 103),
  (4, 104),
  (8, 104),
  (9, 104),
  (9, 105),
  (11, 105),
  (9, 106),
  (12, 106),
  (12, 107),
  (5, 107),
  (11, 108),
  (5, 108),
  (14, 108),
  (11, 111),
  (14, 111),
  (5, 109),
  (15, 109),
  (16, 110),
  (15, 110),
  (16, 112),
  (6, 112),
  (8, 113),
  (10, 113),
  (4, 114),
  (7, 114);

INSERT INTO authordetails
  (authorid, authorname, city, gender, age)
VALUES
  (1, 'A1', 'Kanpur', 'Male', 40),
  (2, 'A2', 'Chennai', 'Male', 40),
  (3, 'A3', 'Chennai', 'Male', 43),
  (4, 'A4', 'Delhi', 'Male', 35),
  (7, 'A5', 'Kanpur', 'Male', 38),
  (8, 'A6', 'Ranchi', 'Male', 39),
  (10, 'A7', 'Patna', 'Male', 40),
  (9, 'A8', 'Bengaluru', 'Female', 41),
  (11, 'A9', 'Mumbai', 'Male', 42),
  (12, 'A10', 'Jaipur', 'Female', 40),
  (14, 'A11', 'Kolkata', 'Male', 40),
  (5, 'A12', 'Chennai', 'Female', 35),
  (15, 'A13', 'Delhi', 'Female', 38),
  (16, 'A14', 'Delhi', 'Male', 30),
  (6, 'A15', 'Mumbai', 'Female', 40);

INSERT INTO citationlist
  (paperid1, paperid2)
VALUES
  (103, 101),
  (106, 101),
  (104, 101),
  (104, 111),
  (104, 112),
  (107, 111),
  (107, 112),
  (108, 111),
  (113, 112),
  (114, 104),
  (110, 107),
  (102, 114),
  (103, 102),
  (113, 111),
  (115, 101),
  (109, 110);

INSERT INTO paperdetails
  (paperid, papername, conferencename, score)
VALUES
  (101, 'P1', 'C1', 10),
  (102, 'P2', 'C1', 10),
  (103, 'P3', 'C1', 10),
  (104, 'P4', 'C1', 10),
  (105, 'P5', 'C1', 10),
  (106, 'P6', 'C2', 10),
  (107, 'P7', 'C2', 10),
  (108, 'P8', 'C1', 10),
  (109, 'P9', 'C2', 10),
  (110, 'P10', 'C2', 10),
  (111, 'P11', 'C2', 10),
  (112, 'P12', 'C2', 10),
  (113, 'P13', 'C1', 10),
  (114, 'P14', 'C1', 10),
  (115, 'P15', 'C1', 10);

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
  (3, 'Covington', 'Georgia', 'Southwest Georgia Regional');
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
