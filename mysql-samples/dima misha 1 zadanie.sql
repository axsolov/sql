#Задание 1: Дима и Миша пользуются продуктами от одного и того же производителя.
#Тип Таниного принтера не такой, как у Вити, но признак "цветной или нет" - совпадает.
#Размер экрана Диминого ноутбука на 3 дюйма больше Олиного.
#Мишин ПК в 4 раза дороже Таниного принтера.
#Номера моделей Витиного принтера и Олиного ноутбука отличаются только третьим символом.
#У Костиного ПК скорость процессора, как у Мишиного ПК; объем жесткого диска, как у Диминого ноутбука; объем памяти, как у Олиного ноутбука, а цена - как у Витиного принтера.
#Вывести все возможные номера моделей Костиного ПК.

select model 
from pc where 
speed in 
	(select speed from pc where price in (select price*4 from printer)) 
and hd in 
	(select hd from laptop l where screen in (select screen + 3 from laptop)) 
and ram in 
	(select l.ram from laptop l, 
	(select p2.model from printer p1 join printer p2 on p1.type != p2.type and p1.color = p2.color
	where p1.price in (select price/4 from pc)) ss
	where screen not in (select screen + 3 from laptop) and 
	stuff(ss.model, 3, 1, '') = stuff(l.model, 3, 1, '')) 
and price in (select p2.price from printer p1
	join printer p2 on p1.type <> p2.type and p1.color = p2.color 
	where p1.price in (select price/4 from pc))
