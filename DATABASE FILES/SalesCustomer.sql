USE [CIS655_Shah_N]
GO

/****** Object:  Table [dbo].[SalesCustomer]    Script Date: 5/16/2016 8:42:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SalesCustomer](
	[CustomerID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO

