USE [ErrorLog]
GO
/****** Object:  Table [dbo].[LogArchive]    Script Date: 09/30/2016 15:06:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogArchive](
	[Id] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Source] [varchar](50) NULL,
	[Message] [varchar](2000) NULL,
	[Form] [varchar](256) NULL,
	[Querystring] [varchar](256) NULL,
	[TargetSite] [varchar](512) NULL,
	[StackTrace] [varchar](max) NULL,
	[Referrer] [varchar](512) NULL,
	[IpAddress] [varchar](25) NULL,
	[Email] [varchar](256) NULL,
	[ApplicationName] [varchar](25) NOT NULL,
 CONSTRAINT [PK_LogArchive] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Log]    Script Date: 09/30/2016 15:06:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Source] [varchar](50) NULL,
	[Message] [varchar](2000) NULL,
	[Form] [varchar](256) NULL,
	[Querystring] [varchar](256) NULL,
	[TargetSite] [varchar](512) NULL,
	[StackTrace] [varchar](max) NULL,
	[Referrer] [varchar](512) NULL,
	[IpAddress] [varchar](25) NULL,
	[Email] [varchar](256) NULL,
	[ApplicationName] [varchar](25) NOT NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[elx_LogError]    Script Date: 09/30/2016 15:06:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Rob Kurtz>
-- Create date: <Create Date, April 15 2009>
-- Description:	<Description, Logs errors to the log table>
--
-- This procedure is built upon the solution found at 
-- http://www.eggheadcafe.com/articles/20030816.asp
--
-- =============================================
CREATE PROCEDURE [dbo].[elx_LogError]

	@Source varchar(100),
	@Date dateTime,
	@Message varchar(1000),
	@Form varchar(4000),
	@Querystring varchar(2000),
	@TargetSite varchar(300),
	@StackTrace varchar(MAX),
	@Referrer varchar(256),
	@IpAddress varchar(25),
	@Email varchar(256),
	@ApplicationName varchar(256),
	@EventId int output

AS

BEGIN

	INSERT INTO [Log] ([Source], [Date], [Message], [Form], 
		[Querystring], [TargetSite], [StackTrace], 
		[Referrer], [IpAddress], [Email], [ApplicationName])
	VALUES (@Source, @Date, @Message, @Form, 
		@QueryString, @TargetSite, @StackTrace, 
		@Referrer, @IpAddress, @Email, @ApplicationName)

	SELECT @EventId = SCOPE_IDENTITY()

END
GO
