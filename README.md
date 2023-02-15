# Database-for-Production-Company
This database is for textile production company. It can handle accounts and stock.
The Database name is SGM. 
The SGM_Tables.sql contains all the table of this database
the insertion in multiple tables is done through StoreProcedures.
# Included
I have written 17 triggers and 11 Stored procedures. Iam including sql files of those trigggers and stored procedures. 
## Proposal Document
SGM is a textile manufacturer and exporter which produces textile goods and export them. In this 
project I will try to build a sequel server database for manufacturing department. I will handle the 
transactions of raw material and products from different Vendors. I will maintain the stock of raw 
materials. I will handle the transaction which took place during purchasing, production and packing of 
products.
The company gets Order to produce specific amount of specific product by some other company. Each 
Product is made up of different Items. Each item is a part of an Item group e.g. one item use in canvas 
tent is black double 10/1 Yarn. Here yarn is a item group and black double 10/1 is an item of that group.
Yarn can also be Black triple 10/3.
The items needed in the production of the order are purchased from Supplier and stored in Stock. The 
record of this transaction is stored in Purchase Invoice. 
Once the items are purchased then the items are sent to Vendors. The gate pass(out) invoice is stored 
of this transaction. The vendor then produces cloth which are used as raw material for the production of 
the finished product (canvas tent). The cloth is sent back to us and gate pass(in) is also stored of this 
transaction. The important thing to note is the items are sent in oz unit and received in kg/pound/roll 
etc. so the stock is managed according to the units. 
Then the production contractor/ Vendor makes the finished product (canvas tent). The record of the 
items (cloth, rod, nawar) that are sent to Vendor and finished products received from Vendor is stored
in gate pass Invoice. 
Then a packing contractor/Vendor comes in play. The raw materials to pack the finished products and 
the tents are sent and record is stored also in gate pass invoice. Then the Packed Products are Exported 
through Shipment and the record of the Sale is saved.
The Stock is affected by purchase Invoice, gate pass Invoice (in/out). 
Each purchase invoice has a OrderID which you can say is a project id. That means each purchase should 
be done for some Order.

# Insertion, Updating and Deletion Anomalies
## Parties:
No insertion anomalies
No Updation anomalies
Delete will give error if parties id is being referred in AccountMain, PurchaseHead, GatePassOut_Head, GatePassIn_Head, Orders, ExpenseLedger
Because we have to delete every record of that parties id from each of the above tables Solution: 
I have put a status attribute in parties table, we can turn its value to 0 to indicate that we are no longer working with that party.

## Stock:
No insertion anomalies
No updation anomalies
Deletion will give error because itemid is being referred in other tables as foreign table. We cannot delete an item from stock which is stored in our Purchase Invoice, Sales Invoice, gate passes.
Solution: 
I have put a status attribute in Stock table, we can turn its value to 0 to indicate that we are no longer producing that item.

## Product:
No insertion anomalies
No updation anomalies
Delete will give error if it is being referred to orderDetails productid. 
We cannot delete a product which is being bought by a party.

## Product Details:
Insertion will give error if there is an item which is not present in our stock or product table. 
Updation will give error if there is an item which is not present in our stock or product table. 
No deletion anomalies

## Purchase Head: 
Insertion will give error if the partiesId is not present in parties table, as we cannot purchase item from an unknown party. 
If order id is invalid, as we always purchase stock items for some order.
Updating totalPrice we have to update the amount in the AccountMain table or the data will be inconsistent. 
 Deletion: If we want to delete a purchase, we have to delete the invoice no from the purchase details and accounts related to that purchase from AccountMain. 

## Purchase Details:
Insertion: the invoice no should be present in purchase head as we cannot enter purchase details without the invoice no from purchase head. The stock must be updated after the insertion. Also the amount in the 
No updation anomalies
Deletion: the stock which was updated in insertion must be deleted 

## Orders:
Insertion: the partiesID should be present in the parties table
No updation anomalies
Deletion: the order id is being referred to many tables and if we delete an order we have to delete the records from those tables as well.

## Orders Details:
Insertion: the product id should be present in the product table. 
No updation anomalies
No deletion anomalies

## Sales:
Insertion: we can only sell which has been ordered so the order id should be correct. The sales amount should be stored in the account main table. 
No updation anomalies.
The deleted sales record will should also be deleted from the shipment and account tables. 

## Expense:
No insertion anomalies
No updation anomalies
Deletion: it will give error if the deleted record is about shipment. We have to delete from the shipment table first.

## Cash Payment: 
No insertion anomalies, we just have to store the record in Account main table. 
No updation anomalies
Deletion: the record from Account Main should be deleted first.

## GatePassIn_Head:
No insertion anomalies, the order id should be present in Orders table.
No updation anomalies
Deletion: if the invoice no is being referred to gatepassin_detail than it will give error.

## GatePassIn_Details:
Insertion: the invoice No. should be correct; the stock should be updated.
Updation: the stock should be updated and the invoice No. must be checked. 
Deletion: the stock must be managed accordingly other than that no deletion anomalies.

## GatePassOut_Head:
No insertion anomalies, the parties ID and order id should be correct, the account main table should be maintained.
No updation anomalies, the Account Main table should also be updated
Deletion: if the invoice No. is being referred to gatepassOut_detail than it will give error.

## GatePassOut_Details:
Insertion: the invoice No. should be correct, the stock should be updated 
Updation: the stock should be updated and the invoice No. must be checked 
Deletion: the stock must be managed accordingly other than that no deletion anomalies

## Account Main:
Insertion: it should have a parties ID so that we can maintain the transactional record of each party in our Account Main table, the account type should be one of the following
•	Purchase
•	Sale
•	Vendor
•	Cash pay
No updation anomalies
Deletion: we cannot delete without deleting it from the child table first. 

## Shipping:
Insertion: the order can only be shipped when it has a sale id. Which means we can only ship orders which has been sold. It must have a expense id as well, which will tell the shipping cost. 
No updation anomalies
No deletion anomalies

