USE [Prod]
GO

CREATE TABLE [dbo].[Customer]
(
	[CustomerID]			[int] IDENTITY(1,1) NOT NULL,
	[CustomerName]			[varchar](50) NULL,
	[Product]				[varchar](25) NULL,
	[AddressID]				[int] NULL,
	[loadDate]				[date] NULL,

	PRIMARY KEY CLUSTERED 
	([CustomerID] ASC)

) ON [PRIMARY]

GO

Insert Into dbo.Customer
	(
	[CustomerName],
	[Product],
	[AddressID],
	[loadDate]
	)
Values	('John Wick','Assasin',21,getdate()),
		('Mickey Mouse','Disney',2,getdate()),
		('Lirik','Streamer',11,getdate()),
		('John Cena','Wrestler',7,getdate())
