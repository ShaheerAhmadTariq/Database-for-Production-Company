------------------------Bill Of Materials---------------------------
ALTER VIEW [BOM] AS
SELECT ProductDetails.ProductID,Stock.itemDetail,Stock.Price,Stock.Quantity,ProductDetails.quantity as QP
from ProductDetails
INNER JOIN OrderDetails
ON (OrderDetails.ProductID = ProductDetails.ProductID)
INNER JOIN Stock
ON (ProductDetails.ItemID = Stock.itemID)






-------------------------Not used Garbage-----------------------
ALTER VIEW [BOM] AS
SELECT ProductDetails.ProductID,Stock.itemDetail,Stock.Price  from ProductDetails
INNER JOIN OrderDetails
ON (OrderDetails.ProductID = ProductDetails.ProductID)
INNER JOIN Stock
ON (ProductDetails.ItemID = Stock.itemID)






ALTER VIEW [BOM] AS
SELECT ProductDetails.ProductID,Stock.itemDetail,Stock.Price,Stock.Quantity,ProductDetails.quantity as QP
from ProductDetails
right JOIN OrderDetails
ON (OrderDetails.ProductID = ProductDetails.ProductID)
right JOIN Stock
ON (ProductDetails.ItemID = Stock.itemID)

select * from BOM


