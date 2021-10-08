-- select * from authordetails;
-- select * from paperdetails;
-- select * from authorpaperlist;
-- select * from citationlist;

-- select authorid from (
-- select authorid from (
-- select distinct on (authorid) authorid, count(paperid) as num_papers from authorpaperlist
-- group by authorid ) as t1 where num_papers=1 ) as t2
-- intersect
-- select authorid from (
-- select paperid from (
-- select distinct on (paperid) paperid, count(authorid) as num_authors from authorpaperlist
-- group by paperid ) as t1 where num_authors=1 ) as t2, authorpaperlist where t2.paperid=authorpaperlist.paperid;

-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ;

-- select author1, author2, paperid, conferencename from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid) ;

-- select author1, author2, paperid, paperid2 as citedpaper from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, citationlist where paperid=paperid1;

--CONFERENCE CONNECTED COMPONENTS IN GRAPH----
-- with recursive paths (author1, author2, route, conferencename, conferences) as (
-- select author1, author2, ARRAY[author1] as route, conferencename, ARRAY[conferencename] as conferences from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid)
-- union
-- select t2.author1, paths.author2, array_append(paths.route, t2.author1), t2.conferencename, array_append(paths.conferences, t2.conferencename) from (
-- select author1, author2, conferencename from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid) ) as t2, paths
-- where t2.author2=paths.author1 and t2.author1!=paths.author2 and t2.conferencename=paths.conferencename and t2.author1 != ALL(paths.route))
-- select distinct on (conferencename, authors) conferencename, authors from (
-- select conferencename, ARRAY(select unnest(authors) as x order by x asc) as authors from (
-- select author1, conferencename, (author1 || authors) as authors from (
-- select author1, conferencename, array_agg(distinct author2) as authors from paths
-- group by author1, conferencename ) as t1 ) as t2 ) as t3;


--ALL PATHS IN GRAPH--
-- with recursive paths (author1, author2, route) as (
-- select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid
-- union
-- select t1.author1, paths.author2, array_append(paths.route, t1.author1) from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
-- where t1.author2=paths.author1 and t1.author1!=paths.author2 and t1.author1 != ALL(paths.route))
-- select * from paths
-- order by author1, author2;

--ALL PATHS from 1 to 2--
-- with recursive paths (author1, author2, route) as (
-- select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid
-- union
-- select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
-- select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
-- where t1.author1=paths.author2 and t1.author1 != ALL(paths.route))
-- select author2, route, array_length(route, 1) as length from paths where not author2 = ANY(route) and author2=2;


--CONFERENCES--

-- with recursive paths (author1, author2, route, conferencename, conferences) as (
-- select author1, author2, ARRAY[author1] as route, conferencename, ARRAY[conferencename] as conferences from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid)
-- union
-- select t2.author1, paths.author2, array_append(paths.route, t2.author1), t2.conferencename, array_append(paths.conferences, t2.conferencename) from (
-- select author1, author2, conferencename from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid) ) as t2, paths
-- where t2.author2=paths.author1 and t2.author1!=paths.author2 and t2.conferencename=paths.conferencename and t2.author1 != ALL(paths.route))
-- select author1, author2, route, conferencename, conferences from paths
-- order by author1, author2;

-- with recursive paths (author1, author2, route, conferencename, conferences) as (
-- select author1, author2, ARRAY[author1] as route, conferencename, ARRAY[conferencename] as conferences from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid)
-- union
-- select t2.author1, paths.author2, array_append(paths.route, t2.author1), t2.conferencename, array_append(paths.conferences, t2.conferencename) from (
-- select author1, author2, conferencename from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid) ) as t2, paths
-- where t2.author2=paths.author1 and t2.author1!=paths.author2 and t2.conferencename=paths.conferencename and t2.author1 != ALL(paths.route))
-- select distinct on (conferencename, authorid) conferencename, authorid from (
-- select conferencename, unnest(route) as authorid, conferences from paths) as t1;

--ARRAY OF AUTHORS WHO CITED P--
-- with recursive paths (paperid1, paperid2) as (
-- select paperid1, paperid2 from citationlist
-- union
-- select citationlist.paperid1, paths.paperid2 from
-- citationlist, paths
-- where citationlist.paperid2=paths.paperid1)
-- select array_agg(authorid) as authorswhocitedp from (
-- select distinct on (authorid) authorid from (
-- select distinct on (authorid, paperid1, paperid2) authorid, paperid1, paperid2 from (
-- select paperid1, paperid2 from paths ) as t1, authorpaperlist where paperid1=paperid ) as t2 where paperid2=108 ) as t3
-- ;

------------EDGE TABLE WITH NUM CITATIONS OF AUTHOR1--------------
-- select author1, author2, paperid, num_citations from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid )
-- as t1, (
-- with recursive cite_paths (paperid1, paperid2) as (
-- select paperid1, paperid2 from citationlist
-- union
-- select citationlist.paperid1, cite_paths.paperid2 from
-- citationlist, cite_paths
-- where citationlist.paperid2=cite_paths.paperid1)
-- select distinct on (authorid) authorid, count(paperid2) as num_citations from (
-- select distinct on (authorid, paperid1, paperid2) authorid, paperid1, paperid2 from (
-- select paperid1, paperid2 from cite_paths ) as t1, authorpaperlist where paperid1=paperid ) as t2
-- group by authorid ) as t3 where t1.author1=t3.authorid;

