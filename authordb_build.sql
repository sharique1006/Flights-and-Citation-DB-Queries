drop table authordetails;
drop table paperdetails;
drop table authorpaperlist;
drop table citationlist;

create table authordetails (
    authorid integer,
    authorname text,
    city text,
    gender text,
    age integer,
    constraint authordetails_key primary key (authorid)
);

create table paperdetails (
    paperid integer,
    papername text,
    conferencename text,
    score integer,
    constraint paperdetails_key primary key (paperid)
);

create table authorpaperlist (
    authorid integer,
    paperid integer,
    constraint authorpaperlist_key primary key (authorid, paperid)
);

create table citationlist (
    paperid1 integer,
    paperid2 integer,
    constraint citationlist_key primary key (paperid1, paperid2)
);

insert into authordetails values(3552, 'A', 'Albuquerque', 'Male', 34);
insert into authordetails values(321, 'B', 'Chicago', 'Male', 32);
insert into authordetails values(704, 'C', 'Chicago', 'Male', 43);
insert into authordetails values(102, 'D', 'Boston', 'Male', 37);
insert into authordetails values(1436, 'E', 'Dallas', 'Male', 35);
insert into authordetails values(562, 'F', 'Gerogia', 'Female', 42);
insert into authordetails values(921, 'G', 'Boston', 'Female', 30);
insert into authordetails values(8, 'G', 'Boston', 'Male', 40);
insert into authordetails values(9, 'B', 'Dallas', 'Female', 51);
insert into authordetails values(1745, 'A1', 'Dallas', 'Male', 29);
insert into authordetails values(1235, 'B1', 'Phoenix', 'Female', 56);
insert into authordetails values(1558, 'C1', 'Denver', 'Male', 49);
insert into authordetails values(2826, 'A2', 'Dallas', 'Male', 38);
insert into authordetails values(14, 'A3', 'Denver', 'Female', 35);
insert into authordetails values(15, 'D2', 'Amsterdam', 'Female', 33);
insert into authordetails values(456, 'A1', 'Dallas', 'Female', 47);
insert into authordetails values(17, 'B1', 'Amsterdam', 'Male', 35);
insert into authordetails values(18, 'B3', 'Gerogia', 'Female', 32);
insert into authordetails values(19, 'B4', 'Geneva', 'Male', 38);

insert into paperdetails values(101, 'Machine Learning Advancements', 'IEEE', 7);
insert into paperdetails values(102, 'Deep Learning Advancements', 'IEEE', 8);
insert into paperdetails values(103, 'Artificial Intelligence Advancements', 'ACM', 9);
insert into paperdetails values(104, 'Computer Vision Advancements', 'ACM', 10);
insert into paperdetails values(105, 'Network Security Advancements', 'IEEE', 6);
insert into paperdetails values(106, 'Cryptography Advancements', 'ACM', 6);
insert into paperdetails values(107, 'ML Advancements', 'ACM', 8);
insert into paperdetails values(108, 'DL Advancements', 'IEEE', 4);
insert into paperdetails values(109, 'AI Advancements', 'IEEE', 10);
insert into paperdetails values(110, 'CV Advancements', 'ACM', 7);
insert into paperdetails values(126, 'NS Advancements', 'IEEE', 6);
insert into paperdetails values(112, 'NS1 Advancements', 'IEEE', 9);
insert into paperdetails values(113, 'ML3 Advancements', 'ACM', 8);
insert into paperdetails values(114, 'ML4 Advancements', 'Springer', 9);
insert into paperdetails values(115, 'ML5 Advancements', 'ACM', 8);
insert into paperdetails values(116, 'DL1 Advancements', 'IEEE', 6);
insert into paperdetails values(117, 'DL2 Advancements', 'Springer', 6);
insert into paperdetails values(118, 'DL3 Advancements', 'ACM', 10);
insert into paperdetails values(119, 'NS2 Advancements', 'ACM', 5);
insert into paperdetails values(120, 'CV4 Advancements', 'Elsevier', 6);
insert into paperdetails values(121, 'CNS1 Advancements', 'ACM', 8);
insert into paperdetails values(122, 'ML2 Advancements', 'IEEE', 7);
insert into paperdetails values(123, 'CV3 Advancements', 'ACM', 6);
insert into paperdetails values(124, 'ML6 Advancements', 'ACM', 9);
insert into paperdetails values(125, 'ML2 Advancements', 'Springer', 9);

