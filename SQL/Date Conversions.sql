--SQL Date Conversions
select	
		getdate() TodaysDateTime,
		convert(date,getdate(),120) TodaysDate,
		convert(varchar(10),getdate(),110) TodaysDateSwapped,
		dateadd(d,-1,convert(date,getdate(),120)) as DatePlusOne,		
		dateadd(m,-1,convert(date,getdate(),120)) as PreviousMonth,		
		convert(varchar(6),getdate(),112) as YearMonth,
		convert(varchar(8),getdate(),112) as YYYYMMDD,	
		convert(varchar(12),getdate(),107) as StandardDate
Select 
		EOMONTH(getdate())EndofCurMonth,
		EOMONTH(getdate(),-1) EndOfPrevMonth,
		DATEADD(DAY,1,EOMONTH(getdate(),-1)) BeginningOfCurMonth
