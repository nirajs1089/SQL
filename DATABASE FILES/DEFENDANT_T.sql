USE [CIS655_Shah_N]
GO

/****** Object:  Table [dbo].[DEFENDANT_T]    Script Date: 5/16/2016 8:39:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEFENDANT_T](
	[DefendantID] [int] NOT NULL,
	[Right] [nvarchar](35) NULL,
 CONSTRAINT [PK_DEFENDANT_T] PRIMARY KEY CLUSTERED 
(
	[DefendantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DEFENDANT_T]  WITH CHECK ADD  CONSTRAINT [FK_DEFENDANT_T_LEGALENTITY_T] FOREIGN KEY([DefendantID])
REFERENCES [dbo].[LEGALENTITY_T] ([EntityID])
GO

ALTER TABLE [dbo].[DEFENDANT_T] CHECK CONSTRAINT [FK_DEFENDANT_T_LEGALENTITY_T]
GO
