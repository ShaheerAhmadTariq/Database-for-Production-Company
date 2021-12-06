--Insert trigger used for Purcahse Details
ALTER TRIGGER tr_update_amount ON [PurchaseDetail]
AFTER INSERT
AS
BEGIN
	
	DECLARE @rate bigint
	DECLARE @quantity int
	SET @rate = (SELECT Rate from inserted)
	SET @quantity = (SELECT Quantity from inserted)
	DECLARE @AMOUNT bigint = @rate * @quantity
	Declare @InvoiceIDtemp int = (Select InvoiceNo from inserted)
	UPDATE [PurchaseHead]
	SET TotalPrice = TotalPrice + @AMOUNT
	Where PurchaseHead.InvoiceNo = (Select InvoiceNo from inserted)
	DECLARE @AccIDTemp int = (SELECT AccID from PurchaseHead
						WHERE PurchaseHead.InvoiceNo = @InvoiceIDtemp)

	UPDATE [AccountMain]
	SET AccountMain.Amount = AccountMain.Amount + @AMOUNT
	Where AccountMain.AccID = @AccIDTemp
END


--Insert Trigger used to update stock Quantity and Price after purchasing
ALTER TRIGGER tr_update_Stock ON [PurchaseDetail]
AFTER INSERT
AS
BEGIN
		DECLARE @quantity int
		DECLARE @rate bigint
		SET @quantity = (SELECT Quantity FROM inserted)
		SET @rate = (SELECT Rate from inserted)
		UPDATE [Stock]
		SET Quantity = Quantity + @quantity
		WHERE Stock.itemID = (SELECT ItemID FROM inserted)
		UPDATE [Stock]
		SET Price = @rate
		WHERE Stock.itemID = (SELECT ItemID FROM inserted)
END	

--Insert trigger on gatepassout_details
Create TRIGGER tr_UpdateStock ON GatePassOut_Detail
AFTER INSERT
AS
BEGIN
		DECLARE @quantity int
		SET @quantity = (SELECT Quantity FROM inserted)
		UPDATE [Stock]
		SET Quantity = Quantity - @quantity
		WHERE Stock.itemID = (SELECT ItemID FROM inserted)
END	

--Insert trigger on gatepassin_deatils 
Create TRIGGER tr_UpdateStock_GAtepassIN ON GatePassIn_Detail
AFTER INSERT
AS
BEGIN
		DECLARE @quantity int
		SET @quantity = (SELECT Quantity FROM inserted)
		UPDATE [Stock]
		SET Quantity = Quantity + @quantity
		WHERE Stock.itemID = (SELECT ItemID FROM inserted)
END	


--Insert trigger on Sales
--it updates stocks after sale
Create TRIGGER tr_UpdateStock_Sales ON [Sales]
AFTER INSERT
AS
BEGIN
		DECLARE @quantity int
		DECLARE @productid int
		DECLARE @itemid int
		SET @productid = (Select OrderDetails.ProductID from OrderDetails
						WHERE OrderDetails.OID = (SELECT OID from inserted))
		SET @itemid = (SELECT Stock.itemID from Stock
						WHERE Stock.itemDetail = (SELECT Product.Description from Product
													Where Product.ProductID = @productid))
		
		SET @quantity = (SELECT OrderDetails.Quantity FROM OrderDetails
						WHere OrderDetails.OID = (SELECT OID from inserted))
		UPDATE [Stock]
		SET Quantity = Quantity - @quantity
		WHERE Stock.itemID = @itemid
END	

---------------------------History triggers on AccountMain---------------------------------

ALTER TRIGGER tr_AccountMain_History_Update ON [AccountMain]
AFTER UPDATE
AS
BEGIN
	Declare @aid int
	declare @atyp int
	declare @pid int
	declare @amount bigint
	declare @cby varchar(50)
	declare @cdate datetime

	set @aid = (Select d.AccID from deleted d) 
	set @atyp = (Select d.AccType from deleted d) 
	set @pid = (Select d.PartiesID from deleted d) 
	set @amount = (Select d.Amount from deleted d) 
	set @cby = (Select d.CreatedBy from deleted d) 
	set @cdate = (Select d.CreationDate from deleted d) 

	insert into [AccountMain_History] (AccID ,AccType, PartiesID, Amount, CreatedBy, CreationDate, [Action]) 
	values (@aid, @atyp, @pid,@amount,@cby,@cdate, 'UPDATE');
END


