
Create Table ##Subscriptions 
		(
		keysubscriber int NULL,
		CusName varchar(30) NULL,
		productCode varchar(15) NULL,
		effectiveStartdate date NULL,
		effectiveEndDate date Null
		)
Insert into ##Subscriptions 
		(
		keysubscriber,
		CusName ,
		productCode,
		effectiveStartdate,
		effectiveEndDate
		)
Values (5,'Michelle Crenshaw','Box180','2017-01-27','2017-07-27'),
		(6,'Bob Smith','BoxREC','2016-03-04','2999-12-31'),
		(7,'Brian Murphy','Box365','2015-01-02','2016-02-02'),
		(7,'Brian Murphy','Box30_d','2016-02-08','2016-03-08'),
		(7,'Brian Murphy','Box30','2016-03-08','2016-04-08'),
		(7,'Brian Murphy','Box30','2016-04-08','2999-12-31'),
		(8,'Derek Johnson','Box30','2016-03-12','2016-04-12')
;			
----------------	

select
	sd.keysubscriber,
	CusName,
	productcode,
	effectivestartdate,
	effectiveenddate,
	lag(EffectiveStartDate,2) OVER (Partition By sd.keysubscriber Order By effectivestartdate asc) PriorStartDate,
	lead(EffectiveStartDate,2) OVER (Partition By sd.keysubscriber Order By effectivestartdate asc) NextStartDate

from ##Subscriptions sd
order by sd.keysubscriber, sd.effectivestartdate



