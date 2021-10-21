with 
a as #Подготовка данных
	(SELECT customer_id, 
			sum(transactions_sum) as trans_value, #Расчет общей суммы транзакций по клиенту
			count(distinct transactions_id) as count_t, #Кол-во транзакций по клиенту
			max_trans,
			last_trans
	from 
		(  
		select 	*, 
			max(transactions_dttm) over (partition by customer_id) as last_trans, #Расчет последней даты транзакции по клиенту
			max(transactions_sum) over (partition by customer_id) as max_trans #Расчет макс суммы транзакций по клиенту
		FROM transactions
		) a2
	group by customer_id),
    
b as 
	(select row_number() over (order by customer_id) as id, 
			customer_id, trans_value, count_t, max_trans, last_trans, 
			#Далее деление на 5 уровней по дате, колву, макс сумме транзакции
			NTILE(5) OVER (ORDER BY last_trans) as R_S,
			NTILE(5) OVER (ORDER BY count_t) as F_S,
			NTILE(5) OVER (ORDER BY max_trans) as M_S
	from a
	order by id),
    
c as 
	(select *, 
			R_S*100+F_S*10+M_S as RFM
			/* эта формула может быть определена в зависимости от компании и ситуации, 
			если есть бизнес-сценарий с небольшим объемом и высокой ценой, ее можно изменить 
			на RFM = R*100 + 10*M + F */
	from b)
    
#RFM-Модель 
select 	*,
#Разбивка клиентов на 8 уровней
		case 
        when NTILE(8) OVER (ORDER BY RFM) = 1 then 'Sleep'
        when NTILE(8) OVER (ORDER BY RFM) = 2 then 'At Risk'
        when NTILE(8) OVER (ORDER BY RFM) = 3 then 'Cant lose them'
        when NTILE(8) OVER (ORDER BY RFM) = 4 then 'Need Attention'
        when NTILE(8) OVER (ORDER BY RFM) = 5 then 'New Customer'
        when NTILE(8) OVER (ORDER BY RFM) = 6 then 'Potential loyal list'
        when NTILE(8) OVER (ORDER BY RFM) = 7 then 'Loyal Customer'
        else 'Champion'
        end as RANKs
from c;