-------------------------
--PATH FROM 1 to 2--
-- with recursive paths (author1, author2, route) as (
-- select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid
-- union
-- select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
-- select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
-- where t1.author1=paths.author2 and t1.author1 != ALL(paths.route) )
-- select author2, route from paths where not author2 = ANY(route) and author2=2 ;

--------------
--PATH FROM 1 to 2 WITH NUMBER OF CITATIONS
-- with recursive paths (author1, author2, route, num_cites) as (
-- select author1, author2, ARRAY[author1] as route, ARRAY[num_citations] as num_cites from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid )
-- as t1, (
-- with recursive cite_paths (paperid1, paperid2) as (
-- select paperid1, paperid2 from citationlist
-- union
-- select citationlist.paperid1, cite_paths.paperid2 from
-- citationlist, cite_paths
-- where citationlist.paperid2=cite_paths.paperid1)
-- select distinct on (authorid) authorid, count(paperid2) as num_citations from (
-- select distinct on (authorid, paperid1, paperid2) authorid, paperid1, paperid2 from (
-- select paperid1, paperid2 from cite_paths ) as t1, authorpaperlist where paperid1=paperid ) as t2
-- group by authorid ) as t3 where t1.author1=t3.authorid
-- union
-- select t4.author1, t4.author2, array_append(paths.route, t4.author1), array_append(paths.num_cites, t4.num_citations) from (
-- select author1, author2, num_citations from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid )
-- as t1, (
-- with recursive cite_paths (paperid1, paperid2) as (
-- select paperid1, paperid2 from citationlist
-- union
-- select citationlist.paperid1, cite_paths.paperid2 from
-- citationlist, cite_paths
-- where citationlist.paperid2=cite_paths.paperid1)
-- select distinct on (authorid) authorid, count(paperid2) as num_citations from (
-- select distinct on (authorid, paperid1, paperid2) authorid, paperid1, paperid2 from (
-- select paperid1, paperid2 from cite_paths ) as t1, authorpaperlist where paperid1=paperid ) as t2
-- group by authorid ) as t3 where t1.author1=t3.authorid ) as t4, paths
-- where t4.author1=paths.author2 and t4.author1 != ALL(paths.route) )
-- select author2, route, num_cites from paths where not author2 = ANY(route) and author2=2;
---------
-- select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid
-- order by author1, author2 ;

