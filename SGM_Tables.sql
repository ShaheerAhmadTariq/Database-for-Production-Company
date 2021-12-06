CREATE DATABASE SGM;
CREATE TABLE [Parties] (
  [PartiesID] int IDENTITY(1,1) PRIMARY KEY,
  [P_Name] varchar(255),
  [Address] varchar(255),
  [Phone] varchar(50),
  [Email] varchar(200),
  [Status] bit,
  [Group] varchar(150)
);
CREATE TABLE [AccountDetails] (
  [rowID] int PRIMARY KEY,
  [Acctype] varchar(10)
);
CREATE TABLE [AccountMain] (
  [AccID] int IDENTITY(1,1) PRIMARY KEY,
  [AccType] int,
  [PartiesID] int,
  [Details] varchar(255),
  [Amount] bigint,
  [CreditLimit] bigint,
  [CreatedBy] varchar(50),
  [CreationDate] datetime,
  [UpdatedBy] varchar(50),
  [UpdationDate] datetime,
  FOREIGN KEY (PartiesID) REFERENCES [Parties],
  FOREIGN KEY (AccType) REFERENCES [AccountDetails]
);
CREATE TABLE [Stock] (
  [itemID] int IDENTITY(1,1) PRIMARY KEY,
  [itemDetail] varchar(200),
  [Price] bigint,
  [Group] varchar(50),
  [ItemStatus] bit,
  [Quantity] int,
  [Packing] varchar(30),
  [UpdatedBy] varchar(50),
  [UpdatedDate] datetime
);

CREATE TABLE [Orders] (
  [OID] int IDENTITY(1,1) PRIMARY KEY,
  [PartiesID] int,
  [Status] bit,
  [CreatedBy] varchar(50),
  [CreationDate] datetime,
  [UpdatedBy] varchar(50),
  [UpdationDate] datetime,
   FOREIGN KEY (PartiesID) REFERENCES [Parties],
);
CREATE TABLE [Product] (
  [ProductID] int IDENTITY(1,1) PRIMARY KEY,
  [Description] varchar(255),
  [P_Price] bigint
);
CREATE TABLE OrderDetails (
  rowID int IDENTITY(1,1) PRIMARY KEY,
  OID int,
  ProductID int,
  Quantity int,
  FOREIGN KEY (OID) REFERENCES Orders,
  FOREIGN KEY (ProductID) REFERENCES Product,
);

CREATE TABLE [PurchaseHead] (
  [InvoiceNo] int IDENTITY(1,1) PRIMARY KEY,
  [AccID] int,
  [Reference] varchar(25),
  [P_Date] datetime,
  [TotalPrice] int,
  [CreatedBy] varchar(50),
  [CreatedDate] datetime,
  [UpdatedBy] varchar(50),
  [UpdatedDate] datetime,
  [OrderID] int,
   FOREIGN KEY (AccID) REFERENCES [AccountMain],
    FOREIGN KEY (OrderID) REFERENCES [Orders]
);
CREATE TABLE PurchaseDetail (
  PID int IDENTITY(1,1) PRIMARY KEY,
  InvoiceNo int,
  ItemID int,
  Rate bigint,
  Quantity int,
  FOREIGN KEY (InvoiceNo) REFERENCES PurchaseHead,
  FOREIGN KEY (ItemID) REFERENCES Stock
);




CREATE TABLE [R_PurchaseHead] (
  [InvoiceNo] int IDENTITY(1,1) PRIMARY KEY,
  [AccID] int,
  [Reference] varchar(25),
  [R_Date] datetime,
  [TotalPrice] int,
  [CreatedBy] varchar(50),
  [CreatedDate] datetime,
  [UpdatedBy] varchar(50),
  [UpdatedDate] datetime,
  [OrderID] int,
   FOREIGN KEY (AccID) REFERENCES [AccountMain],
    FOREIGN KEY (OrderID) REFERENCES [Orders],
 
);

CREATE TABLE [R_PurchaseDetail] (
  [PID] int IDENTITY(1,1) PRIMARY KEY,
  [InvoiceNo] int,
  [ItemID] int,
  [Rate] bigint,
  [Quantity] int,
   FOREIGN KEY (InvoiceNo) REFERENCES R_PurchaseHead,
    FOREIGN KEY (ItemID) REFERENCES [Stock]
);




CREATE TABLE [Cashpayment] (
  [VoucherNO] int PRIMARY KEY,
  [AccID] int,
  [Amount] bigint,
  [C_Date] datetime,
  [Reference] varchar(25),
  [CreatedBy] varchar(50),
  [CreatedDate] datetime,
  [UpdatedBy] varchar(50),
  [UdatedDate] datetime,
  [Details] varchar(255),
  FOREIGN KEY (AccID) REFERENCES [AccountMain]
);




