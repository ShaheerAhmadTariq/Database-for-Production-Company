
--EXEC CreateNewOrder @PartiesID = 32,@ProductID = 1, @quantity = 6;


insert into [Orders] (PartiesID, Status, CreatedBy, CreationDate, UpdatedBy, UpdationDate) values (@PartiesID, 1, 'ADMIN', '6/4/2021', 'ADMIN', '2020-10-06 06:11:46');


insert into [AccountDetails] (rowID, AccType) values (4, 'CashPay');
select * from AccountDetails


select * from productDetails
select * from Orders
Select * from [OrderDetails]
select * from Product
select * from AccountDetails
select * from Parties
Select * from PurchaseHead
Select * from PurchaseDetail
Select * from AccountMain
select * from GatePassOut_Head
Select * from GatePassOut_Detail
select * from GatePassIn_Head
select * from GatePassIn_Detail
Select * from Stock
SELECT * from Cashpayment
SELECT * from Sales
SELECT * from Shipment
SELECT * from ExpenseLedger
truncate table GatePassIn_Detail

select * from AccountMain
select * from ExpenseLedger
select * from Sales
select * from Shipment


ALTER PROCEDURE SalesReportSupplierWise 
	@Partyid int
AS
BEGIN
	Set nocount on
	IF EXISTS(SELECT PartiesID FROM Parties 
					WHERE PartiesID = @Partyid)
	BEGIN
	Select InvoiceNo from 
	(Select * from Sales
		where InvoiceNo in
		(Select InvoiceNo from purchaseHead
			where AccID in
			(select AccID from AccountMain
				where (PartiesID = @Partyid) And
				(AccType = 1))))temp
		Select * from 
		(Select Stock.itemDetail, temp.Quantity, temp.Rate from temp,Stock
			where (Stock.itemID = temp.ItemID))temp2
			
		Select SUM(temp.Rate)AS GrandTotal from temp
			
 

	END
END

sp_help '[Parties]'
delete from GatePassIn_Head
DBCC CHECKIDENT (GatePassIn_Head, RESEED, 0) 
delete from PurchaseDetail
DBCC CHECKIDENT (PurchaseDetail, RESEED, 0)  
delete from PurchaseHead
DBCC CHECKIDENT (PurchaseHead, RESEED, 0)  
delete from Cashpayment
DBCC CHECKIDENT (Cashpayment, RESEED, 0)  

delete from GatePassOut_Head
DBCC CHECKIDENT (GatePassOut_Head, RESEED, 0)  

delete from Sales
DBCC CHECKIDENT (Sales, RESEED, 0)  

delete from sales
DBCC CHECKIDENT (sales, RESEED, 0)  
select * from parties
delete from AccountMain
where AccID = 8
truncate table Shipment
truncate table sales
DBCC CHECKIDENT (AccountMain, RESEED, 0)  
delete from [ExpenseLedger]
DBCC CHECKIDENT ([ExpenseLedger], RESEED, 0)  
truncate table [ExpenseLedger]
truncate table GatePassOut_Head
truncate table GatePassOut_Detail
truncate table Orders
truncate table PurchaseDetail
truncate table PurchaseHead
truncate table Cashpayment
truncate table AccountMain



insert into [GatePassOut_Head] (AccID, OrderID, Reference, OUT_Date, AmountPaid, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, Remarks) values (46, 73, 'A', '2021-02-20 01:17:28', 25, 'A', '2021-05-10 04:55:10', 'A', '2020-11-07 22:28:24', 'A');

select * from Stock
where Stock.itemID = 60
Update Stock
set Quantity = 0
where itemID = 60


insert into [Sales] (OID, Reference, S_date, AccID, Remarks, CreatedBy, CreationDate, UpdatedBy, UpdationDate) values (14, 'A', '2020-12-18 02:58:19', 79, 'A', 'A', '2020-09-17 06:57:43', 'A', '2020-10-31 13:52:34');



insert into [Shipment] (SaleID, ExpenseID, Ship_Date, Status, CreatedBy, CreationDate, UpdatedBy, UpdationDate, OrderID) values (55, 73, '2021-03-17 06:53:40', 1, 'ADMIN', '2021-01-31 20:16:32', 'ADMIN', '2021-02-22 21:08:57', 78);
insert into [ExpenseLedger] (ExpenseTitle, [Group], PartiesID, Amount,Description, CreatedBy, CreationDate, UpdatedBy, UpdationDate, OrderID) values ('Shipment cost', 'Shipment cost', 15, 1400, 'A', 'ADMIN', '2021-05-31 06:11:32', 'ADMIN', '2020-07-04 12:58:58', 1);

select * from sales

EXEC ProfitCalculations @Orderid = 1


Declare @oid int = 1;
select * from AccountMain
select * from PurchaseHead
CREATE VIEW [PROFIT] AS









DECLARE @varText INT;
SET @varText = 10;
SELECT @varText as varText;
GO

Declare @VariableName VARCHAR(100)
SET @VariableName = 'This is an  example of Print functionality of SQL Server'
Print (@VariableName)



CREATE PROCEDURE BOM_Calculation 
		@orderID int
AS
   set nocount on
BEGIN
		DECLARE @Price bigint
	 	Select * from [BOM]
			where [BOM].ProductID = (SELECT ProductID From OrderDetails
								WHERE OrderDetails.OID = @orderID)
       SET @Price = (Select SUM(Price) as TotalCost from [BOM]
						where [BOM].ProductID = (SELECT ProductID From OrderDetails
													WHERE OrderDetails.OID = @orderID))
       
END


