USE [master]
GO
/****** Object:  Database [nokia_xl2]    Script Date: 8/26/2023 8:41:29 AM ******/
CREATE DATABASE [nokia_xl2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'nokia_xl2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\nokia_xl2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'nokia_xl2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\nokia_xl2_log.ldf' , SIZE = 860160KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [nokia_xl2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [nokia_xl2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [nokia_xl2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [nokia_xl2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [nokia_xl2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [nokia_xl2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [nokia_xl2] SET ARITHABORT OFF 
GO
ALTER DATABASE [nokia_xl2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [nokia_xl2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [nokia_xl2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [nokia_xl2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [nokia_xl2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [nokia_xl2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [nokia_xl2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [nokia_xl2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [nokia_xl2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [nokia_xl2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [nokia_xl2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [nokia_xl2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [nokia_xl2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [nokia_xl2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [nokia_xl2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [nokia_xl2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [nokia_xl2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [nokia_xl2] SET RECOVERY FULL 
GO
ALTER DATABASE [nokia_xl2] SET  MULTI_USER 
GO
ALTER DATABASE [nokia_xl2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [nokia_xl2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [nokia_xl2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [nokia_xl2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [nokia_xl2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [nokia_xl2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [nokia_xl2] SET QUERY_STORE = OFF
GO
USE [nokia_xl2]
GO
/****** Object:  Table [dbo].[00_LIST_OAM]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[00_LIST_OAM](
	[RC] [nvarchar](5) NULL,
	[Tower Index] [nvarchar](255) NULL,
	[Tower Index (dump)] [nvarchar](255) NULL,
	[Kabupate] [nvarchar](255) NULL,
	[Kecamatan] [nvarchar](255) NULL,
	[mrbtsId] [nvarchar](10) NULL,
	[mrbts_name] [nvarchar](255) NULL,
	[bsc_name] [nchar](255) NULL,
	[BSCId] [int] NULL,
	[bcfId] [int] NULL,
	[ip_oam] [nvarchar](50) NULL,
	[cellState] [nvarchar](50) NULL,
	[sf_config] [nvarchar](255) NULL,
	[rf_config] [nvarchar](255) NULL,
	[config] [nvarchar](255) NULL,
	[detail_config] [nvarchar](255) NULL,
	[format_ws_4g] [nvarchar](255) NULL,
	[format_ws_2g] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[2G_LLD]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[2G_LLD](
	[SBTSID] [nvarchar](10) NULL,
	[Tower Index] [nvarchar](255) NULL,
	[Tower Index Final] [nvarchar](255) NULL,
	[Site ID Colo] [nvarchar](255) NULL,
	[Site ID Project (BTSWeb Existing EID)] [nvarchar](255) NULL,
	[Site ID Project (NE) MCOM Ericsson] [nvarchar](255) NULL,
	[Site ID Project (NE) Nokia] [nvarchar](255) NULL,
	[SITE NAME] [nvarchar](255) NULL,
	[BTSname (2G)] [nvarchar](255) NULL,
	[LAC_CI] [nvarchar](255) NULL,
	[BSC ID] [int] NULL,
	[BCF ID] [int] NULL,
	[BTS Id] [int] NULL,
	[BSC Name] [nvarchar](255) NULL,
	[BSC Area] [nvarchar](255) NULL,
	[CELLNAME Nokia] [nvarchar](255) NULL,
	[CGI] [nvarchar](255) NULL,
	[CELLNAME Ericsson] [nvarchar](255) NULL,
	[CELLNAME Nokia2] [nvarchar](255) NULL,
	[Sector ID] [int] NULL,
	[Band] [nvarchar](255) NULL,
	[Band_1] [float] NULL,
	[Band_2] [nvarchar](255) NULL,
	[UARFCNUPLINK] [nvarchar](255) NULL,
	[UARFCNDOWNLINK] [nvarchar](255) NULL,
	[MAXTXPOWER] [nvarchar](255) NULL,
	[PCPICHPOWER] [nvarchar](255) NULL,
	[BCCH] [float] NULL,
	[NCC] [float] NULL,
	[BCC] [float] NULL,
	[MAL] [nvarchar](255) NULL,
	[HSN] [nvarchar](255) NULL,
	[BSIC] [float] NULL,
	[maioOffset] [nvarchar](255) NULL,
	[maioStep] [nvarchar](255) NULL,
	[TCH] [nvarchar](255) NULL,
	[TCH1] [nvarchar](255) NULL,
	[TCH2] [nvarchar](255) NULL,
	[TCH3] [nvarchar](255) NULL,
	[3G_SC] [nvarchar](255) NULL,
	[LTE_PCI] [nvarchar](255) NULL,
	[LTE_RSI] [nvarchar](255) NULL,
	[TAC] [nvarchar](255) NULL,
	[LAC] [float] NULL,
	[RAC] [nvarchar](255) NULL,
	[SAC] [nvarchar](255) NULL,
	[CELLID] [float] NULL,
	[Longitude] [float] NULL,
	[Longitude DMS] [nvarchar](255) NULL,
	[Latitude] [float] NULL,
	[Latitude DMS] [nvarchar](255) NULL,
	[Azimuth Physical] [float] NULL,
	[Azimuth Logical] [float] NULL,
	[Antenna Height] [float] NULL,
	[Tower Height] [nvarchar](255) NULL,
	[Ant-Type] [nvarchar](255) NULL,
	[Ant-Size] [nvarchar](255) NULL,
	[Total Tilt] [float] NULL,
	[M-Tilt] [float] NULL,
	[E-Tilt] [float] NULL,
	[#Count_TRX] [nvarchar](255) NULL,
	[RF Module] [nvarchar](255) NULL,
	[SM Module (SRAN)] [nvarchar](255) NULL,
	[Site Type (Macro/Micro/IBS/SmallCell)] [nvarchar](255) NULL,
	[Clutter] [nvarchar](255) NULL,
	[Kecamatan] [nvarchar](255) NULL,
	[Kabupaten] [nvarchar](255) NULL,
	[Province] [nvarchar](255) NULL,
	[Area / POC] [nvarchar](255) NULL,
	[Tower Owner] [nvarchar](255) NULL,
	[Tower Type] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Tower (Existing/New Site)] [nvarchar](255) NULL,
	[Remark DRM / ERM] [nvarchar](255) NULL,
	[#Count TRX] [nvarchar](255) NULL,
	[Final Config] [nvarchar](255) NULL,
	[Temporary Config] [nvarchar](255) NULL,
	[Cluster] [nvarchar](255) NULL,
	[Phase] [nvarchar](255) NULL,
	[Ladder Final] [nvarchar](255) NULL,
	[Status Implementasi] [nvarchar](255) NULL,
	[Remark] [nvarchar](255) NULL,
	[Add Date/Update LLD] [nvarchar](255) NULL,
	[DCS Shutdown Remarks] [nvarchar](255) NULL,
	[Remarks Change CI DCS] [nvarchar](255) NULL,
	[SecID] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[4G_LLD]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[4G_LLD](
	[SBTSID] [nvarchar](10) NULL,
	[Tower Index] [nvarchar](255) NULL,
	[Tower Index Final] [nvarchar](255) NULL,
	[Site ID Colo] [float] NULL,
	[Site ID Project (BTSWeb)] [nvarchar](255) NULL,
	[Site ID Project (NE) MCOM Ericsson] [nvarchar](255) NULL,
	[Site ID Project (NE) Nokia] [nvarchar](255) NULL,
	[SITE NAME] [nvarchar](255) NULL,
	[enbName (4G)] [nvarchar](255) NULL,
	[TAC_MRBTS ID] [nvarchar](255) NULL,
	[BSC ID / RNC ID] [nvarchar](255) NULL,
	[BCF ID (2G) / WBTS ID (3G)] [nvarchar](255) NULL,
	[BTS Id (2G)] [nvarchar](255) NULL,
	[BSC / RNC Name] [nvarchar](255) NULL,
	[CGI] [nvarchar](255) NULL,
	[CELLNAME Ericsson] [nvarchar](255) NULL,
	[CELLNAME Nokia] [nvarchar](255) NULL,
	[Sector ID] [float] NULL,
	[LCRID / LNCellid] [float] NULL,
	[Band] [nvarchar](255) NULL,
	[Band_1] [float] NULL,
	[Band_2] [nvarchar](255) NULL,
	[UARFCNUPLINK] [float] NULL,
	[UARFCNDOWNLINK] [float] NULL,
	[MAXTXPOWER] [float] NULL,
	[PCPICHPOWER] [nvarchar](255) NULL,
	[BCCH] [nvarchar](255) NULL,
	[NCC] [nvarchar](255) NULL,
	[BCC] [nvarchar](255) NULL,
	[MAL] [nvarchar](255) NULL,
	[HSN] [nvarchar](255) NULL,
	[BSIC] [nvarchar](255) NULL,
	[maioOffset] [nvarchar](255) NULL,
	[maioStep] [nvarchar](255) NULL,
	[TCH] [nvarchar](255) NULL,
	[3G_SC] [nvarchar](255) NULL,
	[LTE_PCI] [float] NULL,
	[LTE_RSI] [float] NULL,
	[TAC] [float] NULL,
	[LAC] [nvarchar](255) NULL,
	[RAC] [nvarchar](255) NULL,
	[SAC] [nvarchar](255) NULL,
	[MRBTSID / LNBTSID (eNodeB ID)] [float] NULL,
	[Longitude] [float] NULL,
	[Longitude DMS] [nvarchar](255) NULL,
	[Latitude] [float] NULL,
	[Latitude DMS] [nvarchar](255) NULL,
	[Azimuth Physical] [float] NULL,
	[Azimuth Logical] [float] NULL,
	[Antenna Height] [float] NULL,
	[Tower Height] [nvarchar](255) NULL,
	[Current Ant-Type] [nvarchar](255) NULL,
	[Ant-Size] [nvarchar](255) NULL,
	[Beam] [nvarchar](255) NULL,
	[Total Tilt] [float] NULL,
	[M-Tilt] [float] NULL,
	[E-Tilt] [float] NULL,
	[Remarks RET] [nvarchar](255) NULL,
	[MIMO Mode] [nvarchar](255) NULL,
	[RF Module] [nvarchar](255) NULL,
	[SM Module (SRAN)] [nvarchar](255) NULL,
	[Site Type (Macro/Micro/IBS/SmallCell)] [nvarchar](255) NULL,
	[Clutter] [nvarchar](255) NULL,
	[Kecamatan] [nvarchar](255) NULL,
	[Kabupaten] [nvarchar](255) NULL,
	[Province] [nvarchar](255) NULL,
	[Area / POC] [nvarchar](255) NULL,
	[Tower Owner] [nvarchar](255) NULL,
	[Tower Type] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Tower (Existing/New Site)] [nvarchar](255) NULL,
	[Remark DRM / ERM] [nvarchar](255) NULL,
	[Final Config] [nvarchar](255) NULL,
	[Temporary Config] [nvarchar](255) NULL,
	[Cluster] [nvarchar](255) NULL,
	[Phase] [nvarchar](255) NULL,
	[Ladder Final] [nvarchar](255) NULL,
	[Status OA] [nvarchar](255) NULL,
	[Remark] [nvarchar](255) NULL,
	[Add Date/Update LLD] [nvarchar](255) NULL,
	[SecID] [nvarchar](255) NULL,
	[Remarks] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_BCF]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_BCF](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[BSCId] [int] NOT NULL,
	[BCFId] [int] NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[name] [nvarchar](100) NULL,
	[btsMPlaneIpAddress] [nvarchar](50) NULL,
	[btsSubnetMasklengthMplane] [int] NULL,
	[btsCuPlaneIpAddress] [nvarchar](50) NULL,
	[btsSubnetMasklengthCUplane] [int] NULL,
	[adminState] [int] NULL,
 CONSTRAINT [PK_A_BCF_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_BSC]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_BSC](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[BSCId] [int] NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[name] [nvarchar](100) NULL,
	[neSwRelease] [nvarchar](50) NULL,
 CONSTRAINT [PK_A_BSC_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_BTS]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_BTS](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[BSCId] [int] NOT NULL,
	[BCFId] [int] NOT NULL,
	[BTSId] [int] NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NULL,
	[frequencyBandInUse] [int] NULL,
	[cellId] [float] NULL,
	[locationAreaIdLAC] [int] NULL,
	[locationAreaIdMCC] [int] NULL,
	[locationAreaIdMNC] [int] NULL,
	[nwName] [nvarchar](100) NULL,
	[rac] [int] NULL,
	[sectorId] [int] NULL,
	[segmentId] [int] NULL,
	[segmentName] [nvarchar](100) NULL,
	[adminState] [int] NULL,
 CONSTRAINT [PK_A_BTS_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_EQM_EQM_APEQM_CABINET_BBMOD]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_EQM_EQM_APEQM_CABINET_BBMOD](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[eqmId] [int] NULL,
	[apeqmId] [int] NULL,
	[cabinetId] [int] NULL,
	[bbmodId] [int] NULL,
	[distName] [nvarchar](255) NOT NULL,
	[administrativeState] [int] NULL,
	[prodCodePlanned] [nvarchar](50) NULL,
 CONSTRAINT [PK_A_EQM_EQM_APEQM_CABINET_BBMOD_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_EQM_EQM_APEQM_CABINET_SMOD]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_EQM_EQM_APEQM_CABINET_SMOD](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[eqmId] [int] NOT NULL,
	[apeqmId] [int] NOT NULL,
	[cabinetId] [int] NOT NULL,
	[smodId] [int] NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[prodCodePlanned] [nvarchar](50) NULL,
 CONSTRAINT [PK_A_EQM_EQM_APEQM_CABINET_SMOD_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_EQM_MRBTS_EQM_APEQM_RMOD]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_EQM_MRBTS_EQM_APEQM_RMOD](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[eqmId] [int] NOT NULL,
	[apeqmId] [int] NOT NULL,
	[rmodId] [int] NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[administrativeState] [int] NULL,
	[prodCodePlanned] [nvarchar](50) NULL,
 CONSTRAINT [PK_A_EQM_MRBTS_EQM_APEQM_RMOD_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_EQM_R_APEQM_R_CABINET_R_BBMOD_R]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_EQM_R_APEQM_R_CABINET_R_BBMOD_R](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[eqm_r_Id] [int] NULL,
	[apeqm_r_Id] [int] NULL,
	[cabinet_r_Id] [int] NULL,
	[bbmod_r_Id] [int] NULL,
	[distName] [nvarchar](255) NOT NULL,
	[administrativeState] [int] NULL,
	[configDN] [nvarchar](max) NULL,
	[operationalState] [int] NULL,
	[proceduralStatus] [int] NULL,
	[productCode] [nvarchar](50) NULL,
	[productName] [nvarchar](50) NULL,
	[serialNumber] [nvarchar](50) NULL,
 CONSTRAINT [PK_A_EQM_R_APEQM_R_CABINET_R_BBMOD_R_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_EQM_R_APEQM_R_CABINET_R_SMOD_R]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_EQM_R_APEQM_R_CABINET_R_SMOD_R](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[eqm_r_Id] [int] NULL,
	[apeqm_r_Id] [int] NULL,
	[cabinet_r_Id] [int] NULL,
	[smod_r_Id] [int] NULL,
	[distName] [nvarchar](255) NOT NULL,
	[configDN] [nvarchar](max) NULL,
	[operationalState] [int] NULL,
	[proceduralStatus] [int] NULL,
	[productCode] [nvarchar](50) NULL,
	[productName] [nvarchar](50) NULL,
	[serialNumber] [nvarchar](50) NULL,
 CONSTRAINT [PK_A_EQM_R_APEQM_R_CABINET_R_SMOD_R_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_EQM_R_APEQM_R_RMOD_R]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_EQM_R_APEQM_R_RMOD_R](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[eqm_r_Id] [int] NULL,
	[apeqm_r_Id] [int] NULL,
	[rmod_r_id] [int] NULL,
	[distName] [nvarchar](255) NOT NULL,
	[administrativeState] [int] NULL,
	[chassisProductCode] [nvarchar](50) NULL,
	[chassisSerialNumber] [nvarchar](50) NULL,
	[configDN] [nvarchar](255) NULL,
	[operationalState] [int] NULL,
	[outputPowerWattsCap] [int] NULL,
	[proceduralStatus] [int] NULL,
	[productCode] [nvarchar](50) NULL,
	[productName] [nvarchar](50) NULL,
	[rfmTransmitModeStatus] [int] NULL,
	[serialNumber] [nvarchar](50) NULL,
	[usageState] [int] NULL,
	[vendorName] [nvarchar](50) NULL,
 CONSTRAINT [PK_A_EQM_R_APEQM_R_RMOD_R_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_EQM_R_APEQM_R_RMOD_R_ANTL_R]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_EQM_R_APEQM_R_RMOD_R_ANTL_R](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[eqm_r_id] [int] NULL,
	[apeqm_r_id] [int] NULL,
	[rmod_r_id] [int] NULL,
	[antl_r_id] [int] NULL,
	[distName] [nvarchar](255) NOT NULL,
	[configDN] [nvarchar](255) NULL,
 CONSTRAINT [PK_A_EQM_R_APEQM_R_RMOD_R_ANTL_R_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_GNBCF]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_GNBCF](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[gnbtsId] [int] NULL,
	[gnbcfId] [int] NULL,
	[distName] [nvarchar](255) NOT NULL,
	[bscId] [int] NOT NULL,
	[bcfId] [int] NOT NULL,
	[mPlaneLocalIpAddressDN] [nvarchar](255) NULL,
	[mPlaneRemoteIpAddressOmuSig] [nvarchar](255) NULL,
 CONSTRAINT [PK_A_GNBCF_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_LTE_MRBTS_LNBTS]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_LTE_MRBTS_LNBTS](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[lnBtsId] [int] NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[mcc] [int] NULL,
	[mnc] [int] NULL,
	[name] [nvarchar](255) NULL,
	[enbName] [nvarchar](100) NULL,
	[operationalState] [int] NULL,
 CONSTRAINT [PK_A_LTE_MRBTS_LNBTS] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_LTE_MRBTS_LNBTS_LNCEL]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_LTE_MRBTS_LNBTS_LNCEL](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[lnBtsId] [int] NOT NULL,
	[lnCelId] [int] NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[mcc] [int] NULL,
	[mnc] [int] NULL,
	[name] [nvarchar](255) NULL,
	[cellName] [nvarchar](100) NULL,
	[administrativeState] [int] NULL,
	[energySavingState] [int] NULL,
	[operationalState] [int] NULL,
 CONSTRAINT [PK_A_LTE_MRBTS_LNBTS_LNCEL] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_LTE_MRBTS_LNBTS_LNCEL_LNCEL_FDD]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_LTE_MRBTS_LNBTS_LNCEL_LNCEL_FDD](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[lnBtsId] [int] NOT NULL,
	[lnCelId] [int] NOT NULL,
	[lnCell_fdd_Id] [int] NULL,
	[distName] [nvarchar](250) NOT NULL,
	[dlChBw] [float] NOT NULL,
	[dlMimoMode] [float] NULL,
	[earfcnDL] [float] NULL,
	[earfcnUL] [float] NULL,
	[ulChBw] [float] NULL,
 CONSTRAINT [PK_A_LTE_MRBTS_LNBTS_LNCEL_LNCEL_FDD_1] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_MNL_CELLMAPPING_LCELL_CHANNELGROUP_CHANNEL]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_MNL_CELLMAPPING_LCELL_CHANNELGROUP_CHANNEL](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[mnlId] [int] NOT NULL,
	[mnlEntId] [int] NOT NULL,
	[cellmappingId] [int] NOT NULL,
	[lCellId] [int] NOT NULL,
	[channelGroupId] [int] NOT NULL,
	[channelId] [int] NOT NULL,
	[distName] [nvarchar](450) NOT NULL,
	[antlDN] [nvarchar](450) NULL,
	[direction] [int] NULL,
 CONSTRAINT [PK_A_MNL_CELLMAPPING_LCELL_CHANNELGROUP_CHANNEL] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_MNL_MRBTS_MNL_MNLENT_MPLANENW]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_MNL_MRBTS_MNL_MNLENT_MPLANENW](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[mnlId] [int] NULL,
	[mnlentId] [int] NULL,
	[mplanenwId] [int] NULL,
	[distName] [nvarchar](255) NOT NULL,
	[mPlaneIpv4AddressDN] [nvarchar](255) NULL,
	[oamTls] [int] NULL,
 CONSTRAINT [PK_A_MNL_MRBTS_MNL_MNLENT_MPLANENW] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_MRBTS]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_MRBTS](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NULL,
	[btsName] [nvarchar](100) NULL,
	[siteId] [nvarchar](100) NULL,
 CONSTRAINT [PK_A_MRBTS] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_MRBTSDESC]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_MRBTSDESC](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[MRBTSDESC] [int] NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[integrationInfo] [nvarchar](50) NULL,
 CONSTRAINT [PK_A_MRBTSDESC] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_TNL_TNL_ETHSVC_ETHIF_VLANIF]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_TNL_TNL_ETHSVC_ETHIF_VLANIF](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[tnlsvcId] [int] NULL,
	[tnlId] [int] NULL,
	[ethsvcId] [int] NULL,
	[ethIf] [int] NULL,
	[vlanIfId] [int] NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[userLabel] [nvarchar](255) NULL,
	[vlanId] [int] NULL,
 CONSTRAINT [PK_A_TNL_TNL_ETHSVC_ETHIF_VLANIF] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_TNL_TNL_IPNO_IPIF_IPADDRESSV4]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_TNL_TNL_IPNO_IPIF_IPADDRESSV4](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[tnlsvcId] [int] NULL,
	[tnlId] [int] NULL,
	[ipnoId] [int] NULL,
	[ipIfId] [int] NOT NULL,
	[ipAddV4Id] [int] NULL,
	[distName] [nvarchar](255) NOT NULL,
	[localIpAddr] [nvarchar](100) NULL,
	[localIpPrefixLength] [int] NULL,
 CONSTRAINT [PK_A_TNL_TNL_IPNO_IPIF_IPADDRESSV4] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[A_TNL_TNLSVC_TNL_IPNO_IPIF]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[A_TNL_TNLSVC_TNL_IPNO_IPIF](
	[rc] [nvarchar](5) NULL,
	[class] [nvarchar](255) NULL,
	[version] [nvarchar](50) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[tnlsvcId] [int] NULL,
	[tnlId] [int] NULL,
	[ipnoId] [int] NULL,
	[ipIfId] [int] NOT NULL,
	[distName] [nvarchar](255) NOT NULL,
	[interfaceDN] [nvarchar](255) NULL,
	[ipMtu] [int] NULL,
	[userLabel] [nvarchar](100) NULL,
 CONSTRAINT [PK_A_TNL_TNLSVC_TNL_IPNO_IPIF] PRIMARY KEY CLUSTERED 
(
	[distName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHECK_ActiveAlarm]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHECK_ActiveAlarm](
	[Tower Index] [nvarchar](50) NULL,
	[mrbts_name] [nvarchar](250) NULL,
	[mrbts_id] [nvarchar](10) NULL,
	[obj_name1] [nvarchar](50) NULL,
	[mrbtsId_bscId] [nvarchar](10) NULL,
	[obj_name2] [nvarchar](50) NULL,
	[bcfId] [int] NULL,
	[Notification ID] [nvarchar](255) NULL,
	[Alarm Number] [float] NULL,
	[Alarm Type] [nvarchar](255) NULL,
	[Severity] [nvarchar](255) NULL,
	[Alarm Time] [datetime] NULL,
	[Probable Cause] [nvarchar](255) NULL,
	[Probable Cause Code] [float] NULL,
	[Alarm Text] [nvarchar](255) NULL,
	[Distinguished Name] [nvarchar](255) NULL,
	[Object Class] [nvarchar](255) NULL,
	[Acknowledgement State] [nvarchar](50) NULL,
	[Acknowledgement Time/UnAcknowledgement Time] [nvarchar](255) NULL,
	[Acknowledgement User] [nvarchar](255) NULL,
	[Cancel State] [nvarchar](50) NULL,
	[Cancel Time] [nvarchar](255) NULL,
	[Cancel User] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Maintenance Region Name] [nvarchar](255) NULL,
	[Site Name] [nvarchar](255) NULL,
	[Site Priority] [nvarchar](255) NULL,
	[Site Address] [nvarchar](255) NULL,
	[Extra Information] [nvarchar](255) NULL,
	[Diagnostic Info] [nvarchar](max) NULL,
	[User Additional Information] [nvarchar](255) NULL,
	[Supplementary Information] [nvarchar](max) NULL,
	[Additional Information 1] [nvarchar](255) NULL,
	[Additional Information 2] [nvarchar](255) NULL,
	[Additional Information 3] [nvarchar](255) NULL,
	[Correlation Indicator] [nvarchar](50) NULL,
	[Notes Indicator] [nvarchar](50) NULL,
	[Trouble Ticket Indicator] [nvarchar](255) NULL,
	[Alarm Sound] [nvarchar](50) NULL,
	[Instance Counter] [float] NULL,
	[Consecutive Number] [float] NULL,
	[Alarm Insertion Time] [datetime] NULL,
	[Alarm Update Time] [datetime] NULL,
	[Controlling Object Name] [nvarchar](255) NULL,
	[Origin Alarm Time] [nvarchar](255) NULL,
	[Origin Alarm Update Time] [nvarchar](255) NULL,
	[Origin Acknowledgement/UnAcknowledgement Time] [nvarchar](255) NULL,
	[Origin Cancel Time] [nvarchar](255) NULL,
	[Related DN's] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHECK_AlarmHistory]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHECK_AlarmHistory](
	[Tower Index] [nvarchar](50) NULL,
	[mrbts_name] [nvarchar](255) NULL,
	[mrbts_id] [nvarchar](10) NULL,
	[obj_name1] [nvarchar](50) NULL,
	[mrbtsId_bscId] [nvarchar](10) NULL,
	[obj_name2] [nvarchar](50) NULL,
	[bcfId] [int] NULL,
	[Notification ID] [nvarchar](255) NULL,
	[Alarm Number] [float] NULL,
	[Alarm Type] [nvarchar](255) NULL,
	[Severity] [nvarchar](255) NULL,
	[Alarm Time] [datetime] NULL,
	[Probable Cause] [nvarchar](255) NULL,
	[Probable Cause Code] [float] NULL,
	[Alarm Text] [nvarchar](255) NULL,
	[Distinguished Name] [nvarchar](255) NULL,
	[Object Class] [nvarchar](255) NULL,
	[Acknowledgement State] [nvarchar](50) NULL,
	[Acknowledgement Time/UnAcknowledgement Time] [nvarchar](255) NULL,
	[Acknowledgement User] [nvarchar](255) NULL,
	[Cancel State] [nvarchar](50) NULL,
	[Cancel Time] [datetime] NULL,
	[Cancel User] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Maintenance Region Name] [nvarchar](255) NULL,
	[Site Name] [nvarchar](255) NULL,
	[Site Priority] [nvarchar](255) NULL,
	[Site Address] [nvarchar](255) NULL,
	[Extra Information] [nvarchar](255) NULL,
	[Diagnostic Info] [nvarchar](max) NULL,
	[User Additional Information] [nvarchar](255) NULL,
	[Supplementary Information] [nvarchar](max) NULL,
	[Additional Information 1] [nvarchar](255) NULL,
	[Additional Information 2] [nvarchar](255) NULL,
	[Additional Information 3] [nvarchar](255) NULL,
	[Correlation Indicator] [nvarchar](50) NULL,
	[Notes Indicator] [nvarchar](50) NULL,
	[Trouble Ticket Indicator] [nvarchar](255) NULL,
	[Alarm Sound] [nvarchar](50) NULL,
	[Instance Counter] [float] NULL,
	[Consecutive Number] [float] NULL,
	[Alarm Insertion Time] [datetime] NULL,
	[Alarm Update Time] [datetime] NULL,
	[Controlling Object Name] [nvarchar](255) NULL,
	[Origin Alarm Time] [nvarchar](255) NULL,
	[Origin Alarm Update Time] [nvarchar](255) NULL,
	[Origin Acknowledgement/UnAcknowledgement Time] [nvarchar](255) NULL,
	[Origin Cancel Time] [nvarchar](255) NULL,
	[Related DN's] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHECK_AlarmHistory_ftp]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHECK_AlarmHistory_ftp](
	[mrbts_name] [nvarchar](250) NULL,
	[mrbts_id] [nvarchar](10) NULL,
	[obj_name1] [nvarchar](50) NULL,
	[mrbtsId_bscId] [nvarchar](10) NULL,
	[obj_name2] [nvarchar](50) NULL,
	[bcfId] [int] NULL,
	[CONSEC_NBR] [float] NULL,
	[ALARM_NUMBER] [float] NULL,
	[ALARM_TYPE] [nvarchar](255) NULL,
	[SEVERITY] [nvarchar](255) NULL,
	[DN] [nvarchar](255) NULL,
	[LIFTED_DN] [nvarchar](255) NULL,
	[NAME] [nvarchar](255) NULL,
	[ALARM_TEXT] [nvarchar](255) NULL,
	[ALARM_TIME] [datetime] NULL,
	[ACK_STATUS] [nvarchar](255) NULL,
	[ACT_TIME] [datetime] NULL,
	[ACKED_BY] [nvarchar](255) NULL,
	[CANCEL_TIME] [datetime] NULL,
	[SUPPLEMENTARY_INFO] [nvarchar](max) NULL,
	[DIAGNOSTIC_INFO] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEAS_2G_AVAIL_H]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEAS_2G_AVAIL_H](
	[PERIOD_START_TIME] [datetime] NOT NULL,
	[BSC name] [nvarchar](255) NULL,
	[BCF name] [nvarchar](255) NULL,
	[BTS name] [nvarchar](255) NULL,
	[BSCId] [int] NOT NULL,
	[BCFId] [int] NOT NULL,
	[BTSId] [int] NOT NULL,
	[DN] [nvarchar](255) NOT NULL,
	[TCH_Availability_Num] [float] NULL,
	[TCH_Availability_Den] [float] NULL,
 CONSTRAINT [PK_MEAS_2G_AVAIL_H] PRIMARY KEY CLUSTERED 
(
	[PERIOD_START_TIME] ASC,
	[DN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEAS_4G_AVAIL_H]    Script Date: 8/26/2023 8:41:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEAS_4G_AVAIL_H](
	[PERIOD_START_TIME] [datetime] NOT NULL,
	[MRBTS name] [nvarchar](255) NULL,
	[LNBTS name] [nvarchar](255) NULL,
	[LNCEL name] [nvarchar](255) NULL,
	[mrbtsId] [nvarchar](10) NOT NULL,
	[lnBtsId] [int] NOT NULL,
	[lnCelId] [int] NOT NULL,
	[DN] [nvarchar](255) NOT NULL,
	[Radio_Network_Avail_Num] [float] NULL,
	[Radio_Network_Avail_Den] [float] NULL,
 CONSTRAINT [PK_MEAS_4G] PRIMARY KEY CLUSTERED 
(
	[PERIOD_START_TIME] ASC,
	[DN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [nokia_xl2] SET  READ_WRITE 
GO
