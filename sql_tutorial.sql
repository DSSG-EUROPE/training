-- Join two or more tables to combine data based on a related column between them
select s.station_id, w.station_id, s.station_name, w.value_type, w.value from qhan.stations s 
join qhan.weather w on  s.station_id = w.station_id;

-- This is equivalent to the inner join by specifying the condition
select s.station_id, w.station_id, s.station_name, w.value_type, w.value from qhan.stations s 
inner join qhan.weather w using (station_id);

-- Left join returns all records from stations and any matching records from weather.
select s.station_id, w.station_id, s.station_name, w.value_type, w.value from qhan.stations s 
left join qhan.weather w on  s.station_id = w.station_id;

-- Righ join returns all records from weather and any matching records from stations
select s.station_id, w.station_id, s.station_name, w.value_type, w.value from qhan.stations s 
right join qhan.weather w on  s.station_id = w.station_id;

-- full join returns all records from weather and from station
select s.station_id, w.station_id, s.station_name, w.value_type, w.value from qhan.stations s 
full join qhan.weather w on  s.station_id = w.station_id;

-- Find records that show up in weather but does not have matchin records in stations
select s.station_id, w.station_id from qhan.stations s right join qhan.weather w on s.station_id = w.station_id
where s.station_id isnull;

-- Find records that combine rows from two tables
select s.station_id, s.state, s.station_name from qhan.stations s
where s.state like 'PA%'
union
select s.station_id, s.state, s.station_name from qhan.stations s
where s.state like 'NY%';

-- Find rain records that are in high mountain area of CA
select w.station_id, w.value_type, w.value from qhan.weather w
where w.value_type = 'RAIN' and w.station_id in (
	select s.station_id from qhan.stations s
	where s.elevation > 1000 and s.state = 'CA'
)

-- Get the current date
SELECT NOW()::date, NOW()::time, NOW()::timestamp;
-- Equivalent to the above
SELECT CURRENT_DATE, CURRENT_TIME, current_timestamp;

-- Output the date into a specified format
SELECT TO_CHAR(NOW() :: DATE, 'dd/mm/yyyy');
SELECT TO_CHAR(NOW() :: DATE, 'Mon dd, yyyy');

-- Ouput the interval between two dates
select w.station_id, w.date, NOW() - w.date as diff from qhan.weather w;
-- Equivalent to the above
select w.station_id, AGE(w.date) as diff from qhan.weather w;

-- Extract year, month and day from the date
select w.station_id, extract(year from w.date) as year, 
extract (month from w.date) as month, extract (day from w.date) as day
from qhan.weather w;
-- Equivalent to the above
select w.station_id, date_part('year', TIMESTAMP 'now()') as year,
date_part('month', TIMESTAMP 'now()') as month, 
date_part('day', TIMESTAMP 'now()') as day
from qhan.weather w;

-- Create views to store the query
create view weather_pa as
select s.station_id, s.station_name, w.value_type, w.value from qhan.stations s 
join qhan.weather w on  s.station_id = w.station_id
where s.state = 'PA';

select * from qhan.weather_pa;

-- create materialized views to store the query
create materialized view weather_pa_materailized as 
select s.station_id, s.station_name, w.value_type, w.value from qhan.stations s 
join qhan.weather w on  s.station_id = w.station_id
where s.state = 'PA'
with data;

explain select * from qhan.weather_pa;
explain select * from qhan.weather_pa_materailized;

-- Query plan example	
explain  select * from qhan.stations;
explain select * from qhan.stations s where s.state = 'PA'; 

-- Return the actual time 
explain analyze select * from qhan.stations;
explain analyze select * from qhan.stations s where s.state = 'PA'; 

-- Save the frequently used query in a materialized views
explain analyze select s.station_id, s.station_name, w.value_type, w.value 
from qhan.stations s 
join qhan.weather w on  s.station_id = w.station_id
where s.state = 'PA';

explain analyze select * from qhan.weather_pa_materailized;

-- Use index to eliminate sequential scan
explain analyze select * from qhan.weather w where w.value > 1000;

CREATE INDEX weather_value_idx ON qhan.weather (value) ;
explain analyze select * from qhan.weather w where w.value > 1000;

-- Use functions on index make the query slow again!
explain analyze select * from qhan.weather w where w.value/2 > 1000;

-- Avoid using % in the head of matched string can help improve the performance a bit
explain analyze select s.station_id, s.state, s.station_name from qhan.stations s
join qhan.weather w on  s.station_id = w.station_id 
where s.station_name like 'PITT%' ;

explain analyze select s.station_id, s.state, s.station_name from qhan.stations s
join qhan.weather w on  s.station_id = w.station_id 
where s.station_name like '%PITT%' ;

-- Using (not) exists instead (not) in at subquery
explain analyze select s.station_id, s.state, s.station_name from qhan.stations s
where s.station_id in (
	select w.station_id from qhan.weather w
	where w.value_type = 'RAIN'
);

explain analyze select s.station_id, s.state, s.station_name from qhan.stations s
where exists (
	select w.station_id from qhan.weather w
	where w.value_type = 'RAIN'
);

-- Use exists to perform boolean operations instead of full table join
explain analyze select s.station_id,  s.station_name from qhan.stations s 
left join qhan.weather w on  s.station_id = w.station_id;

explain analyze select s.station_id,s.station_name from qhan.stations s 
where exists (select w.station_id  from qhan.weather w
where s.station_id = w.station_id );