ALTER TRIGGER tr_AccountMain_History_Delete ON [AccountMain]
AFTER DELETE
AS
BEGIN
	Declare @aid int
	declare @atyp int
	declare @pid int
	declare @amount bigint
	declare @cby varchar(50)
	declare @cdate datetime

	set @aid = (Select d.AccID from deleted d) 
	set @atyp = (Select d.AccType from deleted d) 
	set @pid = (Select d.PartiesID from deleted d) 
	set @amount = (Select d.Amount from deleted d) 
	set @cby = (Select d.CreatedBy from deleted d) 
	set @cdate = (Select d.CreationDate from deleted d) 

	insert into [AccountMain_History] (AccID ,AccType, PartiesID, Amount, CreatedBy, CreationDate, [Action]) 
	values (@aid, @atyp, @pid,@amount,@cby,@cdate, 'DELETE');
END


--------------------------History Triggers on PurchaseHead--------------------
CREATE TRIGGER tr_PurchaseHead_History_Update ON [PurchaseHead]
AFTER UPDATE
AS
BEGIN
	declare @ino int
	Declare @aid int
	declare @ref varchar(25)
	declare @cdate datetime
	declare @pri int
	declare @oid int
	


	set @ino = (Select d.InvoiceNo from deleted d) 
	set @aid = (Select d.AccID from deleted d) 
	set @ref = (Select d.Reference from deleted d) 
	set @cdate = (Select d.P_Date from deleted d) 
	set @pri = (Select d.TotalPrice from deleted d) 
	set @oid = (Select d.OrderID from deleted d) 

	insert into [PurchaseHead_History] (InvoiceNo,AccID, Reference, P_Date, TotalPrice, OrderID, [Action]) 
				values (@ino, @aid, @ref, @cdate, @pri, @oid, 'UPDATE');
END

CREATE TRIGGER tr_PurchaseHead_History_DELETE ON [PurchaseHead]
AFTER DELETE
AS
BEGIN
	declare @ino int
	Declare @aid int
	declare @ref varchar(25)
	declare @cdate datetime
	declare @pri int
	declare @oid int
	


	set @ino = (Select d.InvoiceNo from deleted d) 
	set @aid = (Select d.AccID from deleted d) 
	set @ref = (Select d.Reference from deleted d) 
	set @cdate = (Select d.P_Date from deleted d) 
	set @pri = (Select d.TotalPrice from deleted d) 
	set @oid = (Select d.OrderID from deleted d) 

	insert into [PurchaseHead_History] (InvoiceNo,AccID, Reference, P_Date, TotalPrice, OrderID, [Action]) 
				values (@ino, @aid, @ref, @cdate, @pri, @oid, 'DELETE');
END

----------------------------History triggers on Purchase details----------------------
CREATE TRIGGER tr_PurchaseDetail_History_Update ON PurchaseDetail
AFTER UPDATE
AS
BEGIN
	declare @pid int
	Declare @ino int
	declare @itemid int
	declare @rate bigint
	declare @qua int
	


	set @pid = (Select d.PID from deleted d) 
	set @ino = (Select d.InvoiceNo from deleted d) 
	set @itemid = (Select d.ItemID from deleted d) 
	set @rate = (Select d.Rate from deleted d) 
	set @qua = (Select d.Quantity from deleted d) 
	 

	insert into [PurchaseDetail_History] (PID, InvoiceNo, ItemID, Rate, Quantity, [Action]) 
						values (@pid, @ino, @itemid, @rate, @qua, 'UPDATE')
END

CREATE TRIGGER tr_PurchaseDetail_History_DELETE ON PurchaseDetail
AFTER DELETE
AS
BEGIN
	declare @pid int
	Declare @ino int
	declare @itemid int
	declare @rate bigint
	declare @qua int
	


	set @pid = (Select d.PID from deleted d) 
	set @ino = (Select d.InvoiceNo from deleted d) 
	set @itemid = (Select d.ItemID from deleted d) 
	set @rate = (Select d.Rate from deleted d) 
	set @qua = (Select d.Quantity from deleted d) 
	 

	insert into [PurchaseDetail_History] (PID, InvoiceNo, ItemID, Rate, Quantity, [Action]) 
						values (@pid, @ino, @itemid, @rate, @qua, 'DELETE')
END

---------------------------History trigger on Cash payment---------------------
CREATE TRIGGER tr_CashPayment_History_Update ON [Cashpayment]
AFTER UPDATE
AS
BEGIN
	declare @vno int
	Declare @aid int
	declare @amo bigint
	declare @date datetime
	declare @ref varchar(25)
	


	set @vno = (Select d.VoucherNO from deleted d) 
	set @aid = (Select d.AccID from deleted d) 
	set @amo = (Select d.Amount from deleted d) 
	set @date = (Select d.C_Date from deleted d) 
	set @ref = (Select d.Reference from deleted d) 
	 

	insert into [Cashpayment_History] (VoucherNO, AccID, Amount, C_Date, Reference, [Action]) 
						values (@vno, @aid, @amo, @date, @ref, 'UPDATE');
END

