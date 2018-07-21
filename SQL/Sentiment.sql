/*
This data set reflects customers that were surveyed after calling into a customer support hotline. 
The reason code was for the original call. The notes are from the actual customer survey
*/
Create Table dbo.CustomerSurveys 
			(
	SurveyDate Date NULL,
	CustomerID int NULL,
	ReasonCode varchar(20) NULL,
	Notes varchar(500) NULL

			)
-----------
Insert Into dbo.CustomerSurveys
Values	('2018-04-01',258,'Payments','I was late on my payment and your rep assisted me quickly'),
		('2018-03-28',441,'Troubleshooting','My device stopped working. Called to get help'),
		('2018-03-27',444,'Payments','My payment would not process online. It was frustrating and painful process to have to call in'),
		('2018-03-29',752,'Order','Ordered a new device. Rep was very helpful and nice'),
		('2018-04-04',458,'Troubleshooting','Needed to troubleshoot why my device could not make outgoing calls'),
		('2018-04-06',701,'Payments','I was late making my payment so I called in to make it.'),
		('2018-04-08',352,'Order','Needed to upgrade my device. It was very easy'),
		('2018-03-30',521,'Troubleshooting','My data would not work on my cellphone. Your agent was very nice and helpful'),
		('2018-03-30',201,'Order','Ordered some accessories and they never were shipped. I am really mad'),
		('2018-03-29',620,'Payments','Needed to make my payment'),
		('2018-04-01',452,'Order','I needed to order a device and you were out of stock. It made me mad'),
		('2018-04-02',741,'Troubleshooting','My phone would not make calls but the screen turned on'),
		('2018-04-01',584,'Payments','Called to make a payment. Customer Representative was rude'),
		('2018-04-01',658,'Troubleshooting','My battery died and needed a new one'),
		('2018-03-31',523,'Troubleshooting','My device would turn on but I could not get any thing to show on the display'),
		('2018-04-02',952,'Payments','paid my bill early'),
		('2018-04-03',254,'Order','So excited to upgrade my device'),
		('2018-04-01',425,'Payments','Called into your call center and made a payment. I had to wait 10 mins to get connected'),
		('2018-04-01',678,'Payments','paid my bill'),
		('2018-04-02',305,'Order','My device broke and ordered a new one')
