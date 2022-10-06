/****** Object:  User [pyfuncuser]    Script Date: 10/3/2022 12:04:27 PM ******/
CREATE USER [pyfuncuser] FOR LOGIN [pyfunclogin] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'pyfuncuser'
GO
/****** Object:  Table [dbo].[dim_all_clients]    Script Date: 10/3/2022 12:04:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_all_clients](
	[id] [varchar](24) NOT NULL,
	[name] [varchar](100) NULL,
 CONSTRAINT [PK_dim_all_clients] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_client_groups]    Script Date: 10/3/2022 12:04:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_client_groups](
	[ClientGroupKey] [varchar](24) NOT NULL,
	[ClientOwner] [varchar](254) NULL,
	[ClientManager] [varchar](254) NULL,
	[LastModifiedDateTime] [datetime] NULL,
	[Members] [varchar](max) NULL,
 CONSTRAINT [PK__dim_clie__DC5E0DD6A45979CE] PRIMARY KEY CLUSTERED 
(
	[ClientGroupKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_contacts]    Script Date: 10/3/2022 12:04:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_contacts](
	[ContactKey] [varchar](24) NOT NULL,
	[ClientOwner] [varchar](254) NULL,
	[ClientManager] [varchar](254) NULL,
	[LastModifiedDateTime] [datetime] NULL,
 CONSTRAINT [PK__tmp_ms_x__741282B27679346D] PRIMARY KEY CLUSTERED 
(
	[ContactKey] DESC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_date]    Script Date: 10/3/2022 12:04:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_date](
	[DateKey] [int] NOT NULL,
	[Date] [datetime] NULL,
	[FullDate] [date] NULL,
	[DayOfMonth] [smallint] NULL,
	[DayName] [varchar](9) NULL,
	[DayOfWeek] [smallint] NULL,
	[DayOfWeekInMonth] [smallint] NULL,
	[DayOfWeekInYear] [smallint] NULL,
	[DayOfQuarter] [smallint] NULL,
	[DayOfYear] [smallint] NULL,
	[WeekOfMonth] [smallint] NULL,
	[WeekOfQuarter] [smallint] NULL,
	[WeekOfYear] [smallint] NULL,
	[Month] [smallint] NULL,
	[MonthName] [varchar](9) NULL,
	[MonthOfQuarter] [smallint] NULL,
	[Quarter] [smallint] NULL,
	[QuarterName] [varchar](9) NULL,
	[Year] [smallint] NULL,
	[YearName] [char](7) NULL,
	[MonthYear] [char](10) NULL,
	[MMYYYY] [char](6) NULL,
	[FirstDayOfMonth] [date] NULL,
	[LastDayOfMonth] [date] NULL,
	[FirstDayOfQuarter] [date] NULL,
	[LastDayOfQuarter] [date] NULL,
	[FirstDayOfYear] [date] NULL,
	[LastDayOfYear] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_organizations]    Script Date: 10/3/2022 12:04:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_organizations](
	[OrganizationKey] [varchar](24) NOT NULL,
	[ClientOwner] [varchar](254) NULL,
	[ClientManager] [varchar](254) NULL,
	[LastModifiedDateTime] [datetime] NULL,
 CONSTRAINT [PK__dim_orga__AE2A01DA62715050] PRIMARY KEY CLUSTERED 
(
	[OrganizationKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_timesheets]    Script Date: 10/3/2022 12:04:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_timesheets](
	[TimesheetKey] [varchar](24) NOT NULL,
	[StartDate] [datetimeoffset](7) NOT NULL,
	[EndDate] [datetimeoffset](7) NOT NULL,
	[UserKey] [varchar](24) NOT NULL,
	[Status] [varchar](100) NOT NULL,
 CONSTRAINT [PK_dim_timesheets] PRIMARY KEY CLUSTERED 
(
	[TimesheetKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_users]    Script Date: 10/3/2022 12:04:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_users](
	[Id] [varchar](24) NOT NULL,
	[EmailAddress] [varchar](254) NOT NULL,
	[Name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_dim_users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_dim_users] UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_work_items]    Script Date: 10/3/2022 12:04:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_work_items](
	[WorkItemKey] [varchar](24) NOT NULL,
	[Title] [varchar](200) NOT NULL,
	[ClientKey] [varchar](24) NULL,
	[RelatedClientGroupKey] [varchar](24) NULL,
	[ClientGroupKey] [varchar](24) NULL,
	[WorkType] [varchar](200) NULL,
 CONSTRAINT [PK__dim_work__1331D71C135C4EAD] PRIMARY KEY CLUSTERED 
(
	[WorkItemKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fct_time_entries]    Script Date: 10/3/2022 12:04:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fct_time_entries](
	[TimesheetKey] [varchar](24) NOT NULL,
	[TimeEntryKey] [varchar](max) NOT NULL,
	[EntityKey] [varchar](24) NOT NULL,
	[WorkItemKey] [varchar](24) NULL,
	[ClientKey] [varchar](24) NOT NULL,
	[ClientType] [varchar](100) NOT NULL,
	[RoleName] [varchar](100) NULL,
	[TaskTypeName] [varchar](100) NULL,
	[Minutes] [bigint] NOT NULL,
	[HourlyRate] [float] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fct_work_item_flow]    Script Date: 10/3/2022 12:04:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fct_work_item_flow](
	[WorkItemKey] [varchar](24) NOT NULL,
	[AssigneeKey] [varchar](24) NOT NULL,
	[StartDate] [datetimeoffset](7) NULL,
	[DueDate] [datetimeoffset](7) NULL,
	[CompletedDate] [datetimeoffset](7) NULL,
	[WorkStatus] [varchar](100) NOT NULL,
	[LastUpdateDateTime] [datetimeoffset](7) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dim_client_groups]  WITH CHECK ADD  CONSTRAINT [FK_dim_client_groups_dim_all_clients] FOREIGN KEY([ClientGroupKey])
REFERENCES [dbo].[dim_all_clients] ([id])
GO
ALTER TABLE [dbo].[dim_client_groups] CHECK CONSTRAINT [FK_dim_client_groups_dim_all_clients]
GO
ALTER TABLE [dbo].[dim_contacts]  WITH CHECK ADD  CONSTRAINT [FK_dim_all_clients] FOREIGN KEY([ContactKey])
REFERENCES [dbo].[dim_all_clients] ([id])
GO
ALTER TABLE [dbo].[dim_contacts] CHECK CONSTRAINT [FK_dim_all_clients]
GO
ALTER TABLE [dbo].[dim_organizations]  WITH CHECK ADD  CONSTRAINT [FK_dim_organizations_dim_all_clients] FOREIGN KEY([OrganizationKey])
REFERENCES [dbo].[dim_all_clients] ([id])
GO
ALTER TABLE [dbo].[dim_organizations] CHECK CONSTRAINT [FK_dim_organizations_dim_all_clients]
GO
ALTER TABLE [dbo].[dim_timesheets]  WITH CHECK ADD  CONSTRAINT [FK_dim_timesheets_dim_users] FOREIGN KEY([UserKey])
REFERENCES [dbo].[dim_users] ([Id])
GO
ALTER TABLE [dbo].[dim_timesheets] CHECK CONSTRAINT [FK_dim_timesheets_dim_users]
GO
ALTER TABLE [dbo].[fct_time_entries]  WITH CHECK ADD  CONSTRAINT [FK_fct_time_entries_dim_timesheets] FOREIGN KEY([TimesheetKey])
REFERENCES [dbo].[dim_timesheets] ([TimesheetKey])
GO
ALTER TABLE [dbo].[fct_time_entries] CHECK CONSTRAINT [FK_fct_time_entries_dim_timesheets]
GO
ALTER TABLE [dbo].[fct_work_item_flow]  WITH CHECK ADD  CONSTRAINT [FK__fct_work___Assig__1CBC4616] FOREIGN KEY([AssigneeKey])
REFERENCES [dbo].[dim_users] ([Id])
GO
ALTER TABLE [dbo].[fct_work_item_flow] CHECK CONSTRAINT [FK__fct_work___Assig__1CBC4616]
GO