CREATE TABLE [AccountMain_History] (
  [AccID] int,
  [AccType] int,
  [PartiesID] int,
  [Amount] bigint,
  [CreatedBy] varchar(50),
  [CreationDate] datetime,
  [Action] varchar(15)
);


CREATE TABLE [PurchaseHead_History] (
  [InvoiceNo] int,
  [AccID] int,
  [Reference] varchar(25),
  [P_Date] datetime,
  [TotalPrice] int,
  [OrderID] int,
  [Action] varchar(15)
);

CREATE TABLE PurchaseDetail_History (
  PID int,
  InvoiceNo int,
  ItemID int,
  Rate bigint,
  Quantity int,
  [Action] varchar(15)
);


CREATE TABLE [Cashpayment_History] (
  [VoucherNO] int,
  [AccID] int,
  [Amount] bigint,
  [C_Date] datetime,
  [Reference] varchar(25),
  [Action] varchar(15)
);


CREATE TABLE [Stock_History] (
  [itemID] int,
  [itemDetail] varchar(200),
  [Price] bigint,
  [Group] varchar(50),
  [Quantity] int,
  [Packing] varchar(30),
  [UpdatedBy] varchar(50),
  [UpdatedDate] datetime,
  [Action] varchar(15)
);


CREATE TABLE [Sales_History] (
  [InvoiceNO] int,
  [OID] int,
  [Reference] varchar(25),
  [S_date] datetime,
  [AccID] int,
  [Action] varchar(15)
);


					    
-------testing-------------
select * from Sales
select * from Sales_History

update Sales 
set Reference = '11-111-110'
where InvoiceNO = 2

select * from Orders
select * from AccountMain
select * from AccountMain_History

update Stock
set Quantity = 201
where itemID = 1



Update AccountMain 
set Amount = 2940002
where AccID = 1

DELETE from AccountMain 
where AccID = 10
select * from 	PurchaseHead
select * from PurchaseHead_History

Update PurchaseHead
set Reference = '1-11-1110'
where InvoiceNo = 2

select * from PurchaseDetail
select * from PurchaseDetail_History

delete PurchaseDetail 
where PID = 5

update PurchaseDetail
set Quantity= 130
where PID = 5

select * from Stock 
where itemID = 4


select * from Cashpayment
select * from Cashpayment_History

Update Cashpayment
set Amount = 21000
where VoucherNO = 1001

delete Cashpayment
where VoucherNO = 1002
