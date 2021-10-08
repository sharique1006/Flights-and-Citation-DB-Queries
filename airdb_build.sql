drop table airports;
drop table flights;

create table airports (
    airportid integer,
    city text,
    state text,
    name text,
    constraint airports_key primary key (airportid)
);

create table flights (
    flightid integer,
    originairportid integer,
    destairportid integer,
    carrier text,
    dayofmonth integer,
    dayofweek integer,
    departuredelay integer,
    arrivaldelay integer,
    constraint flights_key primary key (flightid)
);

insert into airports values(10140, 'Albuquerque', 'New Mexico', 'Albuquerque International Airport');
insert into airports values(10141, 'Chicago', 'Illinois', 'Chicago International Airport');
insert into airports values(10142, 'Dallas', 'Mexico', 'Dallas International Airport');
insert into airports values(10143, 'Georgia', 'USA', 'Georgia International Airport');
insert into airports values(10144, 'Phoenix', 'Arizona', 'Phoenix International Airport');
insert into airports values(10145, 'Texas', 'New Mexico', 'Texas International Airport');
insert into airports values(10146, 'Houston', 'New Mexico', 'Houston International Airport');
insert into airports values(10147, 'LasVegas', 'Nevada', 'Las Vegas International Airport');
insert into airports values(10148, 'Washington', 'USA', 'Washington International Airport');
insert into airports values(10149, 'Boston', 'New York', 'Boston International Airport');
insert into airports values(10150, 'Amsterdam', 'New York', 'Amsterdam International Airport');
insert into airports values(10151, 'Geneva', 'New York', 'Geneva International Airport');
insert into airports values(10152, 'Denver', 'USA', 'Denver International Airport');
insert into airports values(10153, 'LA', 'USA', 'LA International Airport');

insert into flights values(1, 10140, 10141, 'DL', 2, 5, 10, -5);
insert into flights values(2, 10140, 10145, 'DL', 23, 2, 2, -7);
insert into flights values(3, 10140, 10144, 'WN', 15, 3, -7, -2);
insert into flights values(4, 10140, 10148, 'WN', 10, 3, 10, 10);
insert into flights values(5, 10140, 10149, 'CQ', 30, 2, 0, -2);
insert into flights values(6, 10140, 10152, 'DL', 18, 3, 0, -3);
insert into flights values(7, 10141, 10142, 'DL', 17, 2, -3, -6);
insert into flights values(8, 10141, 10140, 'DL', 14, 6, -2, 0);
insert into flights values(9, 10142, 10143, 'DL', 23, 4, 4, 3);
insert into flights values(10, 10142, 10148, 'CQ', 4, 6, 0, 3);
insert into flights values(11, 10143, 10144, 'DL', 7, 3, 2, 1);
insert into flights values(12, 10143, 10141, 'WN', 4, 1, 0, -1);
insert into flights values(13, 10145, 10142, 'WN', 1, 2, 1, -2);
insert into flights values(14, 10145, 10146, 'DL', 12, 2, 7, 4);
insert into flights values(15, 10146, 10147, 'WN', 15, 4, 0, 0);
insert into flights values(16, 10147, 10141, 'DL', 9, 1, 0, 1);
insert into flights values(17, 10148, 10147, 'WN', 1, 5, 4, -3);
insert into flights values(18, 10148, 10141, 'WN', 30, 5, 0, 3);
insert into flights values(19, 10149, 10150, 'CQ', 4, 7, -2, 5);
insert into flights values(20, 10149, 10151, 'CQ', 19, 5, -7, 3);
insert into flights values(21, 10150, 10149, 'CQ', 1, 4, 11, 5);
insert into flights values(22, 10150, 10151, 'CQ', 2, 2, 10, -3);
insert into flights values(23, 10152, 10153, 'DL', 21, 3, 7, -3);