CREATE TABLE [GatePassIn_Head] (
  [InvoiceNo] int IDENTITY(1,1) PRIMARY KEY,
  [PartiesID] int,
  [OrderID] int,
  [IN_Date] datetime,
  [Reference] varchar(25),
  [CreatedBy] varchar(50),
  [CreatedDate] datetime,
  [UpdatedBy] varchar(50),
  [UpdatedDate] datetime,
  [Remarks] varchar(255),
   FOREIGN KEY (PartiesID) REFERENCES [Parties],
    FOREIGN KEY (OrderID) REFERENCES [Orders]
);

CREATE TABLE [GatePassIn_Detail] (
  [InvoiceNo] int,
  [ItemID] int,
  [Quantity] int,
  [RowID] int IDENTITY(1,1) PRIMARY KEY,
   FOREIGN KEY (InvoiceNo) REFERENCES [GatePassIn_Head],
    FOREIGN KEY (ItemID) REFERENCES [Stock]
);

CREATE TABLE [Sales] (
  [InvoiceNO] int IDENTITY(1,1) PRIMARY KEY,
  [OID] int,
  [Reference] varchar(25),
  [S_date] datetime,
  [AccID] int,
  [Remarks] varchar(200),
  [CreatedBy] varchar(50),
  [CreationDate] datetime,
  [UpdatedBy] varchar(50),
  [UpdationDate] datetime,
   FOREIGN KEY (OID) REFERENCES [Orders],
    FOREIGN KEY (AccID) REFERENCES [AccountMain]
);

CREATE TABLE [GatePassOut_Head] (
  [InvoiceNo] int Identity(1,1) PRIMARY KEY,
  [AccID] int,
  [OrderID] int,
  [Reference] varchar(25),
  [OUT_Date] datetime,
  [AmountPaid] int,
  [CreatedBy] varchar(50),
  [CreatedDate] datetime,
  [UpdatedBy] varchar(50),
  [UpdatedDate] datetime,
  [Remarks] varchar(255),
   FOREIGN KEY (AccID) REFERENCES [AccountMain],
    FOREIGN KEY (OrderID) REFERENCES [Orders]

);
CREATE TABLE [GatePassOut_Detail] (
  [RowID] int IDENTITY(1,1) PRIMARY KEY,
  [InvoiceNo] int,
  [ItemID] int,
  [Quantity] int,
   FOREIGN KEY (InvoiceNo) REFERENCES [GatePassOut_Head],
    FOREIGN KEY (ItemID) REFERENCES [Stock]
);

CREATE TABLE [Company] (
  [CompanyName] varchar(150),
  [StartingYear] datetime,
  [Address] varchar(255),
  [PhoneNo] varchar(15)
);
CREATE TABLE [ExpenseLedger] (
  [EID] int IDENTITY(1,1) PRIMARY KEY,
  [ExpenseTitle] varchar(150),
  [Group] varchar(150),
  [PartiesID] int,
  [Description] varchar(255),
  [CreatedBy] varchar(50),
  [CreationDate] datetime,
  [UpdatedBy] varchar(50),
  [UpdationDate] datetime,
  [OrderID] int,
   FOREIGN KEY ([PartiesID]) REFERENCES [Parties],
    FOREIGN KEY (OrderID) REFERENCES [Orders]
);

ALTER TABLE [ExpenseLedger] 
ADD Amount bigint;
CREATE TABLE [Shipment] (
  [ShipID] int IDENTITY(1,1) PRIMARY KEY,
  [SaleID] int,
  [ExpenseID] int,
  [Ship_Date] datetime,
  [Status] bit,
  [CreatedBy] varchar(50),
  [CreationDate] datetime,
  [UpdatedBy] varchar(50),
  [UpdationDate] datetime,
  [OrderID] int,
   FOREIGN KEY ([SaleID]) REFERENCES [Sales],
    FOREIGN KEY ([ExpenseID]) REFERENCES [ExpenseLedger]
);

--CREATE INDEX [Fk] ON  [Shipment] ([ExpenseID], [OrderID]);





CREATE TABLE [Users] (
  [UserID] varchar(50) PRIMARY KEY,
  [Password] varchar(50),
  [UserStatus] bit,
  [CreatedBy] varchar(50),
  [CreatedDate] datetime,
  [UpdatedBy] varchar(50),
  [UpdatedDate] datetime,
 
);
CREATE TABLE UserLog (
  UserID varchar(50),
  loginDate datetime,
  logoutDate datetime,
  RowID int IDENTITY(1,1) PRIMARY KEY,
  FOREIGN KEY (UserID) REFERENCES Users,
);

CREATE TABLE [ProductDetails] (
  [ProductID] int,
  [ItemID] int,
  [quantity] int,
  [RowID] int IDENTITY(1,1) PRIMARY KEY,
   FOREIGN KEY (ProductID) REFERENCES [Product],
   FOREIGN KEY (ItemID) REFERENCES [Stock]
);
drop table ProductDetails


