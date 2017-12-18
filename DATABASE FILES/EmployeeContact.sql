USE [CIS655_Shah_N]
GO

/****** Object:  Table [dbo].[EmployeeContact]    Script Date: 5/16/2016 8:40:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmployeeContact](
	[EmployeeID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO

