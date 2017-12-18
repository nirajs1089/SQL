USE [CIS655_Shah_N]
GO

/****** Object:  Table [dbo].[SPECIALITY_T]    Script Date: 5/16/2016 8:42:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SPECIALITY_T](
	[SpecialityID] [int] NOT NULL,
	[Description] [nvarchar](30) NULL,
 CONSTRAINT [PK_SPECIALITY_1] PRIMARY KEY CLUSTERED 
(
	[SpecialityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

