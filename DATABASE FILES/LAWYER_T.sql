USE [CIS655_Shah_N]
GO

/****** Object:  Table [dbo].[LAWYER_T]    Script Date: 5/16/2016 8:41:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LAWYER_T](
	[LawyerID] [int] NOT NULL,
	[Qualification] [nchar](10) NOT NULL,
 CONSTRAINT [PK_LAWYER_T_1] PRIMARY KEY CLUSTERED 
(
	[LawyerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[LAWYER_T]  WITH CHECK ADD  CONSTRAINT [FK_LAWYER_T_LEGALENTITY_T] FOREIGN KEY([LawyerID])
REFERENCES [dbo].[LEGALENTITY_T] ([EntityID])
GO

ALTER TABLE [dbo].[LAWYER_T] CHECK CONSTRAINT [FK_LAWYER_T_LEGALENTITY_T]
GO

