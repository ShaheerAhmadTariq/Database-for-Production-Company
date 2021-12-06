---------------------------------New Order-----------------------------------

Alter Procedure CreateNewOrder @PartiesID int, @ProductID int, @Quantity int
AS
Begin	
 set nocount on
		
		IF EXISTS( SELECT PartiesID
			FROM Parties 
			Where @PartiesID = Parties.PartiesID)
		Begin
			IF EXISTS ( SELECT ProductID 
				FROM Product
				Where @ProductID = Product.ProductID)
			Begin
			insert into [Orders] (PartiesID, Status, CreatedBy, CreationDate, UpdatedBy, UpdationDate) values (@PartiesID, 1, 'ADMIN', GETDATE(), 'ADMIN', GETDATE());
			declare @orderID int = @@Identity
			insert into [OrderDetails] (OID, ProductID, Quantity, Discount) values (@orderID, @ProductID, @Quantity, 0);
			END
			
		END
		DECLARE @print varchar(100)
			SET @print = 'Error PartiesID Not Found'
			PRINT(@print)
END



--------------------------------purchase Details--------------------------
ALTER PROCEDURE Purchase_Details_input 
	@InvoiceNO int,
	@ItemID int,
	@Rate bigint,
	@Quantity int
AS
BEGIN
	Set nocount on

	IF EXISTS( SELECT Stock.itemID
			FROM Stock
			WHERE @ItemID = Stock.itemID)
	BEGIN
			insert into [PurchaseDetail] (InvoiceNo, ItemID, Rate, Quantity) values (@InvoiceNO, @ItemID, @Rate, @Quantity)
	END
	DECLARE @print varchar(100)
			SET @print = 'Error Stock.ItemID Not Found'
			PRINT(@print)
END

-------------------------------Purchase Invoice--------------------------------
ALTER PROCEDURE PPURCHASE_INVOICE 
	@PartiesID int,
	@Details varchar(255),
	@Reference varchar(25),
	@OrderID int

AS
Begin	
 set nocount on
		
		IF EXISTS( SELECT PartiesID
			FROM Parties 
			Where @PartiesID = Parties.PartiesID)
			BEGIN
				IF EXISTS( SELECT Orders.OID
					FROM Orders
					Where @OrderID = Orders.OID)
				BEGIN
						insert into [AccountMain] (AccType, PartiesID, Details, Amount, CreditLimit, CreatedBy, CreationDate, UpdatedBy, UpdationDate) values (1, @PartiesID, @Details, 0, 25000, 'ADMIN', GETDATE(), 'ADMIN', GETDATE());
						DECLARE @AccIDTemp int = @@Identity
					    insert into [PurchaseHead] (AccID, Reference, P_Date, TotalPrice, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, OrderID) values ( @AccIDTemp, @Reference, GETDATE(), 0, 'ADMIN', GETDATE(), 'ADMIN', GETDATE(), @OrderID);
						

					
				END
				DECLARE @print01 varchar(100)
			SET @print01 = 'Error OrderID Not Found'
			PRINT(@print01)
		END
		DECLARE @print varchar(100)
			SET @print = 'Error PartiesID Not Found'
			PRINT(@print)
END

-------------------------BOM (Bill Of Materials)------------------------------
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
END
-----------------------GatePassOut-------------------------------
ALTER PROCEDURE GATEPassOUT_Proc
	@PartiesID int,
	@Details varchar(255),
	@Reference varchar(25),
	@AmountPaid bigint,
	@OrderID int,
	@Remarks varchar(255)

AS
Begin	
 set nocount on
		
		IF EXISTS( SELECT PartiesID
			FROM Parties 
			Where @PartiesID = Parties.PartiesID)
			BEGIN
				IF EXISTS( SELECT Orders.OID
					FROM Orders
					Where @OrderID = Orders.OID)
				BEGIN
						insert into [AccountMain] (AccType, PartiesID, Details, Amount, CreditLimit, CreatedBy, CreationDate, UpdatedBy, UpdationDate) values (3, @PartiesID, @Details, @AmountPaid, 1000000, 'ADMIN', GETDATE(), 'ADMIN', GETDATE());
						DECLARE @AccIDTemp int = @@Identity
					    insert into [GatePassOut_Head] (AccID, OrderID, Reference, OUT_Date, AmountPaid, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, Remarks) values (@AccIDTemp, @OrderID, @Reference, GETDATE(),@AmountPaid, 'ADMIN', GETDATE(), 'ADMIN', GETDATE(), @Remarks);


					
				END
				DECLARE @print01 varchar(100)
				SET @print01 = 'Error OrderID Not Found'
				PRINT(@print01)
			END
			DECLARE @print varchar(100)
			SET @print = 'Error PartiesID Not Found'
			PRINT(@print)
END

----------------------------GatePassOUT Details----------------------------

ALTER PROCEDURE GatePassOUT_Details
	@InvoiceNO int,
	@ItemID int,
	@quantity int
