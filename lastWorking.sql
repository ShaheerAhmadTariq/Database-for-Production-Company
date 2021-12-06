


Select * from PurchaseHead
where InvoiceNo IN
(select InvoiceNo from PurchaseDetail
where ItemID = 4)







select Stock.itemDetail from Stock
where Stock.itemID in 








	(Select * from PurchaseDetail
		where InvoiceNo in
		(Select InvoiceNo from purchaseHead
			where AccID in
			(select AccID from AccountMain
				where  AccType = 1)))




select * from temp
where temp.ItemID = 25




select * from AccountDetails




select * from Sales

delete from Sales
where InvoiceNO = 3


select * from Cashpayment
select * from Orders

select * from PurchaseHead
where OrderID = 4

select * from parties


select * from AccountMain
where PartiesID = 1



select * from GatePassOut_Head
where GatePassOut_Head.

select * from GatePassOut_Detail

select * from AccountMain
where PartiesID = 67










EXEC BOM_Calculation 20
ALTER PROCEDURE BOM_Calculation 
		@orderID int
AS
   set nocount on
BEGIN
	 	Select * from [BOM]
			where [BOM].ProductID = (SELECT ProductID From OrderDetails
								WHERE OrderDetails.OID = @orderID)
       Select sum(Price*QP) as cost from BOM
	   where productID =
						(SELECT ProductID From OrderDetails
								WHERE OrderDetails.OID = @orderID)


Select * from [BOM]
			where [BOM].ProductID = (SELECT ProductID From OrderDetails
								WHERE OrderDetails.OID = 20)




select * from ProductDetails
where ProductID = 2




SELECT ProductDetails.ProductID,Stock.itemDetail,Stock.Price,Stock.Quantity,ProductDetails.quantity as QP
from ProductDetails
INNER JOIN OrderDetails
ON (OrderDetails.ProductID = ProductDetails.ProductID)
INNER JOIN Stock
ON (ProductDetails.ItemID = Stock.itemID)


Create PROCEDURE BOM_Calculation_01
		@orderID int
AS
   set nocount on
BEGIN
		Declare @pid int
		Declare @Pname varchar(255)
		set @pid = (SELECT ProductID from OrderDetails
						WHERE OID = @orderID)
		set @Pname = (Select [Description] from Product
							WHERE ProductID = @pid)
		
		

	 	Select * from [BOM]
			where [BOM].ProductID = (SELECT ProductID From OrderDetails
								WHERE OrderDetails.OID = @orderID)
       Select sum(Price*QP) as cost from BOM
	   where productID =
						(SELECT ProductID From OrderDetails
								WHERE OrderDetails.OID = @orderID)
END


select * from BOM
where ProductID =2

Select [Description] from Product
UnION
Select Ite from ProductDetails
