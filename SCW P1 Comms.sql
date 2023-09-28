USE [master]
GO

/****** Object:  Database [SCW_P1_Comms]    Script Date: 12/04/2022 14:32:31 ******/
CREATE DATABASE [SCW_P1_Comms]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SCW_P1_Comms', FILENAME = N'K:\MSSQL\Data\SCW_P1_Comms.mdf' , SIZE = 1048576KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1048576KB )
 LOG ON 
( NAME = N'SCW_P1_Comms_log', FILENAME = N'L:\MSSQL\Log\SCW_P1_Comms_log.ldf' , SIZE = 262144KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SCW_P1_Comms].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [SCW_P1_Comms] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET ARITHABORT OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [SCW_P1_Comms] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [SCW_P1_Comms] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET  DISABLE_BROKER 
GO

ALTER DATABASE [SCW_P1_Comms] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [SCW_P1_Comms] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET RECOVERY FULL 
GO

ALTER DATABASE [SCW_P1_Comms] SET  MULTI_USER 
GO

ALTER DATABASE [SCW_P1_Comms] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [SCW_P1_Comms] SET DB_CHAINING OFF 
GO

ALTER DATABASE [SCW_P1_Comms] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [SCW_P1_Comms] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [SCW_P1_Comms] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [SCW_P1_Comms] SET QUERY_STORE = OFF
GO

ALTER DATABASE [SCW_P1_Comms] SET  READ_WRITE 
GO


USE [SCW_P1_Comms]
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 12/04/2022 14:33:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Specification] [nvarchar](255) NULL,
	[Street (Visiting)] [nvarchar](255) NULL,
	[Number (Visiting)] [nvarchar](255) NULL,
	[Postcode (Visiting)] [nvarchar](255) NULL,
	[City (Visiting)] [nvarchar](255) NULL,
	[Country (Visiting)] [nvarchar](255) NULL,
	[State / County (Visiting)] [nvarchar](255) NULL,
	[Street (Post)] [nvarchar](255) NULL,
	[Number (Post)] [nvarchar](255) NULL,
	[Postcode (Post)] [nvarchar](255) NULL,
	[City (Post)] [nvarchar](255) NULL,
	[Country (Post)] [nvarchar](255) NULL,
	[State / County (Post)] [nvarchar](255) NULL,
	[Account Manager] [nvarchar](255) NULL,
	[Affiliation No (Microsoft Affiliation)] [nvarchar](255) NULL,
	[Attention] [nvarchar](255) NULL,
	[Changer of the Card] [nvarchar](255) NULL,
	[Comments] [nvarchar](255) NULL,
	[Contact] [nvarchar](255) NULL,
	[Creator of the Card] [nvarchar](255) NULL,
	[Customer Reference No] [nvarchar](255) NULL,
	[Customer type] [nvarchar](255) NULL,
	[Date/time of change] [datetime] NULL,
	[Date/time of creation] [datetime] NULL,
	[Email] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
	[Has Attention?] [bit] NOT NULL,
	[Head customer] [nvarchar](255) NULL,
	[ID (Customer Database)] [nvarchar](255) NULL,
	[Import ID] [nvarchar](255) NULL,
	[Import type (system field)] [nvarchar](255) NULL,
	[Membership Number] [nvarchar](255) NULL,
	[NHS England Region] [nvarchar](255) NULL,
	[Reason for archiving] [nvarchar](255) NULL,
	[Region] [nvarchar](255) NULL,
	[Select Service Window] [nvarchar](255) NULL,
	[STP Region (STP Details)] [nvarchar](255) NULL,
	[Surface Area] [nvarchar](255) NULL,
	[Telephone] [nvarchar](255) NULL,
	[Volume] [nvarchar](255) NULL,
	[Website] [nvarchar](255) NULL,
	[Address memo (Post)] [nvarchar](255) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Customer_Email]    Script Date: 12/04/2022 14:33:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customer_Email](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Customer Reference No] [nvarchar](255) NULL,
	[Email] [nvarchar](max) NULL,
	[SCW_BRM_Email] [nvarchar](max) NULL,
 CONSTRAINT [PK_Customer_Email] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[P1Info]    Script Date: 12/04/2022 14:33:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[P1Info](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TicketNumber] [nvarchar](255) NULL,
	[Customer] [nvarchar](255) NULL,
	[Site_Caller] [nvarchar](max) NULL,
	[TicketDate] [datetime] NULL,
	[IncidentSummary] [nvarchar](max) NULL,
	[IncidentDetail] [nvarchar](max) NULL,
	[IncidentAction] [nvarchar](max) NULL,
	[SentBy] [nvarchar](255) NULL,
	[TypeOfComs] [nvarchar](255) NULL,
	[Resolution] [nvarchar](max) NULL,
 CONSTRAINT [PK_P1Info] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/****** Object:  Table [dbo].[P1Info_Update]    Script Date: 12/04/2022 14:33:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[P1Info_Update](
	[ID_Update] [int] NULL,
	[TicketNumber] [nvarchar](255) NULL,
	[Update] [nvarchar](max) NULL,
	[NextUpdateDue] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[SCW_Email]    Script Date: 12/04/2022 14:33:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SCW_Email](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SCW_Email] [nvarchar](max) NULL,
 CONSTRAINT [PK_SCW_Email] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[SCW_SD_Team_Members]    Script Date: 12/04/2022 14:33:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SCW_SD_Team_Members](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SCW_SD_Team_Member] [nvarchar](255) NULL,
	[Hide] [nvarchar](255) NULL,
 CONSTRAINT [PK_SCW_SD_Team_Members] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Type_Of_Comms]    Script Date: 12/04/2022 14:33:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Type_Of_Comms](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type_Of_Comms] [nvarchar](255) NULL,
 CONSTRAINT [PK_Type_Of_Comms] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