AS
BEGIN
	Set nocount on

	IF EXISTS( SELECT Stock.itemID
			FROM Stock
			WHERE @ItemID = Stock.itemID)
	BEGIN
			insert into [GatePassOut_Detail] (InvoiceNo, ItemID, Quantity) values (@InvoiceNO, @ItemID, @quantity);
	END
	DECLARE @print01 varchar(100)
			SET @print01 = 'Error ItemID Not Found'
			PRINT(@print01)
END
--------------------------Gate Pass In Head------------------------------------
ALTER PROCEDURE GATEPassIN_Head_proc
	@PartiesID int,
	@Details varchar(255),
	@Reference varchar(25),
	@OrderID int,
	@Remarks varchar(255)

AS
Begin	
 set nocount on
		
		IF EXISTS( SELECT PartiesID
			FROM Parties 
			Where @PartiesID = Parties.PartiesID)
			BEGIN
				IF EXISTS( SELECT Orders.OID
					FROM Orders
					Where @OrderID = Orders.OID)
				BEGIN
						
					  insert into [GatePassIn_Head] (PartiesID, OrderID, IN_Date, Reference, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, Remarks)
									values (@PartiesID, @OrderID, GETDATE(), @Reference, 'ADMIN', GETDATE(), 'ADMIN', GETDATE(), @Remarks);  
	
				END
				DECLARE @print01 varchar(100)
				SET @print01 = 'Error OrderID Not Found'
				PRINT(@print01)
			END
			DECLARE @print varchar(100)
			SET @print = 'Error PartiesID Not Found'
			PRINT(@print)
END

-----------------------------Gate pass in details-------------------------
Alter PROCEDURE GatePassIn_Details
	@InvoiceNO int,
	@ItemID int,
	@quantity int
AS
BEGIN
	Set nocount on

	IF EXISTS( SELECT Stock.itemID
			FROM Stock
			WHERE @ItemID = Stock.itemID)
	BEGIN
			insert into [GatePassIn_Detail]  (InvoiceNo, ItemID, Quantity) values (@InvoiceNO, @ItemID, @quantity);
	END
	DECLARE @print varchar(100)
			SET @print = 'Error Stock.ItemID Not Found'
			PRINT(@print)
END

-------------------------------Cash Payment-----------------------------
ALTER PROCEDURE CashPayment_Invoice
	@voucherID int,
	@PartiesID int,
	@Amount bigint,
	@Reference varchar(25),
	@details varchar(255)

AS
Begin	
 set nocount on
		
		IF EXISTS( SELECT PartiesID
			FROM Parties 
			Where @PartiesID = Parties.PartiesID)
			BEGIN
				IF NOT EXISTS( SELECT VoucherNO from Cashpayment
								WHERE Cashpayment.VoucherNO = @voucherID)
				BEGIN
						insert into [AccountMain] (AccType, PartiesID, Details, Amount, CreditLimit, CreatedBy, CreationDate, UpdatedBy, UpdationDate) values (4, @PartiesID, @Details, @Amount, 25000, 'ADMIN', GETDATE(), 'ADMIN', GETDATE());
						DECLARE @AccIDTemp int = @@Identity
					    insert into [Cashpayment] (VoucherNO, AccID, Amount, C_Date, Reference, CreatedBy, CreatedDate, UpdatedBy, UdatedDate, Details) 
						values (@voucherID, @AccIDTemp, @Amount, GETDATE(), @Reference, 'ADMIN', GETDATE(), 'ADMIN', GETDATE(), @details);
				END
				DECLARE @print varchar(100)
				SET @print = 'Error VoucherNo Already Exixts'
				PRINT(@print)
		END
		DECLARE @print01 varchar(100)
			SET @print01 = 'Error PartiesID Not Found'
			PRINT(@print01)
END

---------------------------------Sales Invoice--------------------------------

ALTER PROCEDURE SALES_Invoice
	@Details varchar(255),
	@Reference varchar(25),
	@OrderID int,
	@Remarks varchar(200),
	@amount bigint,
	@Description varchar(255),
	@shipAmount bigint
