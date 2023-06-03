-- 1/ Get the Top 3 film that have the most customers book
select film.`name`, count(customer_id) as total_customer_book
from film 
join screening s on s.film_id = film.id
join booking b on s.id = b.screening_id
group by film.`name`
order by total_customer_book desc
limit 3;


-- 2/ Get all the films that longer than average length
Select * from film 
where length_min > (Select avg(length_min) from film);


-- 3/ Get the room which have the highest and lowest screenings IN 1 SQL query
SELECT room_id, COUNT(id) AS count_room
FROM screening AS s
GROUP BY room_id
HAVING count_room = (
	SELECT COUNT(id) AS count
	FROM screening AS s
	GROUP BY room_id
	ORDER BY count ASC
	LIMIT 1)
    OR count_room = (
	SELECT COUNT(id) AS count
	FROM screening AS s
	GROUP BY room_id
	ORDER BY count DESC
	LIMIT 1)
ORDER BY count_room;


-- 4/ Get number of booking customers of each room of film 'Tom&Jerry'.
Select r.`name`, f.`name`, count(b.customer_id) as customer_book
from room r 
join screening s on s.room_id = r.id
join booking b on s.id = b.screening_id
join film f on s.film_id = f.id
where f.`name` = 'Tom&Jerry'
group by r.`name`;


-- 5/ What seat is being book the most
select s.*, COUNT(*) AS seat_most_book
from reserved_seat AS r
join seat AS s ON r.seat_id = s.id
group by s.id
having seat_most_book = (
	select COUNT(*) as seat_most_book
	from reserved_seat as r
	join seat as s on r.seat_id = s.id
	group by s.id
	order by seat_most_book desc
	limit 1)
;


-- 6/ What film have the most screens in 2022?
Select f.`name`, count(s.film_id) as most_screening
from film f 
join screening s on f.id = s.film_id
group by f.`name`
having most_screening = (Select count(s.film_id) as most_screening
from film f 
join screening s on f.id = s.film_id
where year(start_time) = 2022
group by f.`name`
order by most_screening DESC
LIMIT 1);


-- 7/ Which day has the most screen?
select day(start_time) as day, count(*) most_screen
from screening
group by start_time
having most_screen = ( select count(*) most_screen
from screening
group by start_time
order by most_screen DESC
LIMIT 1);

-- 8/ Show film on 2022-May
Select distinct film.`name` from film
join screening on film.id = screening.film_id
where screening.start_time like '%2022-05%';

-- 9/ Select film end with character "n"
Select `name` from film where right(`name`, 1) = 'n';

-- 10/ Show customer name but just show first 3 characters and last 3 chartacters in UPPERCASE
Select upper(concat(left(first_name, 3), right(last_name, 3))) AS concat_name
from customer;


-- 11/ What film longer than hours?
select `name`, length_min 
from film 
where length_min >= 120;



