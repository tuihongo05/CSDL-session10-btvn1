CREATE DATABASE session10_btvn1_InventoryManagement;
USE session10_btvn1_InventoryManagement;

CREATE TABLE products(
	productID INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE inventoryChanges(
	changeID INT AUTO_INCREMENT PRIMARY KEY,
    oldQuantity INT NOT NULL,
    newQuantity INT NOT NULL,
    changeDate DATETIME,
    productID INT,
    FOREIGN KEY(productID) REFERENCES products(productID)
);

DELIMITER $$
CREATE TRIGGER AfterProductUpdate
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
	IF oldQuantity <> newQuantity THEN
    INSERT INTO inventoryChanges(
		oldQuantity, 
        newQuantity,
        changeDate,
        productID
        )
	VALUES(
		OLD.quantity,
        NEW.quantity,
        NOW(),
        OLD.productID
        );
	END IF;
END $$
DELIMITER ;

SELECT * FROM inventoryChanges;