AS
Begin	
 set nocount on 
		
		Declare @PartiesID int
		set @PartiesID = (SELECT PartiesID FROM Orders
							WHERE OID = @OrderID)
		Declare @status int = 1
		IF EXISTS( SELECT PartiesID
			FROM Parties 
			Where @PartiesID = Parties.PartiesID)
			BEGIN
				IF EXISTS( SELECT Orders.OID
					FROM Orders
					Where @OrderID = Orders.OID)
				BEGIN
					IF @status = (Select [Status] from Orders
									where @OrderID = Orders.OID)
					  BEGIN
						insert into [AccountMain] (AccType, PartiesID, Details, Amount, CreditLimit, CreatedBy, CreationDate, UpdatedBy, UpdationDate) values (2, @PartiesID, @Details, @amount, 0, 'ADMIN', GETDATE(), 'ADMIN', GETDATE());
						DECLARE @AccIDTemp int = @@Identity
					    insert into [Sales] (OID, Reference, S_date, AccID, Remarks, CreatedBy, CreationDate, UpdatedBy, UpdationDate) values (@OrderID, @Reference, GETDATE(), @AccIDTemp, @Remarks, 'ADMIN', GETDATE(), 'ADMIN', GETDATE());
						DECLARE @saleid int = @@Identity
						insert into [ExpenseLedger] (ExpenseTitle, [Group], PartiesID, Amount,Description, CreatedBy, CreationDate, UpdatedBy, UpdationDate, OrderID) values ('Shipment cost', 'Shipment cost', @PartiesID, @shipAmount, @Description, 'ADMIN', GETDATE(), 'ADMIN', GETDATE(), @OrderID);
						DECLARE @Eid int = @@Identity
						insert into [Shipment] (SaleID, ExpenseID, Ship_Date, Status, CreatedBy, CreationDate, UpdatedBy, UpdationDate, OrderID) values (@saleid, @Eid, GETDATE(), 1, 'ADMIN', GETDATE(), 'ADMIN', GETDATE(), @OrderID);
					  END
				END
	END
END

		DECLARE @var2 bigint
		DECLARE @var3 bigint
		DECLARE @var4 bigint
		DECLARE @profit bigint
		
	SET @var1 = (SELECT Amount from AccountMain where 
				AccID = 
					(SELECT PurchaseHead.AccID from PurchaseHead
								Where PurchaseHead.OrderID = @Orderid)) 
	SET @var2 = (SELECT AmountPaid from GatePassOut_Head
					Where OrderID = @Orderid)		
	SET @var3 = (SELECT Amount from AccountMain 
					Where AccID = 
						(SELECT AccID from Sales
							Where Sales.OID = @Orderid))
	SET @profit = @var3 - (@var1 + @var2) 
	DECLARE @print01 varchar(100)
	SET @print01 = 'Total Purchase Amount is: '
	PRINT(@print01)
	PRINT(@var1)
	DECLARE @print02 varchar(100)
	SET @print02 = 'Total Amount Paid to Vendors is: '
	PRINT(@print02)
	PRINT(@var2)
	DECLARE @print03 varchar(100)
	SET @print03 = 'Total Profit is: '
	PRINT(@print03)
	PRINT(@profit)
END



---Not used 
CREATE PROCEDURE BOM_Calculation 
		@orderID int
AS
   set nocount on
BEGIN
	 	Select * from [BOM]
			where [BOM].ProductID = (SELECT ProductID From OrderDetails
								WHERE OrderDetails.OID = @orderID)
       Select SUM(Price) as TotalCost from [BOM]
	   where [BOM].ProductID = (SELECT ProductID From OrderDetails
								WHERE OrderDetails.OID = @orderID)
END

--------------------------------------Purchase Report Supplier Wise--------
ALTER PROCEDURE PurchaseReportSupplierWise 
	@Partyid int
AS
BEGIN
	Set nocount on
	IF EXISTS(SELECT PartiesID FROM Parties 
					WHERE PartiesID = @Partyid)
	BEGIN
	Select PID from 
	(Select * from PurchaseDetail
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

---------------------------------Profit Clculations----------------------
USE [SGM]
GO
/****** Object:  StoredProcedure [dbo].[ProfitCalculations]    Script Date: 6/25/2021 9:44:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[ProfitCalculations]
		@Orderid int
AS
Begin	
 set nocount on
		DECLARE @var1 bigint
		DECLARE @var2 bigint
		DECLARE @var3 bigint
		DECLARE @var4 bigint
		DECLARE @profit bigint
		
	SET @var1 = (SELECT Amount from AccountMain where 
				AccID = 
					(SELECT PurchaseHead.AccID from PurchaseHead
								Where PurchaseHead.OrderID = @Orderid)) 
	SET @var2 = (SELECT AmountPaid from GatePassOut_Head
					Where OrderID = @Orderid)		
	SET @var3 = (SELECT Amount from AccountMain 
					Where AccID = 
						(SELECT AccID from Sales
							Where Sales.OID = @Orderid))
	SET @profit = @var3 - (@var1 + @var2) 
	DECLARE @print01 varchar(100)
	SET @print01 = 'Total Purchase Amount is: '
	PRINT(@print01)
	PRINT(@var1)
	DECLARE @print02 varchar(100)
	SET @print02 = 'Total Amount Paid to Vendors is: '
	PRINT(@print02)
	PRINT(@var2)
	DECLARE @print04 varchar(100)
	SET @Print04 = 'Total Sales Amount: '
	PRINT(@Print04)
	PRINT(@var3)
	DECLARE @print03 varchar(100)
	SET @print03 = 'Total Profit is: '
	PRINT(@print03)
	PRINT(@profit)
END 