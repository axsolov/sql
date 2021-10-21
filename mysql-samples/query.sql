#1. Таблица имеет поля:
#1. Уникальный ID - UniqMainID
#2. UserID
#3. FIO
#Задача - написать SQL запрос, который:
#а. Удалит все дубликаты по связкам UserID+FIO
#б. Удалит все дубликаты по полю FIO
#Все запросы написаны на MySQL 8.0.23
#а)
DELETE FROM test 
WHERE UniqMainID IN  
	(SELECT UniqMainID FROM    
		(SELECT UniqMainID,
		ROW_NUMBER() OVER (PARTITION BY UserID, FIO ORDER BY UniqMainID) AS row_num      
		FROM test) a  
	WHERE row_num > 1);

#б.1) Удаляет все более ранние строки (t1.UniqMainID) если есть совпадения по FIO, внезависимо от UserID. 

DELETE t1 FROM test AS t1
INNER JOIN test AS t2 
WHERE t1.UniqMainID < t2.UniqMainID 
AND t1.FIO = t2.FIO;

#б.2)  Оставляет все более ранние строки (SET t1.FIO = NULL) заменяя совпавдения значением NULL

UPDATE test AS t1 
INNER JOIN test AS t2 ON 
	t1.FIO = t2.FIO AND t1.UniqMainID < t2.UniqMainID 
	SET t1.FIO = NULL;
