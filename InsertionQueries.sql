--to place new order
--partiesID 32-61 
--ProductID 59-69
EXEC CreateNewOrder @PartiesID = 32,@ProductID = 1, @quantity = 6;
EXEC CreateNewOrder @PartiesID = 33,@ProductID = 2, @quantity = 2;
EXEC CreateNewOrder @PartiesID = 300,@ProductID = 2, @quantity = 2;
EXEC CreateNewOrder @PartiesID = 45,@ProductID = 7, @quantity = 200;
--EXEC CreateNewOrder @PartiesID = 34,@ProductID = 11, @quantity = 2;

--For Purchase Invoice
--partiesID 1-31
--account type would always be 1 which is Purchase
EXEC PPURCHASE_INVOICE @PartiesID = 1,@Details = 'MadeByShaheer',@Reference ='1-11-1111',@OrderID = 1;


--For Purchase DEtails

EXEC Purchase_Details_input @InvoiceNo = 2, @ItemID = 4, @Rate = 8000, @Quantity = 120;
EXEC Purchase_Details_input @InvoiceNo = 1, @ItemID = 5, @Rate = 6000, @Quantity = 10;

--For BOM
EXEC BOM_Calculation 3


--For Gatepass Out 
EXEC GATEPassOUT_Proc @PartiesID = 65,@Details = 'MadeByShaheer',@Reference ='1-11-1111',@AmountPaid = 70000,@OrderID = 1,@Remarks = 'MadeBySahaheer';



---For gate pass out details

EXEC GatePassOUT_Details  @InvoiceNo = 1, @ItemID = 3, @Quantity = 10;

--For gate pass in head details
EXEC GATEPassIN_Head_proc  @PartiesID = 65,@Details = 'MadeByShaheer',@Reference ='1-11-1111',@OrderID = 1,@Remarks = 'MadeBySahaheer';

--For gate pass in deatils
EXEC  GatePassIn_Details @InvoiceNo = 1, @ItemID = 65, @Quantity = 50;

--For cash Payment
EXEC CashPayment_Invoice @voucherID = 1001 ,@PartiesID = 43, @Amount = 20000, @Reference ='deleteme',@details = 'MadeByShaheer';
EXEC CashPayment_Invoice @voucherID = 1002 ,@PartiesID = 30, @Amount = 19000, @Reference ='deleteme',@details = 'MadeByShaheer';


--For SalesInvoice
--Includes Sales, ExpenseLedger, shipment, accountMain
EXEC SALES_Invoice @Details = 'ByShaheer', @Reference = '11-111-11', @OrderID = 20,@Remarks = 'ByShaheer', @amount = 4000000, @Description = 'MadeByShaheer', @shipAmount = 90000;
EXEC SALES_Invoice @Details = 'ByShaheer', @Reference = '22-33-43', @OrderID = 20,@Remarks = 'ByShaheer', @amount = 4000000, @Description = 'MadeByShaheer', @shipAmount = 90000;
select * from sales

--for Profit caluculations of an order
EXEC ProfitCalculations @Orderid = 4

--For purchase Report Supplier Wise
EXEC PurchaseReportSupplierWise @partyid = 2