CREATE TRIGGER tr_CashPayment_History_DELETE ON [Cashpayment]
AFTER DELETE
AS
BEGIN
	declare @vno int
	Declare @aid int
	declare @amo bigint
	declare @date datetime
	declare @ref varchar(25)
	


	set @vno = (Select d.VoucherNO from deleted d) 
	set @aid = (Select d.AccID from deleted d) 
	set @amo = (Select d.Amount from deleted d) 
	set @date = (Select d.C_Date from deleted d) 
	set @ref = (Select d.Reference from deleted d) 
	 

	insert into [Cashpayment_History] (VoucherNO, AccID, Amount, C_Date, Reference, [Action]) 
						values (@vno, @aid, @amo, @date, @ref, 'DELETE');
END


----------------------History triggers on Stock-------------------------------
CREATE TRIGGER tr_Stock_History_Update ON [Stock]
AFTER UPDATE
AS
BEGIN
	Declare @id int
	declare @idetail varchar(200)
	declare @p bigint
	declare @group varchar(50)
	declare @q int
	declare @pack varchar(30)
	declare @by varchar(50)
	declare @date datetime
	set @id = (Select d.itemID from deleted d) 
	set @idetail = (Select d.itemDetail from deleted d) 
	set @p = (Select d.Price from deleted d) 
	set @group = (Select d.[Group] from deleted d) 
	set @q = (Select d.Quantity from deleted d) 
	set @pack = (Select d.Packing from deleted d) 
	set @by = (Select d.UpdatedBy from deleted d) 
	set @date = (Select d.UpdatedDate from deleted d) 

	insert into [Stock_History] ([itemID], [itemDetail], [Price], [Group], [Quantity], [Packing], [UpdatedBy], [UpdatedDate], [Action])
					values (@id, @idetail, @p, @group, @q, @pack, @by, @date, 'UPDATE');
END

CREATE TRIGGER tr_Stock_History_DELETE ON [Stock]
AFTER DELETE
AS
BEGIN
	Declare @id int
	declare @idetail varchar(200)
	declare @p bigint
	declare @group varchar(50)
	declare @q int
	declare @pack varchar(30)
	declare @by varchar(50)
	declare @date datetime
	set @id = (Select d.itemID from deleted d) 
	set @idetail = (Select d.itemDetail from deleted d) 
	set @p = (Select d.Price from deleted d) 
	set @group = (Select d.[Group] from deleted d) 
	set @q = (Select d.Quantity from deleted d) 
	set @pack = (Select d.Packing from deleted d) 
	set @by = (Select d.UpdatedBy from deleted d) 
	set @date = (Select d.UpdatedDate from deleted d) 

	insert into [Stock_History] ([itemID], [itemDetail], [Price], [Group], [Quantity], [Packing], [UpdatedBy], [UpdatedDate], [Action])
					values (@id, @idetail, @p, @group, @q, @pack, @by, @date, 'DELETE');
END


--------------------------History triggers on Sales-----------------------
CREATE TRIGGER tr_Sales_History_Update ON [Sales]
AFTER UPDATE
AS
BEGIN
	Declare @ino int
	declare @oid int
	declare @ref varchar(25)
    declare @date varchar(50)
	declare @aid int
	
	set @ino = (Select d.InvoiceNO from deleted d) 
	set @oid = (Select d.OID from deleted d) 
	set @ref = (Select d.Reference from deleted d) 
	set @date = (Select d.S_date from deleted d) 
	set @aid = (Select d.AccID from deleted d) 
	

	insert into [Sales_History] ([InvoiceNO] ,OID, Reference, S_date, AccID, [Action]) 
				values (@ino, @oid, @ref, @date, @aid, 'UPDATE');
END

CREATE TRIGGER tr_Sales_History_DELETE ON [Sales]
AFTER DELETE
AS
BEGIN
	Declare @ino int
	declare @oid int
	declare @ref varchar(25)
    declare @date varchar(50)
	declare @aid int
	
	set @ino = (Select d.InvoiceNO from deleted d) 
	set @oid = (Select d.OID from deleted d) 
	set @ref = (Select d.Reference from deleted d) 
	set @date = (Select d.S_date from deleted d) 
	set @aid = (Select d.AccID from deleted d) 
	

	insert into [Sales_History] ([InvoiceNO] ,OID, Reference, S_date, AccID, [Action]) 
				values (@ino, @oid, @ref, @date, @aid, 'DELETE');
END
------------------------Sales Trigger on Sales---------------
CREATE TRIGGER tr_Update_Status_After_Sales ON [Sales]
AFTER INSERT
AS
BEGIN
	
	declare @oid int
	set @oid = (Select i.OID from inserted i) 

	update Orders 
	set [Status] = 0
	where OID = @oid
END