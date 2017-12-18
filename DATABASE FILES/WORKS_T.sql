USE [CIS655_Shah_N]
GO

/****** Object:  Table [dbo].[WORKS_T]    Script Date: 5/16/2016 8:43:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WORKS_T](
	[LawyerID] [int] NOT NULL,
	[CaseID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Hours] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_WORKS_T] PRIMARY KEY CLUSTERED 
(
	[LawyerID] ASC,
	[CaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[WORKS_T]  WITH CHECK ADD  CONSTRAINT [FK_WORKS_T_CASE_T] FOREIGN KEY([CaseID])
REFERENCES [dbo].[CASE_T] ([CaseID])
GO

ALTER TABLE [dbo].[WORKS_T] CHECK CONSTRAINT [FK_WORKS_T_CASE_T]
GO

ALTER TABLE [dbo].[WORKS_T]  WITH CHECK ADD  CONSTRAINT [FK_WORKS_T_LAWYER_T] FOREIGN KEY([LawyerID])
REFERENCES [dbo].[LAWYER_T] ([LawyerID])
GO

ALTER TABLE [dbo].[WORKS_T] CHECK CONSTRAINT [FK_WORKS_T_LAWYER_T]
GO

