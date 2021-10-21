#для каждого тайтла книги вывести трех пользователей 
#с минимальным временем между первым и последним прослушиваниями книги. 
#удалять тестовые чтения нужно. Отсортировать по книге и разнице времени

CREATE view filtered_listenings as
select * from listenings where user_id in 
	(
	select user_id from 
		(
		SELECT *, sum(seconds) as sum FROM 
			(
			SELECT *, 
					timestampdiff(second, started_at, finished_at)*speed_multiplier as seconds
			FROM listenings
			where is_test <> 1 
			) aa
		join audiobooks ab2 on audiobook_uuid = ab2.uuid
		group by user_id, audiobook_uuid
		) ba
	where sum>=ba.duration*0.3
	); 
                
select * from (
select *, RANK() OVER (PARTITION BY title ORDER BY c.seconds) AS rnk 
from 
	(
	select title, a.user_id, a.started_at, b.started_at as started_at_last_time, 
	timestampdiff(second, a.started_at, b.started_at)*a.speed_multiplier as seconds
		from
			(SELECT audiobook_uuid, started_at, user_id, speed_multiplier,
			row_number() over (partition by user_id, audiobook_uuid  order by started_at) as row_num
			FROM filtered_listenings
			where is_test <> 1
			) a
		join
			(SELECT audiobook_uuid, started_at, user_id, position_to, 
			row_number() over (partition by user_id, audiobook_uuid  order by started_at desc) as row_num
			FROM filtered_listenings
			where is_test <> 1
			) b
		on a.row_num=b.row_num and a.user_id = b.user_id and a.audiobook_uuid = b.audiobook_uuid
			left join audiobooks ab on uuid = b.audiobook_uuid
	where a.row_num = 1 and ab.duration<=b.position_to 
	order by title, seconds 
	) c
    where seconds <> 0
) d
Where rnk <=3;

DROP VIEW filtered_listenings;
