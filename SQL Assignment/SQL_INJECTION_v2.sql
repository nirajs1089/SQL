CREATE DATABASE [CIS_ZZZ]
GO
USE [CIS_ZZZ]
GO



/****** Object:  Table [dbo].[users]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[users](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[userName] [varchar](50) NOT NULL,
	[userPass] [varchar](20) NOT NULL
) ON [PRIMARY]
GO

insert into [dbo].users(userName, userPass) values('john', 'doe');
insert into [dbo].users(userName, userPass) values('admin', 'wwz04ff');
insert into [dbo].users(userName, userPass) values('fsmith', 'mypassword');
GO
SET ANSI_PADDING OFF
GO





/****** Object:  Table [dbo].[products]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productName] [varchar](30) NOT NULL
) ON [PRIMARY]
GO

insert into [dbo].products(productName) values('Pink Hoola Hoop')
insert into [dbo].products(productName) values('Green Soccer Ball');
insert into [dbo].products(productName) values('Orange Rocking Chair');
GO
SET ANSI_PADDING OFF
GO
