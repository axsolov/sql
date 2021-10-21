#Тест 3.1 Составить запрос, результатом которого будут задачи, 
#требующие распределения в формате [{"key":"id-1", "assignee":"assignee1"}, ...].
SELECT  JSON_ARRAYAGG(JSON_OBJECT('Key', key_id, 'assignee', assignee)) as json
FROM st_tasks; 
#Тест 3.2 Составить запрос, результатом которого будет количество задач для каждого исполнителя 
#в формате [{"assignee": "assignee1", "needTasks":5}, ...].
SELECT 
CONCAT(
	   '[',
GROUP_CONCAT(
		   CONCAT(
			   '{"assignee":"', assignee, '"', 
			   ',"needTasks":"', tasks, '"}'
				)
			),
	   ']'
    ) as json
FROM 	
	(SELECT *, 
	count(key_id) as tasks 
	FROM st_tasks 
    where status REGEXP 'Open|On support side|Verifying'
	group by assignee
	) a; 
#Тест 3 Общее решение
#Вывод количества уникальных исполнителей и ввод в переменную @cnt
select count(distinct assignee) as cnt into @cnt 
		FROM st_tasks 
		where status REGEXP 'Open|On support side|Verifying'; #Фильтр и вывод только активных тасков
#Добавление в таблицу доп данные статуса: 
#(которые находятся дольше $days дней в статусах 'Open', 'On support side', 'Verifying', кол-во тасков)
insert into st_tasks2 (key_id, assignee, status, updated, created) #Ввод измененных данных во временую таблицу 
with a as 
	(SELECT *, 
			case when datediff(updated,created)>7 then 1 else 0 end as late,
			count(key_id) over (partition by assignee) as tasks #Общее Колво тасков у каждого исполнителя
	FROM st_tasks where status REGEXP 'Open|On support side|Verifying'), #Фильтр и вывод только активных тасков
#Вывод общего количества тасков и ввод в переменную @cntt
a2 as (select count(distinct key_id) into @cntt from a),
#Расчет ср знач тасков на 1 исплнителя, цикл для каждой строки колво тасков у исполнителя к среднему значению и вывод статуса
b as (
select *, @cntt/@cnt as avg, 
		case when tasks>(@cntt/@cnt) then 1 else 0 end as overw
from a),
#Селф джоин, замена ID 2-й табл из 1-й, оставить апдейт и дату создания таска из 1-й табл
c as (
select key_id, assignee, status, updated, created from (
select	b1.key_id, b2.assignee, b1.status, b1.updated, b1.created, 
		b2.late, b2.tasks, b2.avg, b2.overw, 
		row_number () over (partition by assignee) as vars #Варианты замены загруженных тасков более свободными исполнителями 
from b b1
join b b2 on b1.assignee != b2.assignee and b1.late = 1 
and b1.overw = 1 and b2.overw = 0 and b2.late = 0
group by b1.key_id, b2.assignee
order by tasks limit 1)d)

select key_id, assignee, status, updated, created from c;

#Замена первичных данных для дальнейшего перераспределения 
update st_tasks 
set assignee = (select assignee from st_tasks2 order by upd desc limit 1), 
status = (select status from st_tasks2 order by upd desc limit 1), 
updated = (select updated from st_tasks2 order by upd desc limit 1), 
created = (select created from st_tasks2 order by upd desc limit 1)
where key_id = (SELECT key_id FROM st_tasks2 order by upd desc limit 1);

#Вывод распределенных тасков через JSON
SELECT  JSON_ARRAYAGG(JSON_OBJECT('Key', key_id, 'assignee', assignee)) as json
from 
(SELECT * FROM yandex.st_tasks) js