insert into authorpaperlist values(3552, 101);
insert into authorpaperlist values(102, 101);
insert into authorpaperlist values(921, 101);
insert into authorpaperlist values(321, 102);
insert into authorpaperlist values(704, 102);
insert into authorpaperlist values(321, 103);
insert into authorpaperlist values(102, 103);
insert into authorpaperlist values(3552, 104);
insert into authorpaperlist values(3552, 105);
insert into authorpaperlist values(704, 105);
insert into authorpaperlist values(562, 106);
insert into authorpaperlist values(704, 107);
insert into authorpaperlist values(102, 107);
insert into authorpaperlist values(321, 108);
insert into authorpaperlist values(562, 108);
insert into authorpaperlist values(921, 108);
insert into authorpaperlist values(321, 109);
insert into authorpaperlist values(1436, 109);
insert into authorpaperlist values(9, 109);
insert into authorpaperlist values(102, 110);
insert into authorpaperlist values(102, 126);
insert into authorpaperlist values(562, 126);
insert into authorpaperlist values(8, 112);
insert into authorpaperlist values(3552, 113);
insert into authorpaperlist values(9, 113);
insert into authorpaperlist values(1745, 114);
insert into authorpaperlist values(14, 114);
insert into authorpaperlist values(1558, 115);
insert into authorpaperlist values(14, 115);
insert into authorpaperlist values(1558, 116);
insert into authorpaperlist values(2826, 116);
insert into authorpaperlist values(2826, 117);
insert into authorpaperlist values(15, 117);
insert into authorpaperlist values(14, 118);
insert into authorpaperlist values(15, 118);
insert into authorpaperlist values(1558, 119);
insert into authorpaperlist values(15, 119);
insert into authorpaperlist values(1235, 120);
insert into authorpaperlist values(14, 120);
insert into authorpaperlist values(1745, 121);
insert into authorpaperlist values(1235, 121);
insert into authorpaperlist values(1558, 122);
insert into authorpaperlist values(456, 122);
insert into authorpaperlist values(17, 123);
insert into authorpaperlist values(18, 123);
insert into authorpaperlist values(17, 124);
insert into authorpaperlist values(19, 125);

insert into citationlist values(102, 101);
insert into citationlist values(103, 101);
insert into citationlist values(103, 102);
insert into citationlist values(104, 102);
insert into citationlist values(104, 103);
insert into citationlist values(105, 102);
insert into citationlist values(106, 105);
insert into citationlist values(107, 101);
insert into citationlist values(108, 102);
insert into citationlist values(108, 107);
insert into citationlist values(109, 103);
insert into citationlist values(109, 107);
insert into citationlist values(109, 108);
insert into citationlist values(110, 104);
insert into citationlist values(110, 107);
insert into citationlist values(110, 108);
insert into citationlist values(110, 109);
insert into citationlist values(126, 105);
insert into citationlist values(126, 106);
insert into citationlist values(126, 108);
insert into citationlist values(113, 126);
insert into citationlist values(114, 103);
insert into citationlist values(114, 112);
insert into citationlist values(115, 106);
insert into citationlist values(116, 106);
insert into citationlist values(117, 126);
insert into citationlist values(118, 101);
insert into citationlist values(118, 109);
insert into citationlist values(118, 106);
insert into citationlist values(118, 123);
insert into citationlist values(118, 124);
insert into citationlist values(119, 117);
insert into citationlist values(119, 120);
insert into citationlist values(120, 102);
insert into citationlist values(121, 109);
insert into citationlist values(121, 102);
insert into citationlist values(121, 106);
insert into citationlist values(122, 104);
insert into citationlist values(123, 126);
insert into citationlist values(124, 104);
insert into citationlist values(124, 105);
insert into citationlist values(124, 108);
insert into citationlist values(125, 107);