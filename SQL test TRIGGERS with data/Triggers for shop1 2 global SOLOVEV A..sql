DELIMITER $$
DROP TRIGGER IF EXISTS tr_global_price_delete;
CREATE TRIGGER tr_global_price_delete after DELETE
ON shopglobal FOR EACH ROW 
BEGIN
	CASE 
		WHEN 
			OLD.region = 'shop1' AND OLD.ShopID IN (Select shopid FROM shop1) 
		THEN
			DELETE FROM shop1 WHERE ShopID = OLD.ShopID; 
    	WHEN 
			OLD.region = 'shop2' AND OLD.ShopID IN (Select shopid FROM shop2) 
		THEN
			DELETE FROM shop2 WHERE ShopID = OLD.ShopID; 
        ELSE
        BEGIN
        END;
	END CASE;
END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS tr_global_price_insert;
CREATE TRIGGER tr_global_price_insert AFTER INSERT
ON shopglobal FOR EACH ROW 
BEGIN
	CASE 
		WHEN 
			NEW.Region = 'Shop1' AND NEW.ShopID NOT IN (SELECT ShopID FROM shop1) 
        THEN
			INSERT INTO shop1 (ShopID, GoodsID, Price, UpdateDateTime)
				VALUES (NEW.ShopID, NEW.GoodsID, NEW.Price, CURRENT_TIMESTAMP);
		WHEN 
			  NEW.Region = 'Shop2' AND NEW.ShopID NOT IN (SELECT ShopID FROM shop2)
		THEN
			INSERT INTO shop2 (ShopID, GoodsID, Price, UpdateDateTime)
				VALUES (NEW.ShopID, NEW.GoodsID, NEW.Price, CURRENT_TIMESTAMP);
	ELSE
		BEGIN
		END;
    END CASE;
END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS tr_global_price_update;
CREATE TRIGGER tr_global_price_update 
AFTER UPDATE
ON shopglobal 
FOR EACH ROW 
BEGIN
	CASE 
		WHEN 
			NEW.region = 'shop1' AND NEW.Price <> (SELECT Price FROM shop1 WHERE ShopID = NEW.ShopID)
		THEN
			UPDATE shop1 SET Price = NEW.Price, UpdateDateTime = CURRENT_TIMESTAMP WHERE ShopID = NEW.ShopID;
    	WHEN 
			NEW.region = 'shop2' AND NEW.Price <> (SELECT Price FROM shop2 WHERE ShopID = NEW.ShopID)
		THEN
		UPDATE shop2 SET Price = NEW.Price, UpdateDateTime = CURRENT_TIMESTAMP WHERE ShopID = NEW.ShopID;
        ELSE
			BEGIN
			END;
	END CASE;
END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS tr_shop1_price_delete;
CREATE  TRIGGER tr_shop1_price_delete 
AFTER DELETE ON shop1 
FOR EACH ROW 
BEGIN 
	CASE 
		WHEN 
			OLD.ShopID IN (SELECT ShopID
			FROM shopglobal
			WHERE ShopID)
		THEN
			DELETE FROM shopglobal WHERE ShopID IN (OLD.ShopID);
        ELSE
			BEGIN
			END;
END CASE;
END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS tr_shop1_price_insert;
CREATE  TRIGGER tr_shop1_price_insert 
AFTER INSERT ON shop1 
FOR EACH ROW 
BEGIN 
	CASE 
		WHEN 
			NEW.ShopID NOT IN (SELECT ShopID FROM shopglobal) 
		THEN
			INSERT INTO shopglobal values (NEW.ShopID, NEW.GoodsID, NEW.Price, CURRENT_TIMESTAMP, 'shop1');
	ELSE 
		BEGIN
		END;
	END CASE;
END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS tr_shop1_price_update;
CREATE TRIGGER tr_shop1_price_update 
AFTER UPDATE 
ON shop1 
FOR EACH ROW 
BEGIN 
	CASE 
		WHEN 
			NEW.ShopID IN (SELECT ShopID FROM shopglobal) AND NEW.Price <> (SELECT Price FROM shopglobal WHERE ShopID = NEW.ShopID)
		THEN
			UPDATE shopglobal SET Price = NEW.Price, UpdateDateTime = CURRENT_TIMESTAMP WHERE ShopID = NEW.ShopID;
		ELSE 
			BEGIN
			END;
	END CASE;
END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS tr_shop2_price_delete;
CREATE  TRIGGER tr_shop2_price_delete 
AFTER DELETE ON shop2 
FOR EACH ROW 
BEGIN 
	CASE 
		WHEN 
			OLD.ShopID IN (SELECT ShopID
			FROM shopglobal
			WHERE ShopID)
		THEN
			DELETE FROM shopglobal WHERE ShopID IN (OLD.ShopID);
        ELSE
			BEGIN
			END;
END CASE;
END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS tr_shop2_price_insert;
CREATE  TRIGGER tr_shop2_price_insert 
AFTER INSERT ON shop2 
FOR EACH ROW 
BEGIN 
	CASE 
		WHEN 
			NEW.ShopID NOT IN (SELECT ShopID FROM shopglobal) 
		THEN
			INSERT INTO shopglobal values (NEW.ShopID, NEW.GoodsID, NEW.Price, CURRENT_TIMESTAMP, 'shop2');
	ELSE 
		BEGIN
		END;
	END CASE;
END; $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS tr_shop2_price_update;
CREATE TRIGGER tr_shop2_price_update 
AFTER UPDATE 
ON shop2 
FOR EACH ROW 
BEGIN 
	CASE 
		WHEN 
			NEW.ShopID IN (SELECT ShopID FROM shopglobal) AND NEW.Price <> (SELECT Price FROM shopglobal WHERE ShopID = NEW.ShopID)
		THEN
			UPDATE shopglobal SET Price = NEW.Price, UpdateDateTime = CURRENT_TIMESTAMP WHERE ShopID = NEW.ShopID;
		ELSE 
			BEGIN
			END;
	END CASE;
END; $$
DELIMITER ;