-------
--------PATHS FROM 1 to 2 with cities-----------
-- with recursive paths (author1, author2, route, cities) as (
-- select author1, author2, ARRAY[author1] as route, ARRAY[city] as cities from (
-- select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid ) as t1, authordetails where author1=authorid
-- union
-- select t2.author1, t2.author2, array_append(paths.route, t2.author1), array_append(paths.cities, t2.city) from (
-- select author1, city, author2 from (
-- select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, authordetails where author1=authorid )
-- as t2, paths
-- where t2.author1=paths.author2 and t2.author1 != ALL(paths.route))
-- select author2, route, cities from paths where not author2 = ANY(route) and author2=2;


--------DIRECTLY OR INDIRECTLY CITED PAPERS BY PAPERID1-----------
-- with recursive cite_paths (paperid1, paperid2) as (
-- select paperid1, paperid2 from citationlist
-- union
-- select citationlist.paperid1, cite_paths.paperid2 from
-- citationlist, cite_paths
-- where citationlist.paperid2=cite_paths.paperid1)
-- select paperid1, citedpapers from (
-- select paperid1, array_agg(paperid2) as citedpapers from (
-- select paperid1, paperid2 from cite_paths ) as t1
-- group by paperid1 ) as t2
-- order by paperid1;

-------------DIRECTLY OR INDIRECTLY AUTHORS CITED BY AUTHOR1--------------
-- with recursive cite_paths (paperid1, paperid2) as (
-- select paperid1, paperid2 from citationlist
-- union
-- select citationlist.paperid1, cite_paths.paperid2 from
-- citationlist, cite_paths
-- where citationlist.paperid2=cite_paths.paperid1)
-- select author1, array_agg(distinct author2) as citedauthors from (
-- select author1, authorid as author2 from (
-- select authorid as author1, paperid1, paperid2 from cite_paths, authorpaperlist where paperid1=paperid ) as t1, authorpaperlist
-- where paperid2=paperid and author1 != authorid ) as t2
-- group by author1
-- order by author1;

---------BASE CASE OF RECURSION 18-------------
-- select t1.author1, t1.author2, citedauthors from (
-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid ) as t1
-- left join (
-- select author1, array_agg(distinct author2) as citedauthors from (
-- select author1, authorid as author2 from (
-- select authorid as author1, paperid2 from (
-- select paperid1, paperid2 from citationlist ) as t1, authorpaperlist where paperid=paperid1 ) as t2, authorpaperlist
-- where paperid=paperid2 and author1!=authorid ) as t3
-- group by author1 ) as t4 on t1.author1=t4.author1;

----------BASE CASE OF RECURSION 20----------
-- select t1.author1, t1.author2, citedauthors from (
-- select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid ) as t1
-- left join
-- (with recursive cite_paths (paperid1, paperid2) as (
-- select paperid1, paperid2 from citationlist
-- union
-- select citationlist.paperid1, cite_paths.paperid2 from
-- citationlist, cite_paths
-- where citationlist.paperid2=cite_paths.paperid1)
-- select author1, array_agg(distinct author2) as citedauthors from (
-- select author1, authorid as author2 from (
-- select authorid as author1, paperid1, paperid2 from cite_paths, authorpaperlist where paperid1=paperid ) as t1, authorpaperlist
-- where paperid2=paperid and author1 != authorid ) as t2
-- group by author1 ) as t2 on t1.author1=t2.author1;

-- select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
-- where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ;

------DIRECT CITATIONS OF AUTHOR1---------
-- select author1, array_agg(distinct author2) as citedauthors from (
-- select author1, authorid as author2 from (
-- select authorid as author1, paperid2 from (
-- select paperid1, paperid2 from citationlist ) as t1, authorpaperlist where paperid=paperid1 ) as t2, authorpaperlist
-- where paperid=paperid2 and author1!=authorid ) as t3
-- group by author1;

------SINGLE AUTHORID CONFERENCE---------
-- select conferencename, ARRAY[authorid] as authors from (
-- select t3.authorid, paperid from (
-- select authorid from (
-- select authorid from (
-- select distinct on (authorid) authorid, count(paperid) as num_papers from authorpaperlist
-- group by authorid ) as t1 where num_papers=1 ) as t2
-- intersect
-- select authorid from (
-- select paperid from (
-- select distinct on (paperid) paperid, count(authorid) as num_authors from authorpaperlist
-- group by paperid ) as t1 where num_authors=1 ) as t2, authorpaperlist where t2.paperid=authorpaperlist.paperid ) as t3, authorpaperlist
-- where t3.authorid=authorpaperlist.authorid ) as t4, paperdetails where t4.paperid=paperdetails.paperid;



----CONFERENCES WITH SINGLE PAPER AUTHORS--------------
-- select conferencename, ARRAY[authorid] as authors from (
-- select authorid, conferencename from (
-- select authorid, conferencename from (
-- select distinct on (authorid, conferencename) authorid, conferencename, count(paperid) as num_papers from (
-- select authorid, authorpaperlist.paperid, conferencename from authorpaperlist, paperdetails where
-- authorpaperlist.paperid=paperdetails.paperid ) as t1
-- group by authorid, conferencename ) as t2
-- where num_papers=1 ) as t3 
-- intersect
-- select authorid, conferencename from (
-- select authorid, t2.paperid from (
-- select paperid from (
-- select distinct on (paperid) paperid, count(authorid) as num_authors from authorpaperlist
-- group by paperid ) as t1 where num_authors=1 ) as t2, authorpaperlist where t2.paperid=authorpaperlist.paperid ) as t3, paperdetails
-- where t3.paperid=paperdetails.paperid ) as t4; 


/*
--12--
with recursive paths (author1, author2, route) as (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid
union
select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author1=paths.author2 and t1.author1 != ALL(paths.route))
select authorid, length from (
select distinct on (authorid) authorid, max(length) as length from (
select authorid, length from (
select author2 as authorid, length from (
select author2, route, length, row_number() over(partition by author2 order by length asc, author2 asc) as rank from (
select author2, route, array_length(route, 1) as length from paths where not author2 = ANY(route) ) as t3 ) as t4
where rank=1 ) as t5
union all
select authorid, -1 as length from authordetails ) as t6
group by authorid ) as t7
order by length desc, authorid asc;

--13--
with recursive paths (author1, gender, author2, route, ages, genders) as (
select author1, gender, author2, ARRAY[author1] as route, ARRAY[age] as ages, ARRAY[gender] as genders from (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=3 and author1.paperid=author2.paperid ) as t1, authordetails where authorid=author1
union
select t2.author1, t2.gender, t2.author2, array_append(paths.route, t2.author1), array_append(paths.ages, t2.age), array_append(paths.genders, t2.gender) from (
select author1, age, gender, author2 from (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, authordetails where authorid=author1 and age>35 ) as t2, paths
where t2.author1=paths.author2 and (array_length(paths.genders, 1)<=1 or array_length(paths.genders, 1)>1 and t2.gender!=paths.gender) and t2.author1 != ALL(paths.route))
select case when (count=0 and num_paths=0) then -1 when (count=0 and num_paths!=0) then 0 when count>0 then count end as count from ( 
select count, num_paths from (
select count(*) as count from paths where not author2 = ANY(route) and author2=8 ) as t1, (
with recursive paths (author1, author2, route) as (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=3 and author1.paperid=author2.paperid
union
select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author1=paths.author2 and t1.author1 != ALL(paths.route) )
select count(*) as num_paths from paths where not author2 = ANY(route) and author2=8 ) as t2 ) as t3;

--14--
with recursive paths (author1, author2, route) as (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid
union
select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author1=paths.author2 and t1.author1 != ALL(paths.route) )
select case when (count=0 and num_paths=0) then -1 when (count=0 and num_paths!=0) then 0 when count>0 then count end as count from (
select count, num_paths from (
select count(*) as count from (
select route, (route[2:] && authorswhocitedp) as atleastone from (
select author2, route from paths where not author2 = ANY(route) and author2=2 )
as t1, (
with recursive paths (paperid1, paperid2) as (
select paperid1, paperid2 from citationlist
union
select citationlist.paperid1, paths.paperid2 from
citationlist, paths
where citationlist.paperid2=paths.paperid1)
select array_agg(authorid) as authorswhocitedp from (
select distinct on (authorid) authorid from (
select distinct on (authorid, paperid1, paperid2) authorid, paperid1, paperid2 from (
select paperid1, paperid2 from paths ) as t1, authorpaperlist where paperid1=paperid ) as t2 where paperid2=108 ) as t3 ) as t4 ) as t5 where atleastone=true ) as t6,
(with recursive paths (author1, author2, route) as (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid
union
select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author1=paths.author2 and t1.author1 != ALL(paths.route) )
select count(*) as num_paths from paths where not author2 = ANY(route) and author2=2 ) as t8 ) as t9;

--15--
select case when (count=0 and num_paths=0) then -1 when (count=0 and num_paths!=0) then 0 when count>0 then count end as count from (
select count, num_paths from (
select count(*) as count from (
(with recursive paths (author1, num_citations, author2, route, num_cites) as (
select author1, num_citations, author2, ARRAY[author1] as route, ARRAY[num_citations] as num_cites from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid )
as t1, (
with recursive cite_paths (paperid1, paperid2) as (
select paperid1, paperid2 from citationlist
union
select citationlist.paperid1, cite_paths.paperid2 from
citationlist, cite_paths
where citationlist.paperid2=cite_paths.paperid1)
select distinct on (authorid) authorid, count(paperid2) as num_citations from (
select distinct on (authorid, paperid1, paperid2) authorid, paperid1, paperid2 from (
select paperid1, paperid2 from cite_paths ) as t1, authorpaperlist where paperid1=paperid ) as t2
group by authorid ) as t3 where t1.author1=t3.authorid
union
select t4.author1, t4.num_citations, t4.author2, array_append(paths.route, t4.author1), array_append(paths.num_cites, t4.num_citations) from (
select author1, author2, num_citations from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid )
as t1, (
with recursive cite_paths (paperid1, paperid2) as (
select paperid1, paperid2 from citationlist
union
select citationlist.paperid1, cite_paths.paperid2 from
citationlist, cite_paths
where citationlist.paperid2=cite_paths.paperid1)
select distinct on (authorid) authorid, count(paperid2) as num_citations from (
select distinct on (authorid, paperid1, paperid2) authorid, paperid1, paperid2 from (
select paperid1, paperid2 from cite_paths ) as t1, authorpaperlist where paperid1=paperid ) as t2
group by authorid ) as t3 where t1.author1=t3.authorid ) as t4, paths
where t4.author1=paths.author2 and (array_length(paths.num_cites, 1)<=1 or array_length(paths.num_cites, 1)>1 and t4.num_citations>paths.num_citations) and t4.author1 != ALL(paths.route) )
select author2, route, num_cites from paths where not author2 = ANY(route) and author2=2)
union
(with recursive paths (author1, num_citations, author2, route, num_cites) as (
select author1, num_citations, author2, ARRAY[author1] as route, ARRAY[num_citations] as num_cites from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid )
as t1, (
with recursive cite_paths (paperid1, paperid2) as (
select paperid1, paperid2 from citationlist
union
select citationlist.paperid1, cite_paths.paperid2 from
citationlist, cite_paths
where citationlist.paperid2=cite_paths.paperid1)
select distinct on (authorid) authorid, count(paperid2) as num_citations from (
select distinct on (authorid, paperid1, paperid2) authorid, paperid1, paperid2 from (
select paperid1, paperid2 from cite_paths ) as t1, authorpaperlist where paperid1=paperid ) as t2
group by authorid ) as t3 where t1.author1=t3.authorid
union
select t4.author1, t4.num_citations, t4.author2, array_append(paths.route, t4.author1), array_append(paths.num_cites, t4.num_citations) from (
select author1, author2, num_citations from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid )
as t1, (
with recursive cite_paths (paperid1, paperid2) as (
select paperid1, paperid2 from citationlist
union
select citationlist.paperid1, cite_paths.paperid2 from
citationlist, cite_paths
where citationlist.paperid2=cite_paths.paperid1)
select distinct on (authorid) authorid, count(paperid2) as num_citations from (
select distinct on (authorid, paperid1, paperid2) authorid, paperid1, paperid2 from (
select paperid1, paperid2 from cite_paths ) as t1, authorpaperlist where paperid1=paperid ) as t2
group by authorid ) as t3 where t1.author1=t3.authorid ) as t4, paths
where t4.author1=paths.author2 and (array_length(paths.num_cites, 1)<=1 or array_length(paths.num_cites, 1)>1 and t4.num_citations<paths.num_citations) and t4.author1 != ALL(paths.route) )
select author2, route, num_cites from paths where not author2 = ANY(route) and author2=2)) as t10 ) as t11,
(with recursive paths (author1, author2, route) as (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid
union
select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author1=paths.author2 and t1.author1 != ALL(paths.route) )
select count(*) as num_paths from paths where not author2 = ANY(route) and author2=2) as t12 ) as t13;

--16--
select author1 as authorid, num_collaborations from (
select author1, array_length(collaborations, 1) as num_collaborations from (
select author1, array_agg(distinct author2) as collaborations from (
select t3.author1, t3.author2 from (
with recursive cite_paths (paperid1, paperid2) as (
select paperid1, paperid2 from citationlist
union
select citationlist.paperid1, cite_paths.paperid2 from
citationlist, cite_paths
where citationlist.paperid2=cite_paths.paperid1)
select distinct on (author1, author2) author1, author2 from (
select author1, authorid as author2 from (
select authorid as author1, paperid1, paperid2 from cite_paths, authorpaperlist where paperid1=paperid ) as t1, authorpaperlist
where paperid2=paperid and author1 != authorid ) as t2 ) as t3
left join (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t4
on t3.author1=t4.author1 and t3.author2=t4.author2 where t4.author1 is NULL and t4.author2 is NULL ) as t5
group by author1 ) as t6 ) as t7
order by num_collaborations desc, author1 asc
limit 10;

--17--
select author1 as authorid from (
select distinct on (author1) author1, sum(num_citations) as num_citations from (
select distinct on (author1, author2, num_citations) author1, author2, num_citations from (
select t2.author1, t2.author2, num_citations from (
with recursive paths (author1, author2, depth, route) as (
select author1.authorid as author1, author2.authorid as author2, 0, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid
union
select t1.author1, paths.author2, paths.depth+1, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author2=paths.author1 and t1.author1!=paths.author2 and paths.depth<2 and t1.author1 != ALL(paths.route))
select distinct on (author1, author2) author1, author2 from (
select author1, author2, route from paths where paths.depth=2 ) as t1 ) as t2, 
(select author1, author2, paperid, num_citations from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid )
as t1, (
with recursive cite_paths (paperid1, paperid2) as (
select paperid1, paperid2 from citationlist
union
select citationlist.paperid1, cite_paths.paperid2 from
citationlist, cite_paths
where citationlist.paperid2=cite_paths.paperid1)
select distinct on (authorid) authorid, count(paperid2) as num_citations from (
select distinct on (authorid, paperid1, paperid2) authorid, paperid1, paperid2 from (
select paperid1, paperid2 from cite_paths ) as t1, authorpaperlist where paperid1=paperid ) as t2
group by authorid ) as t3 where t1.author1=t3.authorid ) as t3
where t2.author2=t3.author1 ) as t4 ) as t5
group by author1 ) as t6
order by num_citations desc, authorid asc
limit 10;

--18--
with recursive paths (author1, author2, route) as (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid
union
select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author1=paths.author2 and t1.author1 != ALL(paths.route) )
select case when (count=0 and num_paths=0) then -1 when (count=0 and num_paths!=0) then 0 when count>0 then count end as count from (
select count, num_paths from (
select count(*) as count from (
select author2, route from (
select author2, route from paths where not author2 = ANY(route) and author2=2 ) as t1
where (3 = ANY(route) or 6 = ANY(route) or 7 = ANY(route)) ) as t2 ) as t3,
(with recursive paths (author1, author2, route) as (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid
union
select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author1=paths.author2 and t1.author1 != ALL(paths.route) )
select count(*) as num_paths from paths where not author2 = ANY(route) and author2=2 ) as t4 ) as t5;

--19--
select case when (count=0 and num_paths=0) then -1 when (count=0 and num_paths!=0) then 0 when count>0 then count end as count from (
select count, num_paths from (
select count(*) as count from (
select author2, route, citedauthors, cities from (
with recursive paths (author1, author2, route, initiallen, citedauthors) as (
select t1.author1, t1.author2, ARRAY[t1.author1] as route, array_length(citedauthors, 1) as initiallen, ARRAY(select unnest(citedauthors) as x) as citedauthors from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid ) as t1
left join (
select author1, array_agg(distinct author2) as citedauthors from (
select author1, authorid as author2 from (
select authorid as author1, paperid2 from (
select paperid1, paperid2 from citationlist ) as t1, authorpaperlist where paperid=paperid1 ) as t2, authorpaperlist
where paperid=paperid2 and author1 != authorid ) as t3
group by author1 ) as t4 on t1.author1=t4.author1
union
select t5.author1, t5.author2, array_append(paths.route, t5.author1), paths.initiallen, array_cat(paths.citedauthors, ARRAY(select unnest(t5.citedauthors) as x)) from (
select t1.author1, t1.author2, citedauthors from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1
left join (
select author1, array_agg(distinct author2) as citedauthors from (
select author1, authorid as author2 from (
select authorid as author1, paperid2 from (
select paperid1, paperid2 from citationlist ) as t1, authorpaperlist where paperid=paperid1 ) as t2, authorpaperlist
where paperid=paperid2 and author1!=authorid ) as t3
group by author1 ) as t4 on t1.author1=t4.author1 ) as t5, paths
where t5.author1=paths.author2 and t5.author1 != ALL(paths.route))
select author2, route, citedauthors from (
select author2, route, citedauthors, (route && citedauthors) as wascited from (
select author2, route[2:] as route, citedauthors[1+initiallen:] as citedauthors from paths where not author2 = ANY(route) and author2=2 ) as t1 ) as t2
where wascited=false ) as t7
join (
with recursive paths (author1, author2, route, cities) as (
select author1, author2, ARRAY[author1] as route, ARRAY[city] as cities from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid ) as t1, authordetails where author1=authorid
union
select t2.author1, t2.author2, array_append(paths.route, t2.author1), array_append(paths.cities, t2.city) from (
select author1, city, author2 from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, authordetails where author1=authorid )
as t2, paths
where t2.author1=paths.author2 and t2.author1 != ALL(paths.route))
select author2, route, length, cities from (
select author2, route, length, ARRAY(select distinct unnest(cities) as x) as cities from (
select author2, route[2:] as route, array_length(cities, 1)-1 as length, cities[2:] as cities from paths where not author2 = ANY(route) and author2=2 ) as t1 ) as t2
where length=array_length(cities,1) ) as t8
using(author2, route) ) as t9 ) as t10, (
with recursive paths (author1, author2, route) as (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid
union
select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author1=paths.author2 and t1.author1 != ALL(paths.route) )
select count(*) as num_paths from paths where not author2 = ANY(route) and author2=2 ) as t11 ) as t12;

--20--
with recursive paths (author1, author2, route, initiallen, citedauthors) as (
select t1.author1, t1.author2, ARRAY[t1.author1] as route, array_length(citedauthors, 1) as initiallen, ARRAY(select unnest(citedauthors) as x) as citedauthors from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid ) as t1
left join
(with recursive cite_paths (paperid1, paperid2) as (
select paperid1, paperid2 from citationlist
union
select citationlist.paperid1, cite_paths.paperid2 from
citationlist, cite_paths
where citationlist.paperid2=cite_paths.paperid1)
select author1, array_agg(distinct author2) as citedauthors from (
select author1, authorid as author2 from (
select authorid as author1, paperid1, paperid2 from cite_paths, authorpaperlist where paperid1=paperid ) as t1, authorpaperlist
where paperid2=paperid and author1 != authorid ) as t2
group by author1 ) as t2 on t1.author1=t2.author1
union
select t4.author1, t4.author2, array_append(paths.route, t4.author1), paths.initiallen, array_cat(paths.citedauthors, ARRAY(select unnest(t4.citedauthors) as x)) from (
select t1.author1, t1.author2, citedauthors from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid  and author1.paperid=author2.paperid ) as t1
left join
(with recursive cite_paths (paperid1, paperid2) as (
select paperid1, paperid2 from citationlist
union
select citationlist.paperid1, cite_paths.paperid2 from
citationlist, cite_paths
where citationlist.paperid2=cite_paths.paperid1)
select author1, array_agg(distinct author2) as citedauthors from (
select author1, authorid as author2 from (
select authorid as author1, paperid1, paperid2 from cite_paths, authorpaperlist where paperid1=paperid ) as t1, authorpaperlist
where paperid2=paperid and author1 != authorid ) as t2
group by author1 ) as t2 on t1.author1=t2.author1 ) as t4, paths
where t4.author1=paths.author2 and t4.author1 != ALL(paths.route) )
select case when (count=0 and num_paths=0) then -1 when (count=0 and num_paths!=0) then 0 when count>0 then count end as count from (
select count, num_paths from (
select count(*) as count from (
select author2, route, citedauthors, wascited from (
select author2, route, citedauthors, (route && citedauthors) as wascited from (
select author2, route[2:] as route, initiallen, citedauthors[1+initiallen:] as citedauthors from paths where not author2 = ANY(route) and author2=2) as t1 ) as t2
where wascited=false ) as t3 ) as t4, 
(with recursive paths (author1, author2, route) as (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=1 and author1.paperid=author2.paperid
union
select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author1=paths.author2 and t1.author1 != ALL(paths.route) )
select count(*) as num_paths from paths where not author2 = ANY(route) and author2=2
) as t5 ) as t6;

--21--
with recursive paths (author1, author2, route, conferencename, conferences) as (
select author1, author2, ARRAY[author1] as route, conferencename, ARRAY[conferencename] as conferences from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid)
union
select t2.author1, paths.author2, array_append(paths.route, t2.author1), t2.conferencename, array_append(paths.conferences, t2.conferencename) from (
select author1, author2, conferencename from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid) ) as t2, paths
where t2.author2=paths.author1 and t2.author1!=paths.author2 and t2.conferencename=paths.conferencename and t2.author1 != ALL(paths.route))
select conferencename, count from (
select distinct on (conferencename) conferencename, count(authors) as count from (
select distinct on (conferencename, authors) conferencename, authors from (
select conferencename, ARRAY(select unnest(authors) as x order by x asc) as authors from (
select author1, conferencename, (author1 || authors) as authors from (
select author1, conferencename, array_agg(distinct author2) as authors from paths
group by author1, conferencename ) as t1 ) as t2 ) as t3 ) as t4
group by conferencename ) as t5
order by count desc, conferencename asc;

--22--
with recursive paths (author1, author2, route, conferencename, conferences) as (
select author1, author2, ARRAY[author1] as route, conferencename, ARRAY[conferencename] as conferences from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid)
union
select t2.author1, paths.author2, array_append(paths.route, t2.author1), t2.conferencename, array_append(paths.conferences, t2.conferencename) from (
select author1, author2, conferencename from (
select author1.authorid as author1, author2.authorid as author2, author2.paperid from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1 join paperdetails using(paperid) ) as t2, paths
where t2.author2=paths.author1 and t2.author1!=paths.author2 and t2.conferencename=paths.conferencename and t2.author1 != ALL(paths.route))
select conferencename, count from (
select conferencename, array_length(authors, 1) as count from (
select distinct on (conferencename, authors) conferencename, authors from (
select conferencename, ARRAY(select unnest(authors) as x order by x asc) as authors from (
select author1, conferencename, (author1 || authors) as authors from (
select author1, conferencename, array_agg(distinct author2) as authors from paths
group by author1, conferencename ) as t1 ) as t2 ) as t3 ) as t4 ) as t5
order by count asc, conferencename asc;

*/


-- select * from airport
-- select * from flights;

-- select flightid, originairportid, origincity, originstate, destairportid, city as destcity, state as deststate, carrier from (
-- select flightid, originairportid, city as origincity, state as originstate, destairportid, carrier from
-- airports, flights where originairportid=airportid ) as t1, airports
-- where airportid=destairportid;

--ALL PATHS--
-- with recursive paths (originairportid, destairportid, route) as (
-- select originairportid, destairportid, ARRAY[originairportid] as route from flights
-- union
-- select flights.originairportid, paths.destairportid, array_append(paths.route, flights.originairportid)
-- from flights, paths
-- where flights.destairportid=paths.originairportid and flights.originairportid != ALL(paths.route))
-- select originairportid, destairportid, (destairportid || route) as route from paths;

-- with recursive paths (origincity, destcity, route) as (
-- select origincity, city as destcity, ARRAY[origincity] from (
-- select city as origincity, destairportid from flights, airports where airportid=originairportid ) as t1, airports where airportid=destairportid
-- union
-- select t3.origincity, paths.destcity, array_append(paths.route, t3.origincity) from (
-- select origincity, city as destcity from (
-- select city as origincity, destairportid from flights, airports where airportid=originairportid ) as t2, airports where airportid=destairportid ) as t3, paths
-- where t3.destcity=paths.origincity and t3.origincity != ALL(paths.route))
-- select origincity, destcity, (destcity || route) as route from paths
-- order by origincity asc, destcity asc;

/*
--1--
with recursive explore(originairportid, destairportid, carrier) as (
select originairportid, destairportid, carrier from flights
union
select flights.originairportid, explore.destairportid, flights.carrier
from flights, explore
where flights.destairportid=explore.originairportid and flights.carrier=explore.carrier)
select distinct on (city) city as name from (
select destairportid from explore where originairportid=10140 ) as t1, airports where destairportid=airportid
order by name asc;

--2--
with recursive explore(originairportid, destairportid, dayofweek) as (
select originairportid, destairportid, dayofweek from flights
union
select flights.originairportid, explore.destairportid, flights.dayofweek
from flights, explore
where flights.destairportid=explore.originairportid and flights.dayofweek=explore.dayofweek)
select distinct on (city) city as name from (
select destairportid from explore where originairportid=10140 ) as t1, airports where destairportid=airportid
order by name asc;

--3--
with recursive paths (originairportid, destairportid, route) as (
select originairportid, destairportid, ARRAY[originairportid] as route from flights where originairportid=10140
union
select flights.originairportid, flights.destairportid, array_append(paths.route, flights.originairportid)
from flights, paths
where flights.originairportid=paths.destairportid and flights.originairportid != ALL(paths.route))
select name from (
select distinct on (name) name, count(route) as num_paths from (
select city as name, route from (
select destairportid, route from paths where not destairportid = ANY(route) ) as t1, airports where airportid=destairportid ) as t2
group by name ) as t3 where num_paths=1
order by name asc;

--4--
with recursive paths (originairportid, destairportid, route) as (
select originairportid, destairportid, ARRAY[originairportid] as route from flights where originairportid=10140
union
select flights.originairportid, flights.destairportid, array_append(paths.route, flights.originairportid) from
flights, paths
where flights.originairportid=paths.destairportid and flights.originairportid != ALL(paths.route))
select length from (
select destairportid, route, array_length(route, 1) as length from paths where destairportid=10140 ) as t1
order by length desc
limit 1;

--5--
with recursive paths (originairportid, destairportid, route) as (
select originairportid, destairportid, ARRAY[originairportid] as route from flights
union
select flights.originairportid, paths.destairportid, array_append(paths.route, flights.originairportid) from
flights, paths
where flights.destairportid=paths.originairportid and flights.originairportid != ALL(paths.route))
select length from (
select originairportid, destairportid, route, array_length(route, 1) as length from (
select originairportid, destairportid, route from paths where destairportid=route[array_length(route,1)] ) as t1 ) as t2
order by length desc
limit 1;

--6--
with recursive paths (originairportid, origincity, originstate, destairportid, destcity, deststate, route) as (
select originairportid, origincity, originstate, destairportid, destcity, deststate, ARRAY[origincity] as route from (
select originairportid, origincity, originstate, destairportid, city as destcity, state as deststate from (
select originairportid, city as origincity, state as originstate, destairportid from flights, airports where airportid=originairportid and city='Albuquerque') as t1, airports
where airportid=destairportid and originstate!=state ) as t2
union
select t1.originairportid, t1.origincity, t1.originstate, t1.destairportid, t1.destcity, t1.deststate, array_append(paths.route, t1.origincity) from (
select originairportid, origincity, originstate, destairportid, city as destcity, state as deststate from (
select originairportid, city as origincity, state as originstate, destairportid from flights, airports where airportid=originairportid ) as t1, airports where airportid=destairportid and originstate!=state ) as t1, paths
where t1.origincity=paths.destcity and t1.origincity != ALL(paths.route))
select count(*) as count from (
select destcity, deststate, destairportid, array_append(route, destcity) as route from (
select destcity, deststate, destairportid, route from paths where not destcity = ANY(route) ) as t1 ) as t2
where destcity='Chicago';

--7--
with recursive paths (originairportid, origincity, destairportid, destcity, route) as (
select originairportid, origincity, destairportid, destcity, ARRAY[origincity] as route from (
select originairportid, origincity, destairportid, city as destcity from (
select originairportid, city as origincity, destairportid from flights, airports where airportid=originairportid and city='Albuquerque') as t1, airports
where airportid=destairportid ) as t2
union
select t1.originairportid, t1.origincity, t1.destairportid, t1.destcity, array_append(paths.route, t1.origincity) from (
select originairportid, origincity, destairportid, city as destcity from (
select originairportid, city as origincity, destairportid from flights, airports where airportid=originairportid ) as t1, airports where airportid=destairportid ) as t1, paths
where t1.origincity=paths.destcity and t1.origincity != ALL(paths.route))
select count(*) as count from (
select destcity, destairportid, route from paths where not destcity = ANY(route) ) as t1
where 'Washington'=ANY(route) and destcity='Chicago';

--8--
select distinct on (name1, name2) name1, name2 from (
select t1.city as name1, t2.city as name2 from airports as t1 cross join airports as t2 where t1.city!=t2.city ) as t4
left join (
with recursive paths (origincity, destcity) as (
select origincity, city as destcity from (
select originairportid, city as origincity, destairportid from flights, airports where airportid=originairportid ) as t1, airports where airportid=destairportid
union
select t3.origincity, paths.destcity from (
select origincity, city as destcity from (
select originairportid, city as origincity, destairportid from flights, airports where airportid=originairportid ) as t2, airports where airportid=destairportid ) as t3, paths
where t3.destcity=paths.origincity)
select * from paths
order by origincity asc, destcity asc ) as t5
on name1=origincity and name2=destcity where origincity is NULL and destcity is NULL
order by name1 asc, name2 asc;

--9--
select day from (
select distinct on (day) day, sum(delay) as delay, sum(dayofweek) as dayofweek from (
select day, delay, dayofweek from (
select day, 0 as delay, 0 as dayofweek from generate_series(1, 31) day ) as t1
union all
select dayofmonth as day, delay, dayofweek from (
select distinct on (dayofmonth) dayofweek, dayofmonth, sum(delay) as delay from (
select flightid, originairportid, city as origincity, destairportid, dayofweek, dayofmonth, departuredelay+arrivaldelay as delay from
flights, airports where originairportid=airportid and city='Albuquerque' ) as t1
group by dayofweek, dayofmonth ) as t2 ) as t3
group by day ) as t4
order by delay asc, day asc, dayofweek asc;

--10--
select origincity as name from (
select distinct on (origincity) origincity, count(destcity) as num_cities from (
select distinct on (origincity, city) origincity, city as destcity from (
select originairportid, city as origincity, destairportid from flights, airports where airportid=originairportid and state='New York' ) as t1, airports
where airportid=destairportid and state='New York') as t2
group by origincity ) as t3, 
(select count(*) from (
select distinct on (city) city from (
select city from airports where state='New York' ) as t1 ) as t2 ) as t4
where num_cities=count-1;

--11--
with recursive paths (originairportid, destairportid, route, delay) as (
select originairportid, destairportid, ARRAY[originairportid] as route, arrivaldelay+departuredelay as delay from flights
union
select flights.originairportid, paths.destairportid, array_append(paths.route, flights.originairportid), flights.arrivaldelay+flights.departuredelay as delay from
flights, paths
where flights.destairportid=paths.originairportid and (flights.arrivaldelay+flights.departuredelay)<=paths.delay and flights.originairportid != ALL(paths.route))
select distinct on (name1, name2) name1, name2 from (
select name1, city as name2 from (
select city as name1, destairportid from paths, airports where originairportid=airportid ) as t1, airports
where airportid=destairportid and name1!=city ) as t2
group by name1, name2
order by name1 asc, name2 asc;
*/