--1--
with recursive cite_paths (paperid1, paperid2) as (
select paperid1, paperid2 from citationlist
union
select citationlist.paperid1, cite_paths.paperid2 from
citationlist, cite_paths
where citationlist.paperid2=cite_paths.paperid1)
select authorid from (
select authorid, t2.paperid, num_citations from (
select paperid2 as paperid, count(paperid1) as num_citations from (
select paperid1, paperid2 from cite_paths ) as t1
group by paperid2 ) as t2, authorpaperlist where t2.paperid=authorpaperlist.paperid ) as t3
group by authorid order by sum(num_citations) desc, authorid asc
limit 5;

--2--
with recursive paths (originairportid, origincity, destairportid, destcity, route) as (
select originairportid, origincity, destairportid, destcity, ARRAY[origincity] as route from (
select originairportid, origincity,  destairportid, city as destcity, state as deststate from (
select originairportid, city as origincity, destairportid from flights, airports where airportid=originairportid and city='Albuquerque' and dayofweek!=2 and (dayofmonth%7!=0 or dayofmonth%11!=0) and carrier!='AA') as t1, airports
where airportid=destairportid ) as t2
union
select t1.originairportid, t1.origincity, t1.destairportid, t1.destcity, array_append(paths.route, t1.origincity) from (
select originairportid, origincity, destairportid, city as destcity, state as deststate from (
select originairportid, city as origincity, destairportid from flights, airports where airportid=originairportid and dayofweek!=2 and (dayofmonth%7!=0 or dayofmonth%11!=0) and carrier!='AA') as t1, airports where airportid=destairportid) as t1, paths
where t1.origincity=paths.destcity and t1.origincity != ALL(paths.route))
select count(*) as num_paths from (
select destcity, destairportid, route from paths where not destcity = ANY(route) and destcity='Chicago' ) as t1;

--3--
with recursive paths (author1, author2, route, initiallen, citedauthors) as (
select t1.author1, t1.author2, ARRAY[t1.author1] as route, case when array_length(citedauthors, 1) is NULL then 0 else array_length(citedauthors, 1) end as initiallen, case when array_length(ARRAY(select unnest(citedauthors) as x), 1) is NULL then ARRAY[-1] else ARRAY(select unnest(citedauthors) as x) end as citedauthors from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=2 and author1.paperid=author2.paperid ) as t1
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
select case when (count=0 and num_paths=0) then 0 when (count=0 and num_paths!=0) then 0 when count>0 then count end as count from (
select count, num_paths from (
select count(*) as count from (
select author2, route, citedauthors, wascited from (
select author2, route, citedauthors, (ARRAY[2, 6] && citedauthors) as wascited from (
select author2, route[2:] as route, initiallen, citedauthors[1+initiallen:] as citedauthors from paths where not author2 = ANY(route) and author2=6) as t1 ) as t2
where wascited=true ) as t3 ) as t4, 
(with recursive paths (author1, author2, route) as (
select author1.authorid as author1, author2.authorid as author2, ARRAY[author1.authorid] as route from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.authorid=2 and author1.paperid=author2.paperid
union
select t1.author1, t1.author2, array_append(paths.route, t1.author1) from (
select author1.authorid as author1, author2.authorid as author2 from authorpaperlist as author1, authorpaperlist as author2
where author1.authorid!=author2.authorid and author1.paperid=author2.paperid ) as t1, paths
where t1.author1=paths.author2 and t1.author1 != ALL(paths.route) )
select count(*) as num_paths from paths where not author2 = ANY(route) and author2=6
) as t5 ) as t6;