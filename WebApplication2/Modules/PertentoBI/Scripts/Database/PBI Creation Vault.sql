/****** Object:  UserDefinedFunction [dbo].[pbi_fnGetQuarter]    Script Date: 2022/06/22 09:36:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pbi_fnGetQuarter]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[pbi_fnGetQuarter]
(
   @StartDate Date,
   @EndDate Date,
   @Date Date
 )
RETURNS int
AS
BEGIN
--Declare @StartDate Date=''2016-07-01 00:00:00.000'', @EndDate Date=''2019-06-30 00:00:00.000''
DECLARE @firstMonthOfFiscalQ1 int = Month(@StartDate), @quater varchar(10); --1=January

SELECT @quater = [Quarter] FROM ( 
	select   year(@Date) [Year],
	--datepart(quarter,dateadd(day,rnum,@StartDate)) qtr
	FLOOR(((12 + MONTH(@Date) -@firstMonthOfFiscalQ1) % 12) / 3 ) + 1 AS [Quarter], @Date [Report_Month_Start_Date],
	 CAST(YEAR(@StartDate) AS VARCHAR(4)) + ''/'' + RIGHT(''0'' + CAST(MONTH(@StartDate) AS VARCHAR(2)),2) [Report Month]
	) AS Q

	RETURN @quater

END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Split_On_Upper_Case]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Split_On_Upper_Case]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'Create Function [dbo].[Split_On_Upper_Case](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin

    Declare @KeepValues as varchar(50)
    Set @KeepValues = ''%[^ ][A-Z]%''
    While PatIndex(@KeepValues collate Latin1_General_Bin, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues collate Latin1_General_Bin, @Temp) + 1, 0, '' '')

    Return @Temp
End

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[ToProperCase]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ToProperCase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ToProperCase](@string VARCHAR(255)) RETURNS VARCHAR(255)
AS
BEGIN
  DECLARE @i INT           -- index
  DECLARE @l INT           -- input length
  DECLARE @c NCHAR(1)      -- current char
  DECLARE @f INT           -- first letter flag (1/0)
  DECLARE @o VARCHAR(255)  -- output string
  DECLARE @w VARCHAR(10)   -- characters considered as white space

  SET @w = ''['' + CHAR(13) + CHAR(10) + CHAR(9) + CHAR(160) + '' '' + '']''
  SET @i = 1
  SET @l = LEN(@string)
  SET @f = 1
  SET @o = ''''

  WHILE @i <= @l
  BEGIN
    SET @c = SUBSTRING(@string, @i, 1)
    IF @f = 1 
    BEGIN
     SET @o = @o + @c
     SET @f = 0
    END
    ELSE
    BEGIN
     SET @o = @o + LOWER(@c)
    END

    IF @c LIKE @w SET @f = 1

    SET @i = @i + 1
  END

  RETURN @o
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[udfSplit]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udfSplit]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE  FUNCTION [dbo].[udfSplit](
 @String nvarchar (max),
 @Delimiter nvarchar (10)
 )
returns @ValueTable table ([Value] nvarchar(max), [SplitPos] int null)
begin
 declare @NextString nvarchar(max)
 declare @Pos int, @SplitPos int
 declare @NextPos int
 declare @CommaCheck nvarchar(1)
 
 --Initialize
 set @NextString = ''''
 set @CommaCheck = right(@String,1) 
 
 --Check for trailing Comma, if not exists, INSERT
 --if (@CommaCheck <> @Delimiter )
 set @String = @String + @Delimiter
 
 --Get position of first Comma
 set @Pos = charindex(@Delimiter,@String)
 set @NextPos = 1
 set @SplitPos = 1
 
 --Loop while there is still a comma in the String of levels
 while (@pos <>  0)  
 begin
  set @NextString = substring(@String,1,@Pos - 1)
 
  insert into @ValueTable ([Value], [SplitPos]) Values (@NextString, @SplitPos)
 
  set @String = substring(@String,@pos +1,len(@String))
  
  set @NextPos = @Pos
  set @pos  = charindex(@Delimiter,@String)
  set @SplitPos = @SplitPos + 1
  
 end
 
 return
end
' 
END
GO
/****** Object:  Table [dbo].[PBI_Categories]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_Categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_Categories](
	[CategoryID] [int] NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](255) NOT NULL,
	[LeftValue] [int] NOT NULL,
	[RightValue] [int] NOT NULL,
	[ParentID] [int] NULL,
	[TreeID] [int] NULL,
	[IsContainerOnly] [bit] NULL,
	[IsSingleSelectionTree] [bit] NULL,
	[IsSearchable] [bit] NULL,
	[IsSubscriptionBased] [bit] NULL,
	[Deleted] [bit] NULL,
	[WField1] [varchar](255) NULL,
	[WField2] [varchar](255) NULL,
	[WField3] [varchar](255) NULL,
	[WField4] [varchar](255) NULL,
	[WField5] [varchar](255) NULL,
	[Type] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_DashboardDatasources]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_DashboardDatasources]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_DashboardDatasources](
	[DashboardDatasourceID] [int] NOT NULL,
	[DatasourceID] [int] NULL,
	[DashboardID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_Dashboards]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_Dashboards]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_Dashboards](
	[DashboardID] [int] IDENTITY(1,1) NOT NULL,
	[DashboardName] [varchar](500) NULL,
	[GroupName] [varchar](500) NULL,
	[Datasource] [varchar](max) NULL,
	[DashboardDefinition] [varbinary](max) NULL,
	[IsCustomDashboard] [bit] NULL,
	[DashboardDefinitionXML] [xml] NULL,
	[DefaultSource] [varchar](50) NULL,
	[ExtractSchedule] [varchar](250) NULL,
	[LastExtractDate] [datetime] NULL,
	[ExtractStatus] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[Title] [nvarchar](100) NULL,
	[Content] [nvarchar](100) NULL,
	[SynchronizeTitle] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_DatasourceCategories]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_DatasourceCategories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_DatasourceCategories](
	[DatasourceCategoryID] [int] NOT NULL,
	[DatasourceID] [int] NULL,
	[CategoryID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_DataSources]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_DataSources]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_DataSources](
	[DataSourceID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NULL,
	[Description] [nvarchar](1024) NULL,
	[ConnectionString] [nvarchar](1024) NULL,
	[DbSchema] [nvarchar](max) NULL,
	[Provider] [nvarchar](100) NULL,
	[CommandTimeout] [float] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_GlobalSettings]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_GlobalSettings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_GlobalSettings](
	[GlobalSettingID] [int] NOT NULL,
	[Key] [nvarchar](100) NULL,
	[Value] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_ReportDatasources]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_ReportDatasources]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_ReportDatasources](
	[ReportDatasourceID] [int] NOT NULL,
	[DatasourceID] [int] NULL,
	[ReportID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_Reports]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_Reports]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_Reports](
	[ReportID] [int] NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](255) NOT NULL,
	[LeftValue] [int] NOT NULL,
	[RightValue] [int] NOT NULL,
	[ParentID] [int] NULL,
	[TreeID] [int] NULL,
	[ReportName] [varchar](255) NULL,
	[IsContainerOnly] [bit] NULL,
	[IsSingleSelectionTree] [bit] NULL,
	[IsSearchable] [bit] NULL,
	[XMLString] [varchar](3000) NULL,
	[IsSubscriptionBased] [bit] NULL,
	[ReportActionsXML] [varchar](3000) NULL,
	[ReportData] [varchar](max) NULL,
	[IsEditable] [bit] NULL,
	[HasParameters] [bit] NULL,
	[DisplayGroupTree] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_SystemImages]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_SystemImages]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_SystemImages](
	[SystemImageID] [int] NOT NULL,
	[EntityID] [int] NULL,
	[EntityType] [varchar](50) NULL,
	[EntityName] [varchar](200) NULL,
	[FColor] [varchar](200) NULL,
	[Color1] [varchar](200) NULL,
	[Color2] [varchar](200) NULL,
	[ImageURL] [varchar](max) NULL,
	[ImageType] [varchar](20) NULL,
	[Target] [nvarchar](50) NULL,
	[Height] [nvarchar](50) NULL,
	[Width] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_UserDashboardAccessRights]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_UserDashboardAccessRights]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_UserDashboardAccessRights](
	[DashboardAccessRightID] [int] NOT NULL,
	[DashboardID] [int] NULL,
	[Users] [uniqueidentifier] NULL,
	[UserID] [int] NULL,
	[UserType] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_UserDatasourceAccessRights]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_UserDatasourceAccessRights]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_UserDatasourceAccessRights](
	[DatasourceAccessRightID] [int] NOT NULL,
	[DatasourceID] [int] NULL,
	[Users] [uniqueidentifier] NULL,
	[UserID] [int] NULL,
	[UserType] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PBI_UserReportAccessRights]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBI_UserReportAccessRights]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PBI_UserReportAccessRights](
	[ReportAccessRightID] [int] NOT NULL,
	[ReportID] [int] NULL,
	[UserID] [int] NULL,
	[Users] [uniqueidentifier] NULL,
	[UserType] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAllowedDashboardDatasources]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGetAllowedDashboardDatasources]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE function [dbo].[fnGetAllowedDashboardDatasources]
(
	@UserID AS int
)
RETURNS TABLE
AS
RETURN (
	
	  

	--SELECT @UserID = 1

SELECT PBI_DataSources.DatasourceID, PBI_DashboardDatasources.DashboardID,  [Name] As DatasourceName ,DbSchema DatasourceValue , dbo.PBI_DataSources.ConnectionString
FROM PBI_DataSources
LEFT OUTER JOIN  PBI_DashboardDatasources ON PBI_DashboardDatasources.DatasourceID =  PBI_DataSources.DatasourceID
WHERE 
	--there is specific access defined
	PBI_DashboardDatasources.DashboardID IN
	(
		  --* Where the user has specific access 
		  SELECT DISTINCT DashboardID FROM PBI_UserDatasourceAccessRights WHERE UserID = @UserID AND UserType= ''User''

		  UNION 
		  --* Where the users group specific access
		  SELECT DISTINCT DashboardID FROM PBI_UserDatasourceAccessRights WHERE UserID 
		  IN (SELECT UserGroupID FROM tblUserUserGroups WHERE UserID = @UserID )  AND UserType= ''Group''
	) 
	--there is no security defined on the Dashboard at all
	OR PBI_DashboardDatasources.DashboardID NOT IN (
		SELECT DashboardID FROM PBI_UserDatasourceAccessRights
	)


)
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAllowedDashboards]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGetAllowedDashboards]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'


-- =================================================
-- Author:		Tapiwa Chombe
-- Create date: 28 May 2019
-- Description:	Gets a list of Dashboards which
--				a user is allowed to access, either
--				using group or individual security
-- =================================================
CREATE function [dbo].[fnGetAllowedDashboards]
(
	@UserID AS int
)
RETURNS TABLE
AS
RETURN (
	--DECLARE @UserID as int
	--SELECT @UserID = 1

	SELECT PBI_Dashboards.* FROM PBI_Dashboards 
	WHERE 
	--there is specific access defined
	PBI_Dashboards.DashboardID IN
	(
		  --* Where the user has specific access 
		  SELECT DISTINCT DashboardID FROM PBI_UserDashboardAccessRights WHERE UserID = @UserID AND UserType= ''User''

		  UNION 
		  --* Where the users group specific access
		  SELECT DISTINCT DashboardID FROM PBI_UserDashboardAccessRights WHERE  UserID
		  IN (SELECT UserGroupID FROM tblUserUserGroups WHERE UserID = @UserID )  AND UserType= ''Group''
	) 
	--there is no security defined on the Dashboard at all
	OR PBI_Dashboards.DashboardID NOT IN (
		SELECT DashboardID FROM PBI_UserDashboardAccessRights
	)

)


' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[pbi_fnGetPeriodAndQuarters]    Script Date: 2022/06/22 09:36:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pbi_fnGetPeriodAndQuarters]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[pbi_fnGetPeriodAndQuarters]
(
   @StartDate Date,
   @EndDate Date
 )
RETURNS TABLE
AS
RETURN  
(
	
--Declare @StartDate Date=''2016-07-01 00:00:00.000'', @EndDate Date=''2019-06-30 00:00:00.000''
--DECLARE @firstMonthOfFiscalQ1 int = Month(@StartDate); --1=January
--SELECT @StartDate, FLOOR(((12 + MONTH(@StartDate) - @firstMonthOfFiscalQ1) % 12) / 3 ) + 1 AS FiscalQuarter


select TOP 100 PERCENT year(@StartDate) [Year],
--datepart(quarter,dateadd(day,rnum,@StartDate)) qtr
FLOOR(((12 + MONTH(@StartDate) - Month(@StartDate)) % 12) / 3 ) + 1 AS [Quarter], @StartDate [Report_Month_Start_Date],
 CAST(YEAR(@StartDate) AS VARCHAR(4)) + ''/'' + RIGHT(''0'' + CAST(MONTH(@StartDate) AS VARCHAR(2)),2) [Report Month]
UNION
select TOP 100 PERCENT year(dateadd(Month,rnum,@StartDate)) [Year],
--datepart(quarter,dateadd(day,rnum,@StartDate)) qtr
FLOOR(((12 + MONTH(dateadd(Month,rnum,@StartDate)) - Month(@StartDate)) % 12) / 3 ) + 1 AS [Quarter], dateadd(Month,rnum,@StartDate) [Report_Month_Start_Date],
 CAST(YEAR(dateadd(Month,rnum,@StartDate)) AS VARCHAR(4)) + ''/'' + RIGHT(''0'' + CAST(MONTH(dateadd(Month,rnum,@StartDate)) AS VARCHAR(2)),2) [Report Month] 
from (select row_number() over(order by (select null)) as rnum 
      from master..spt_values) t
where dateadd(Month,rnum,@StartDate) <= @EndDate
ORDER BY [Year], [Report Month]
)

' 
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_Categories_IsSearcheable]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_Categories] ADD  CONSTRAINT [DF_PBI_Categories_IsSearcheable]  DEFAULT ((0)) FOR [IsSearchable]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_Categories_IsSubscriptionBased]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_Categories] ADD  CONSTRAINT [DF_PBI_Categories_IsSubscriptionBased]  DEFAULT ((0)) FOR [IsSubscriptionBased]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_Categories_Deleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_Categories] ADD  CONSTRAINT [DF_PBI_Categories_Deleted]  DEFAULT ((0)) FOR [Deleted]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_Categories_CreatedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_Categories] ADD  CONSTRAINT [DF_PBI_Categories_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_DatasourceCategories_CreatedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_DatasourceCategories] ADD  CONSTRAINT [DF_PBI_DatasourceCategories_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_Reports_IsSearcheable]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_Reports] ADD  CONSTRAINT [DF_PBI_Reports_IsSearcheable]  DEFAULT ((0)) FOR [IsSearchable]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_Reports_HasParameters]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_Reports] ADD  CONSTRAINT [DF_PBI_Reports_HasParameters]  DEFAULT ((0)) FOR [HasParameters]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_Reports_DisplayGroupTree]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_Reports] ADD  CONSTRAINT [DF_PBI_Reports_DisplayGroupTree]  DEFAULT ((0)) FOR [DisplayGroupTree]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_Reports_CreatedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_Reports] ADD  CONSTRAINT [DF_PBI_Reports_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_DashboardAccessRights_CreatedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_UserDashboardAccessRights] ADD  CONSTRAINT [DF_PBI_DashboardAccessRights_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_UserDatasourceAccessRights_CreatedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_UserDatasourceAccessRights] ADD  CONSTRAINT [DF_PBI_UserDatasourceAccessRights_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PBI_ReportAccessRights_CreatedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PBI_UserReportAccessRights] ADD  CONSTRAINT [DF_PBI_ReportAccessRights_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PBI_Categories', N'COLUMN',N'TreeID'))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Categories', @level2type=N'COLUMN',@level2name=N'TreeID'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PBI_Categories', N'COLUMN',N'IsContainerOnly'))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Container Only categories cannot have other objects associated with them e.g. you may not assign members to this category. These categories are only there to help define a category structure and they serve as place holders only.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Categories', @level2type=N'COLUMN',@level2name=N'IsContainerOnly'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PBI_Categories', N'COLUMN',N'IsSingleSelectionTree'))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Single Selection Trees only allow an object to be associated with only a single node in the tree e.g. a tree defining member class i.e. Bronze, Silver, Gold; cannot allow a member to belong to more than one category.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Categories', @level2type=N'COLUMN',@level2name=N'IsSingleSelectionTree'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'AuditedColumns' , N'SCHEMA',N'dbo', N'TABLE',N'PBI_Categories', NULL,NULL))
	EXEC sys.sp_addextendedproperty @name=N'AuditedColumns', @value=N'CategoryID, LeftValue, RightValue, ParentID, TreeID, UpdatedBy, Deleted, Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Categories'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PBI_Categories', NULL,NULL))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This table stores details on subscriptions ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Categories'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PBI_DatasourceCategories', NULL,NULL))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'keeps track of all Datasources and Categories the should apply to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_DatasourceCategories'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PBI_Reports', N'COLUMN',N'TreeID'))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Reports', @level2type=N'COLUMN',@level2name=N'TreeID'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PBI_Reports', N'COLUMN',N'IsContainerOnly'))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Container Only categories cannot have other objects associated with them e.g. you may not assign members to this category. These categories are only there to help define a category structure and they serve as place holders only.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Reports', @level2type=N'COLUMN',@level2name=N'IsContainerOnly'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PBI_Reports', N'COLUMN',N'IsSingleSelectionTree'))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Single Selection Trees only allow an object to be associated with only a single node in the tree e.g. a tree defining member class i.e. Bronze, Silver, Gold; cannot allow a member to belong to more than one category.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Reports', @level2type=N'COLUMN',@level2name=N'IsSingleSelectionTree'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'PBI_Reports', NULL,NULL))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'stores the XML that is used to dynamically ALTER user reports.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Reports'
GO
