GO
/****** Object:  Table [dbo].[PBI_UserDashboardAccessRights]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_UserDashboardAccessRights](
	[DashboardAccessRightID] [int] IDENTITY(1,1) NOT NULL,
	[DashboardID] [int] NULL,
	[Users] [uniqueidentifier] NULL,
	[UserType] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_PBI_UserDashboardAccessRights] PRIMARY KEY CLUSTERED 
(
	[DashboardAccessRightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBI_Dashboards]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[SynchronizeTitle] [bit] NULL,
 CONSTRAINT [PK_PBI_Dashboards] PRIMARY KEY CLUSTERED 
(
	[DashboardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAllowedDashboards]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =================================================
-- Author:		Tapiwa Chombe
-- Create date: 28 May 2019
-- Description:	Gets a list of Dashboards which
--				a user is allowed to access, either
--				using group or individual security
-- =================================================
CREATE function [dbo].[fnGetAllowedDashboards]
(
	@UserID AS uniqueidentifier
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
		  SELECT DISTINCT DashboardID FROM PBI_UserDashboardAccessRights WHERE [Users] = @UserID AND UserType= 'User'

		  UNION 
		  --* Where the users group specific access
		  SELECT DISTINCT DashboardID FROM PBI_UserDashboardAccessRights WHERE [Users] 
		  IN (SELECT Roles FROM PermissionPolicyUserUsers_PermissionPolicyRoleRoles WHERE [Users] = @UserID )  AND UserType= 'Role'
	) 
	--there is no security defined on the Dashboard at all
	OR PBI_Dashboards.DashboardID NOT IN (
		SELECT DashboardID FROM PBI_UserDashboardAccessRights
	)

)
GO
/****** Object:  Table [dbo].[PBI_DataSources]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_DataSources](
	[DataSourceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](64) NULL,
	[Description] [nvarchar](1024) NULL,
	[ConnectionString] [nvarchar](1024) NULL,
	[DbSchema] [nvarchar](max) NULL,
	[Provider] [nvarchar](100) NULL,
	[CommandTimeout] [float] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_DataView] PRIMARY KEY CLUSTERED 
(
	[DataSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBI_DashboardDatasources]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_DashboardDatasources](
	[DashboardDatasourceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DatasourceID] [int] NULL,
	[DashboardID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_PBI_DashboardDatasources] PRIMARY KEY CLUSTERED 
(
	[DashboardDatasourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBI_UserDatasourceAccessRights]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_UserDatasourceAccessRights](
	[DatasourceAccessRightID] [int] IDENTITY(1,1) NOT NULL,
	[DatasourceID] [int] NULL,
	[Users] [uniqueidentifier] NULL,
	[UserType] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_PBI_UserDatasourceAccessRights] PRIMARY KEY CLUSTERED 
(
	[DatasourceAccessRightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAllowedDashboardDatasources]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fnGetAllowedDashboardDatasources]
(
	@UserID AS [uniqueidentifier]
)
RETURNS TABLE
AS
RETURN (
	--DECLARE @UserID as [uniqueidentifier] = '4fcee1ed-3db8-4179-a630-54b4de31a935'
	--SELECT @UserID = 1

SELECT PBI_DashboardDatasources.DatasourceID, PBI_DashboardDatasources.DashboardID,  [Name] As DatasourceName ,DbSchema DatasourceValue , dbo.PBI_DataSources.ConnectionString
FROM PBI_DataSources
LEFT OUTER JOIN  PBI_DashboardDatasources ON PBI_DashboardDatasources.DatasourceID =  PBI_DataSources.DatasourceID
WHERE 
	--there is specific access defined
	PBI_DashboardDatasources.DashboardID IN
	(
		  --* Where the user has specific access 
		  SELECT DISTINCT DashboardID FROM PBI_UserDatasourceAccessRights WHERE [Users] = @UserID AND UserType= 'User'

		  UNION 
		  --* Where the users group specific access
		  SELECT DISTINCT DashboardID FROM PBI_UserDatasourceAccessRights WHERE [Users] 
		  IN (SELECT Roles FROM PermissionPolicyUserUsers_PermissionPolicyRoleRoles WHERE [Users] = @UserID )  AND UserType= 'Role'
	) 
	--there is no security defined on the Dashboard at all
	OR PBI_DashboardDatasources.DashboardID NOT IN (
		SELECT DashboardID FROM PBI_UserDatasourceAccessRights
	)


)
GO
/****** Object:  Table [dbo].[PBI_Categories]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
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
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK__PBI_Categories__34C8D9D1] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBI_DatasourceCategories]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_DatasourceCategories](
	[DatasourceCategoryID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DatasourceID] [int] NULL,
	[CategoryID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_PBI_DatasourceCategories] PRIMARY KEY CLUSTERED 
(
	[DatasourceCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBI_GlobalSettings]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_GlobalSettings](
	[GlobalSettingID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Key] [nvarchar](100) NULL,
	[Value] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_GlobalSetting] PRIMARY KEY CLUSTERED 
(
	[GlobalSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBI_ReportDatasources]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_ReportDatasources](
	[ReportDatasourceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DatasourceID] [int] NULL,
	[ReportID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_PBI_ReportDatasources] PRIMARY KEY CLUSTERED 
(
	[ReportDatasourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBI_Reports]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_Reports](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
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
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK__PBI_Reports__34C8D9D1] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBI_SystemImages]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_SystemImages](
	[SystemImageID] [int] IDENTITY(1,1) NOT NULL,
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
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_PBI_SystemImages] PRIMARY KEY CLUSTERED 
(
	[SystemImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBI_UserReportAccessRights]    Script Date: 13 Sep 2019 06:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBI_UserReportAccessRights](
	[ReportAccessRightID] [int] IDENTITY(1,1) NOT NULL,
	[ReportID] [int] NULL,
	[Users] [uniqueidentifier] NULL,
	[UserType] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_PBI_UserReportAccessRights] PRIMARY KEY CLUSTERED 
(
	[ReportAccessRightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PBI_Categories] ADD  CONSTRAINT [DF_PBI_Categories_IsSearcheable]  DEFAULT ((0)) FOR [IsSearchable]
GO
ALTER TABLE [dbo].[PBI_Categories] ADD  CONSTRAINT [DF_PBI_Categories_IsSubscriptionBased]  DEFAULT ((0)) FOR [IsSubscriptionBased]
GO
ALTER TABLE [dbo].[PBI_Categories] ADD  CONSTRAINT [DF_PBI_Categories_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[PBI_Categories] ADD  CONSTRAINT [DF_PBI_Categories_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PBI_Dashboards] ADD  CONSTRAINT [DF_PBI_Dashboards_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PBI_DatasourceCategories] ADD  CONSTRAINT [DF_PBI_DatasourceCategories_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PBI_Reports] ADD  CONSTRAINT [DF_PBI_Reports_IsSearcheable]  DEFAULT ((0)) FOR [IsSearchable]
GO
ALTER TABLE [dbo].[PBI_Reports] ADD  CONSTRAINT [DF_PBI_Reports_HasParameters]  DEFAULT ((0)) FOR [HasParameters]
GO
ALTER TABLE [dbo].[PBI_Reports] ADD  CONSTRAINT [DF_PBI_Reports_DisplayGroupTree]  DEFAULT ((0)) FOR [DisplayGroupTree]
GO
ALTER TABLE [dbo].[PBI_Reports] ADD  CONSTRAINT [DF_PBI_Reports_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PBI_UserDashboardAccessRights] ADD  CONSTRAINT [DF_PBI_DashboardAccessRights_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PBI_UserDatasourceAccessRights] ADD  CONSTRAINT [DF_PBI_UserDatasourceAccessRights_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PBI_UserReportAccessRights] ADD  CONSTRAINT [DF_PBI_ReportAccessRights_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PBI_DashboardDatasources]  WITH CHECK ADD  CONSTRAINT [FK_PBI_PBI_DashboardDatasources_PBI_Dashboards] FOREIGN KEY([DashboardID])
REFERENCES [dbo].[PBI_Dashboards] ([DashboardID])
GO
ALTER TABLE [dbo].[PBI_DashboardDatasources] CHECK CONSTRAINT [FK_PBI_PBI_DashboardDatasources_PBI_Dashboards]
GO
ALTER TABLE [dbo].[PBI_DashboardDatasources]  WITH CHECK ADD  CONSTRAINT [FK_PBI_PBI_DashboardDatasources_PBI_Datasources] FOREIGN KEY([DatasourceID])
REFERENCES [dbo].[PBI_DataSources] ([DataSourceID])
GO
ALTER TABLE [dbo].[PBI_DashboardDatasources] CHECK CONSTRAINT [FK_PBI_PBI_DashboardDatasources_PBI_Datasources]
GO
ALTER TABLE [dbo].[PBI_DatasourceCategories]  WITH CHECK ADD  CONSTRAINT [FK_PBI_DatasourceCategories_PBI_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[PBI_Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[PBI_DatasourceCategories] CHECK CONSTRAINT [FK_PBI_DatasourceCategories_PBI_Categories]
GO
ALTER TABLE [dbo].[PBI_DatasourceCategories]  WITH CHECK ADD  CONSTRAINT [FK_PBI_DatasourceCategories_PBI_Datasources] FOREIGN KEY([DatasourceID])
REFERENCES [dbo].[PBI_DataSources] ([DataSourceID])
GO
ALTER TABLE [dbo].[PBI_DatasourceCategories] CHECK CONSTRAINT [FK_PBI_DatasourceCategories_PBI_Datasources]
GO
ALTER TABLE [dbo].[PBI_ReportDatasources]  WITH CHECK ADD  CONSTRAINT [FK_PBI_ReportDatasources_PBI_Datasources] FOREIGN KEY([DatasourceID])
REFERENCES [dbo].[PBI_DataSources] ([DataSourceID])
GO
ALTER TABLE [dbo].[PBI_ReportDatasources] CHECK CONSTRAINT [FK_PBI_ReportDatasources_PBI_Datasources]
GO
ALTER TABLE [dbo].[PBI_ReportDatasources]  WITH CHECK ADD  CONSTRAINT [FK_PBI_ReportDatasources_PBI_Reports] FOREIGN KEY([ReportID])
REFERENCES [dbo].[PBI_Reports] ([ReportID])
GO
ALTER TABLE [dbo].[PBI_ReportDatasources] CHECK CONSTRAINT [FK_PBI_ReportDatasources_PBI_Reports]
GO
ALTER TABLE [dbo].[PBI_UserDashboardAccessRights]  WITH CHECK ADD  CONSTRAINT [FK_PBI_UserDashboardAccessRights_PBI_Dashboards] FOREIGN KEY([DashboardID])
REFERENCES [dbo].[PBI_Dashboards] ([DashboardID])
GO
ALTER TABLE [dbo].[PBI_UserDashboardAccessRights] CHECK CONSTRAINT [FK_PBI_UserDashboardAccessRights_PBI_Dashboards]
GO
ALTER TABLE [dbo].[PBI_UserReportAccessRights]  WITH CHECK ADD  CONSTRAINT [FK_PBI_UserReportAccessRights_PBI_Reports] FOREIGN KEY([ReportID])
REFERENCES [dbo].[PBI_Reports] ([ReportID])
GO
ALTER TABLE [dbo].[PBI_UserReportAccessRights] CHECK CONSTRAINT [FK_PBI_UserReportAccessRights_PBI_Reports]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Categories', @level2type=N'COLUMN',@level2name=N'TreeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Container Only categories cannot have other objects associated with them e.g. you may not assign members to this category. These categories are only there to help define a category structure and they serve as place holders only.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Categories', @level2type=N'COLUMN',@level2name=N'IsContainerOnly'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Single Selection Trees only allow an object to be associated with only a single node in the tree e.g. a tree defining member class i.e. Bronze, Silver, Gold; cannot allow a member to belong to more than one category.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Categories', @level2type=N'COLUMN',@level2name=N'IsSingleSelectionTree'
GO
EXEC sys.sp_addextendedproperty @name=N'AuditedColumns', @value=N'CategoryID, LeftValue, RightValue, ParentID, TreeID, UpdatedBy, Deleted, Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Categories'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This table stores details on subscriptions ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Categories'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'keeps track of all Datasources and Categories the should apply to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_DatasourceCategories'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Reports', @level2type=N'COLUMN',@level2name=N'TreeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Container Only categories cannot have other objects associated with them e.g. you may not assign members to this category. These categories are only there to help define a category structure and they serve as place holders only.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Reports', @level2type=N'COLUMN',@level2name=N'IsContainerOnly'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Single Selection Trees only allow an object to be associated with only a single node in the tree e.g. a tree defining member class i.e. Bronze, Silver, Gold; cannot allow a member to belong to more than one category.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Reports', @level2type=N'COLUMN',@level2name=N'IsSingleSelectionTree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'stores the XML that is used to dynamically ALTER user reports.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PBI_Reports'
GO
