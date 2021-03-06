USE [master]
GO
/****** Object:  Database [DbKhoaHocTrucTuyen]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE DATABASE [DbKhoaHocTrucTuyen]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DbKhoaHocTrucTuyen', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DbKhoaHocTrucTuyen.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DbKhoaHocTrucTuyen_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DbKhoaHocTrucTuyen_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DbKhoaHocTrucTuyen].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET ARITHABORT OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET RECOVERY FULL 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET  MULTI_USER 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DbKhoaHocTrucTuyen', N'ON'
GO
USE [DbKhoaHocTrucTuyen]
GO
USE [DbKhoaHocTrucTuyen]
GO
/****** Object:  Sequence [dbo].[KhoaHocSequence]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE SEQUENCE [dbo].[KhoaHocSequence] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivateCourses]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivateCourses](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[CourseId] [int] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_ActivateCourses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Announcements]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Announcements](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Image] [nvarchar](max) NULL,
	[EntityType] [nvarchar](max) NULL,
	[EntityId] [nvarchar](max) NULL,
	[UserId] [uniqueidentifier] NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Announcements] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AnnouncementUsers]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AnnouncementUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[HasRead] [bit] NULL,
	[AnnouncementId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AnnouncementUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Avatar] [nvarchar](max) NULL,
	[Dob] [datetime2](7) NOT NULL,
	[Biography] [nvarchar](max) NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[SortOrder] [int] NOT NULL,
	[ParentId] [int] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommandInFunctions]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommandInFunctions](
	[CommandId] [nvarchar](450) NOT NULL,
	[FunctionId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_CommandInFunctions] PRIMARY KEY CLUSTERED 
(
	[CommandId] ASC,
	[FunctionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Commands]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Commands](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Commands] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[EntityId] [int] NOT NULL,
	[EntityType] [nvarchar](max) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ReplyId] [int] NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Price] [bigint] NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[Status] [int] NOT NULL,
	[CategoryId] [int] NULL,
	[CreatedUserName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeedBacks]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedBacks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
 CONSTRAINT [PK__Feedback__3214EC0776104779] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Functions]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Functions](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Url] [nvarchar](max) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[ParentId] [nvarchar](max) NULL,
	[Icon] [varchar](100) NULL,
 CONSTRAINT [PK_Functions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lessons]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lessons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[VideoPath] [nvarchar](max) NOT NULL,
	[Attachment] [nvarchar](max) NULL,
	[SortOrder] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[Times] [nvarchar](max) NULL,
 CONSTRAINT [PK_Lessons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderId] [int] NOT NULL,
	[ActiveCourseId] [uniqueidentifier] NOT NULL,
	[Price] [bigint] NULL,
	[PromotionPrice] [bigint] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[ActiveCourseId] ASC,
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PaymentMethod] [int] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[Total] [bigint] NULL,
	[Name] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[LastModificationTime] [datetime2](7) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[FunctionId] [nvarchar](450) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[CommandId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[CommandId] ASC,
	[FunctionId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PromotionInCourses]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromotionInCourses](
	[PromotionId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
 CONSTRAINT [PK_PromotionInCourses] PRIMARY KEY CLUSTERED 
(
	[PromotionId] ASC,
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotions]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FromDate] [datetime2](7) NOT NULL,
	[ToDate] [datetime2](7) NOT NULL,
	[ApplyForAll] [bit] NOT NULL,
	[DiscountPercent] [int] NULL,
	[DiscountAmount] [bigint] NULL,
	[Status] [bit] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Content] [nvarchar](max) NULL,
 CONSTRAINT [PK_Promotions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20201126023139_initialize', N'3.1.9')
GO
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'e0011b41-1f3f-4f4e-9740-1498e7a3c9cd', N'b26bfa57-0085-4338-a612-5acba6c4586e', 32, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'73844cab-f6f7-42a5-aeb0-17919013aeb2', N'b26bfa57-0085-4338-a612-5acba6c4586e', 65, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'df2896ef-8f51-4491-b0a1-2c17a3fe3811', N'b26bfa57-0085-4338-a612-5acba6c4586e', 3, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'36a9b19a-d18a-4855-b0b3-3178c197cbbb', N'b26bfa57-0085-4338-a612-5acba6c4586e', 62, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'da78cd7f-436a-4225-9816-33f8c995dcf9', N'b26bfa57-0085-4338-a612-5acba6c4586e', 63, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'bf15ad46-9ea9-4653-add1-37fd0c476a2d', N'b26bfa57-0085-4338-a612-5acba6c4586e', 7, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'8c75df70-b9d9-485d-b9e0-442062163d35', N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'14cffa13-a289-4d14-99b4-514e84cc04bc', N'b26bfa57-0085-4338-a612-5acba6c4586e', 14, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'8cbe4c46-571a-4e19-b191-603f916b5644', N'b26bfa57-0085-4338-a612-5acba6c4586e', 33, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'4c33e277-cbaa-4749-b600-6378e6e2f72b', N'b26bfa57-0085-4338-a612-5acba6c4586e', 61, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'66525d28-4ae4-46bf-a578-668bf5115bd6', N'b26bfa57-0085-4338-a612-5acba6c4586e', 10, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'75a47213-19e1-4846-b453-775ffea8c9d0', N'b26bfa57-0085-4338-a612-5acba6c4586e', 64, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'2ee37379-ae6f-4908-a8db-996b0ffdbae5', N'b26bfa57-0085-4338-a612-5acba6c4586e', 12, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'00d20a40-6535-41f2-94b0-acfca96b42e4', N'b26bfa57-0085-4338-a612-5acba6c4586e', 2, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'75119fe3-4f68-4d7b-ba6b-cb0510e7b53c', N'b26bfa57-0085-4338-a612-5acba6c4586e', 17, 0)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'62a85d59-737e-4f92-aa63-cdf658b41a4c', NULL, 24, 0)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'145027b7-2d34-464f-a58c-d5f76ac62a92', N'b26bfa57-0085-4338-a612-5acba6c4586e', 11, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'2d5699b0-47c3-4886-b157-e6425708f8f5', N'b26bfa57-0085-4338-a612-5acba6c4586e', 9, 1)
INSERT [dbo].[ActivateCourses] ([Id], [UserId], [CourseId], [Status]) VALUES (N'd57e28a9-f361-4a6a-9024-f3f822955f74', N'c397abed-4dad-4764-9850-27c274db055a', 11, 1)
GO
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'183b4a43-4c4f-4527-a1c8-08fb8ec8d523', N'Thông báo đơn hàng', N'Đơn hàng của bạn đã được giao', N'images/defaultAvatar.png', N'orders', N'12', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-14T13:01:34.1742945' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'931892ed-2a5d-44f0-bc0b-0c73ba5c97f2', N'Event 321', N'Giam Gia', N'images/defaultAvatar.png', N'promotion', N'5', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-14T11:26:25.9759351' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'682eac88-bc6c-4914-a0ae-0cca33e2c386', N'Thông báo đơn hàng', N'Đơn hàng của bạn đã được giao', N'images/defaultAvatar.png', N'orders', N'9', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-13T22:37:34.7262031' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'3bcfb9a4-5dad-4e28-b252-14829e6b3852', N'Bài học đã được duyệt', N'Trần Bảo Long đã duyệt bài Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'images/react-native.png', N'lessons', N'1', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-14T10:16:03.8975205' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'ca8376f8-a80a-449d-abd3-245aac23e9bf', N'Thông báo đơn hàng', N'Đơn hàng của bạn đã được giao', N'images/defaultAvatar.png', N'orders', N'11', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-13T22:44:06.8927504' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'65574473-d1ff-4553-ac15-5687386dd533', N'Thông báo đơn hàng', N'Đơn hàng của bạn đã được giao', N'images/defaultAvatar.png', N'orders', N'7', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-13T22:30:03.6090741' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'e92bd9e5-5699-4ffc-882f-a8b40c4b947a', N'Thông báo đơn hàng mới', N'Bạn có 1 đơn hàng mới từ sgsdgsdg với tin nhắn: dhdfhfdh', N'images/defaultAvatar.png', N'orders', N'5', NULL, CAST(N'2021-01-13T13:42:15.0011787' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'a26e81ac-2684-49d1-907a-b2d6800fda6e', N'Event 321', N'Giam Gia', N'images/defaultAvatar.png', N'promotion', N'5', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-13T12:32:14.1545776' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'0aa28da0-ec32-48b8-9a0d-d0e326593cde', N'Thông báo đơn hàng', N'Đơn hàng của bạn đã được giao', N'images/defaultAvatar.png', N'orders', N'10', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-13T22:41:23.4602443' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'09763944-c8c5-44ca-b03d-d441140d1531', N'Event 321', N'Giam Gia', N'images/defaultAvatar.png', N'promotion', N'5', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-14T11:26:39.6087208' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'c5235e76-3299-42e5-a7b2-d76886f6cd20', N'Event 1', N'Giam Gia 50%', N'images/defaultAvatar.png', N'promotion', N'1', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-14T11:26:04.7598555' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'3e1f2a54-803f-4cb7-ad2a-e345bd24fe52', N'Khóa học đã được duyệt', N'Trần Bảo Long đã duyệt khóa học Học tiếng Nhật thật dễ', N'images/hoc-tieng-nhat-that-de_m_1555562005.jpg', N'courses', N'9', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-14T09:32:43.1763018' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'30817911-7ab4-465e-b13d-eeca5e783bfd', N'Thông báo đơn hàng mới', N'Bạn có 1 đơn hàng mới từ sgsdgs với tin nhắn: shgsdhsh', N'images/defaultAvatar.png', N'orders', N'13', NULL, CAST(N'2021-01-14T13:07:00.9618550' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'8c193f5d-943e-4245-8595-f3a525c1aa43', N'Event 321', N'Giam Gia', N'images/defaultAvatar.png', N'promotion', N'5', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-14T11:26:19.2652311' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'471ff570-e028-4258-b822-f55ccda213c7', N'Thông báo đơn hàng', N'Đơn hàng của bạn đã được giao', N'images/defaultAvatar.png', N'orders', N'8', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-13T22:34:28.2533423' AS DateTime2), NULL, 1)
INSERT [dbo].[Announcements] ([Id], [Title], [Content], [Image], [EntityType], [EntityId], [UserId], [CreationTime], [LastModificationTime], [Status]) VALUES (N'02b6dd1e-a389-4f0a-917f-f7b3f118718b', N'Thông báo đơn hàng', N'Đơn hàng của bạn đã được giao', N'images/defaultAvatar.png', N'orders', N'6', N'b26bfa57-0085-4338-a612-5acba6c4586e', CAST(N'2021-01-13T22:27:15.1391271' AS DateTime2), NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[AnnouncementUsers] ON 

INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (50, N'84f9655a-01bb-478e-a200-25ca5489948e', 0, N'a26e81ac-2684-49d1-907a-b2d6800fda6e')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (51, N'c397abed-4dad-4764-9850-27c274db055a', 1, N'a26e81ac-2684-49d1-907a-b2d6800fda6e')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (52, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'a26e81ac-2684-49d1-907a-b2d6800fda6e')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (53, N'32fcfdc3-7d98-4489-b81a-88cff6e1b438', 0, N'a26e81ac-2684-49d1-907a-b2d6800fda6e')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (54, N'f2cd918e-053a-4b2e-84b0-e5bcf9b804a8', 0, N'a26e81ac-2684-49d1-907a-b2d6800fda6e')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (55, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'e92bd9e5-5699-4ffc-882f-a8b40c4b947a')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (56, N'b26bfa57-0085-4338-a612-5acba6c4586e', 0, N'02b6dd1e-a389-4f0a-917f-f7b3f118718b')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (57, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'65574473-d1ff-4553-ac15-5687386dd533')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (58, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'471ff570-e028-4258-b822-f55ccda213c7')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (59, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'682eac88-bc6c-4914-a0ae-0cca33e2c386')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (60, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'0aa28da0-ec32-48b8-9a0d-d0e326593cde')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (61, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'ca8376f8-a80a-449d-abd3-245aac23e9bf')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (62, N'f2cd918e-053a-4b2e-84b0-e5bcf9b804a8', 0, N'3e1f2a54-803f-4cb7-ad2a-e345bd24fe52')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (63, N'f2cd918e-053a-4b2e-84b0-e5bcf9b804a8', 0, N'3bcfb9a4-5dad-4e28-b252-14829e6b3852')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (64, N'c397abed-4dad-4764-9850-27c274db055a', 0, N'c5235e76-3299-42e5-a7b2-d76886f6cd20')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (65, N'a42b3a07-6e37-482a-aeb8-4fc9b6889e78', 0, N'c5235e76-3299-42e5-a7b2-d76886f6cd20')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (66, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'c5235e76-3299-42e5-a7b2-d76886f6cd20')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (67, N'32fcfdc3-7d98-4489-b81a-88cff6e1b438', 0, N'c5235e76-3299-42e5-a7b2-d76886f6cd20')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (68, N'f2cd918e-053a-4b2e-84b0-e5bcf9b804a8', 0, N'c5235e76-3299-42e5-a7b2-d76886f6cd20')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (69, N'c397abed-4dad-4764-9850-27c274db055a', 0, N'8c193f5d-943e-4245-8595-f3a525c1aa43')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (70, N'a42b3a07-6e37-482a-aeb8-4fc9b6889e78', 0, N'8c193f5d-943e-4245-8595-f3a525c1aa43')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (71, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'8c193f5d-943e-4245-8595-f3a525c1aa43')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (72, N'32fcfdc3-7d98-4489-b81a-88cff6e1b438', 0, N'8c193f5d-943e-4245-8595-f3a525c1aa43')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (73, N'f2cd918e-053a-4b2e-84b0-e5bcf9b804a8', 0, N'8c193f5d-943e-4245-8595-f3a525c1aa43')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (74, N'c397abed-4dad-4764-9850-27c274db055a', 0, N'931892ed-2a5d-44f0-bc0b-0c73ba5c97f2')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (75, N'a42b3a07-6e37-482a-aeb8-4fc9b6889e78', 0, N'931892ed-2a5d-44f0-bc0b-0c73ba5c97f2')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (76, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'931892ed-2a5d-44f0-bc0b-0c73ba5c97f2')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (77, N'32fcfdc3-7d98-4489-b81a-88cff6e1b438', 0, N'931892ed-2a5d-44f0-bc0b-0c73ba5c97f2')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (78, N'f2cd918e-053a-4b2e-84b0-e5bcf9b804a8', 0, N'931892ed-2a5d-44f0-bc0b-0c73ba5c97f2')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (79, N'c397abed-4dad-4764-9850-27c274db055a', 0, N'09763944-c8c5-44ca-b03d-d441140d1531')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (80, N'a42b3a07-6e37-482a-aeb8-4fc9b6889e78', 0, N'09763944-c8c5-44ca-b03d-d441140d1531')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (81, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1, N'09763944-c8c5-44ca-b03d-d441140d1531')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (82, N'32fcfdc3-7d98-4489-b81a-88cff6e1b438', 0, N'09763944-c8c5-44ca-b03d-d441140d1531')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (83, N'f2cd918e-053a-4b2e-84b0-e5bcf9b804a8', 0, N'09763944-c8c5-44ca-b03d-d441140d1531')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (84, N'b26bfa57-0085-4338-a612-5acba6c4586e', 0, N'183b4a43-4c4f-4527-a1c8-08fb8ec8d523')
INSERT [dbo].[AnnouncementUsers] ([Id], [UserId], [HasRead], [AnnouncementId]) VALUES (85, N'b26bfa57-0085-4338-a612-5acba6c4586e', 0, N'30817911-7ab4-465e-b13d-eeca5e783bfd')
SET IDENTITY_INSERT [dbo].[AnnouncementUsers] OFF
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Admin', N'ADMIN', N'0fb6d1fc-3405-4b57-bc71-1385504a3e33')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'c41a478e-0323-4243-ae99-85909be34de4', N'Teacher', N'TEACHER', N'485435a1-7d31-4254-8bf1-d92ec2728ee2')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Student', N'STUDENT', N'27f90fe0-6b77-46fa-9dbd-9e47aeab8982')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b26bfa57-0085-4338-a612-5acba6c4586e', N'391f95fd-b3f8-4c85-95fd-334bcb31de37')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f2cd918e-053a-4b2e-84b0-e5bcf9b804a8', N'c41a478e-0323-4243-ae99-85909be34de4')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c397abed-4dad-4764-9850-27c274db055a', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a42b3a07-6e37-482a-aeb8-4fc9b6889e78', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'32fcfdc3-7d98-4489-b81a-88cff6e1b438', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'444f9714-2066-4855-a27a-ed555829ffd5', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035')
GO
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Name], [Avatar], [Dob], [Biography], [CreationTime], [LastModificationTime]) VALUES (N'c397abed-4dad-4764-9850-27c274db055a', N'student2', N'STUDENT2', N'a2@gmail.com', N'A2@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEJzJ+jmjbVkKPkzxHU2arrXa2JhNf0HGUuIDSptJO7FnL56T4dMwe1rAae9qxN1A1A==', N'T67WNFVHIIIDU5GDJ4LNST6MXIO5ZDLS', N'b083236f-0afc-4505-abe3-b9fcc9d61563', N'01100077888', 0, 0, NULL, 1, 0, N'Tran Bao Long', N'images/avatar-doi-tinh-yeu-1.jpg', CAST(N'1999-11-11T00:00:00.0000000' AS DateTime2), NULL, CAST(N'2021-01-12T13:02:45.7331492' AS DateTime2), CAST(N'2021-01-14T11:59:35.8371925' AS DateTime2))
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Name], [Avatar], [Dob], [Biography], [CreationTime], [LastModificationTime]) VALUES (N'a42b3a07-6e37-482a-aeb8-4fc9b6889e78', N'student221', N'STUDENT221', N'a23@gmail.com', N'LONG0072016@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEF1yzKT7P41eyl8MQqxjklBgd533aRYb9zwGhbAD9lX8Ou5fl0Syu9Qxxxkg+Z7USA==', N'CI6NH7QO2JRRZ5A3VTJ2REPG5KD5R5QC', N'fadb39c2-6ef3-428f-81aa-44fafe89bce6', N'0111777888', 0, 0, NULL, 1, 0, N'long', N'images/avatar-doi-tinh-yeu-1.jpg', CAST(N'1999-11-11T00:00:00.0000000' AS DateTime2), NULL, CAST(N'2021-01-14T01:29:36.3106496' AS DateTime2), CAST(N'2021-01-14T01:29:36.5244208' AS DateTime2))
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Name], [Avatar], [Dob], [Biography], [CreationTime], [LastModificationTime]) VALUES (N'b26bfa57-0085-4338-a612-5acba6c4586e', N'admin', N'ADMIN', N'lockhanhlong007@gmail.com', N'LOCKHANHLONG007@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEPsWh9X2Qn6e1EYZl127GlYpjHQTBXiU//JNVguax3KcST6Jx2AqDYZngXlidTmYFw==', N'TQSJO4M5FCNIJLTFLMX7YW7MJ55Q3ET3', N'62951d5a-04ca-49d6-a2b2-522cea82e0d4', N'0965453699', 0, 0, NULL, 0, 0, N'Trần Bảo Long', N'images/img-default-client.png', CAST(N'1999-07-11T00:00:00.0000000' AS DateTime2), N'Hiện anh đang đảm nhận vai trò Technical Architect tại một trong những công ty outsource cho thị trường Âu, Mỹ hàng đầu tại Việt Nam.', CAST(N'2020-12-02T13:56:51.3262330' AS DateTime2), CAST(N'2021-01-14T13:49:32.7507865' AS DateTime2))
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Name], [Avatar], [Dob], [Biography], [CreationTime], [LastModificationTime]) VALUES (N'32fcfdc3-7d98-4489-b81a-88cff6e1b438', N'student1', N'STUDENT1', N'long0072017@gmail.com', N'LONG0072017@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEJT2QZBAgcHzNTD8XHGQxsLb8rRRm73T29JvEQ8OiMIQjVO5Twcos9nK+aGZlsTgww==', N'HLZJOBVHLYK4LWQJ5PNO4OXPKPW5U6TI', N'a652bd00-fb00-47df-9f63-5cc26ca9f026', N'0865432688', 0, 0, NULL, 1, 0, N'Trần Bảo Long', N'images/defaultAvatar.png', CAST(N'1999-07-11T00:00:00.0000000' AS DateTime2), N'Hiện anh đang đảm nhận vai trò Technical Architect tại một trong những công ty outsource cho thị trường Âu, Mỹ hàng đầu tại Việt Nam.', CAST(N'2020-12-02T13:56:51.4851695' AS DateTime2), CAST(N'2021-01-11T19:04:17.5685369' AS DateTime2))
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Name], [Avatar], [Dob], [Biography], [CreationTime], [LastModificationTime]) VALUES (N'f2cd918e-053a-4b2e-84b0-e5bcf9b804a8', N'teacher1', N'TEACHER1', N'long0072020@gmail.com', N'TEACHER1@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEPsWh9X2Qn6e1EYZl127GlYpjHQTBXiU//JNVguax3KcST6Jx2AqDYZngXlidTmYFw==', N'2YASMX7D4DJJJ6HZQS6PS75TDQHPI7T4', N'a56ca5c5-d819-42d8-82d5-90a59d07a227', N'0765432688', 0, 0, NULL, 1, 0, N'Trần Bảo Long', N'images/defaultAvatar.png', CAST(N'1999-07-11T00:00:00.0000000' AS DateTime2), N'Hiện anh đang đảm nhận vai trò Technical Architect tại một trong những công ty outsource cho thị trường Âu, Mỹ hàng đầu tại Việt Nam.', CAST(N'2020-12-02T13:56:51.4550162' AS DateTime2), CAST(N'2021-01-10T19:03:16.7220063' AS DateTime2))
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Name], [Avatar], [Dob], [Biography], [CreationTime], [LastModificationTime]) VALUES (N'444f9714-2066-4855-a27a-ed555829ffd5', N'admin1313', N'ADMIN1313', N'long1072021@gmail.com', N'LONG1072021@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEGuKhpxBuyqkMdC9FrTfaznsZWsJWE9w97t3WxDJ99J1Ti6i0nFEjTvSiA6Icr845A==', N'5TAJYKTXZDMGCWZGW673NM22BNZPUME2', N'06ad54ed-3833-4b2f-8c94-341cfa17528f', N'0111777888', 0, 0, NULL, 1, 0, N'long', N'images/avatar-doi-tinh-yeu-1.jpg', CAST(N'1999-11-11T00:00:00.0000000' AS DateTime2), NULL, CAST(N'2021-01-14T13:37:38.4628295' AS DateTime2), CAST(N'2021-01-14T13:46:39.2630478' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (1, N'Ngoại Ngữ', 1, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (2, N'Marketing', 2, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (3, N'Tin Học Văn Phòng', 3, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (4, N'Thiết Kế', 4, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (5, N'Kinh Doanh - Khởi Nghiệp', 5, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (6, N'Phát Triển Cá Nhân ', 6, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (7, N'Sales, Bán Hàng', 7, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (8, N'Công Nghệ Thông Tin', 8, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (9, N'Sức Khỏe - Giới Tính', 9, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (10, N'Phong Cách Sống', 10, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (11, N'Nuôi Dạy Con', 11, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (12, N'Hôn Nhân và Gia Đình', 12, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (13, N'Nhiếp Ảnh, Dựng Phim', 13, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (14, N'Tiếng Hàn', 1, 1)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (15, N'Tiếng Anh', 2, 1)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (16, N'Tiếng Trung ', 3, 1)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (17, N'Tiếng Nhật', 4, 1)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (18, N'Tiếng Đức', 5, 1)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (19, N'Facebook Marketing', 1, 2)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (20, N'Zalo Marketing', 2, 2)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (21, N'Email Marketing', 3, 2)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (22, N'Google Marketing', 4, 2)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (23, N'Seo', 5, 2)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (24, N'Branding', 6, 2)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (25, N'Content Marketing', 7, 2)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (26, N'Video Marketing', 8, 2)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (27, N'Excel', 1, 3)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (28, N'Word', 2, 3)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (29, N'Kế Toán', 3, 3)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (30, N'Power Point', 4, 3)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (31, N'Phần Mềm Thiết Kế', 1, 4)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (32, N'Thiết Kế Web', 2, 4)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (33, N'Thiết Kế Đồ Họa', 3, 4)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (34, N'Thiết Kế Nội Thất', 4, 4)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (35, N'Kiến Trúc Nội Thất', 5, 4)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (36, N'Chiến lược kinh doanh', 1, 5)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (37, N'Bất động sản', 2, 5)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (38, N'Crypto', 3, 5)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (39, N'Kinh doanh Online', 4, 5)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (40, N'Startup', 5, 5)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (41, N'Kiếm tiền Online', 6, 5)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (42, N'Quản trị doanh nghiệp', 7, 5)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (43, N'Chứng khoán', 8, 5)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (44, N'Dropshipping', 9, 5)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (45, N'Thương hiệu cá nhân', 1, 6)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (46, N'Tài chính cá nhân', 2, 6)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (47, N'Kỹ năng lãnh đạo', 3, 6)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (48, N'MC', 4, 6)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (49, N'Phát triển bản thân', 5, 6)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (50, N'Giao Tiếp', 6, 6)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (51, N'Thuyết Trình', 7, 6)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (52, N'Kỹ Năng Giao Tiếp', 8, 6)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (53, N'Bán Hàng Online', 1, 7)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (54, N'Livestream', 2, 7)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (55, N'Telesales', 3, 7)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (56, N'Bán hàng', 4, 7)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (57, N'Chăm sóc khách hàng', 5, 7)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (58, N'Cơ sở dữ liệu', 1, 8)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (59, N'Lâp Trình', 2, 8)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (60, N'Ngôn Ngữ Lập Trình', 3, 8)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (61, N'Lập Trình Web', 4, 8)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (62, N'Lập Trình Android', 5, 8)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (63, N'Lập Trình IOS', 6, 8)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (64, N'Giảm Cân', 1, 9)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (65, N'Thiền', 2, 9)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (66, N'Phòng Thế', 3, 9)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (67, N'Fitness - Gym', 4, 9)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (68, N'Tình Yêu', 5, 9)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (69, N'Yoga', 6, 9)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (70, N'Massage', 7, 9)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (71, N'Dinh Dưỡng', 8, 9)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (72, N'Mang Thai', 9, 9)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (73, N'Làm đẹp', 1, 10)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (74, N'Handmade', 2, 10)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (75, N'Tử Vi', 3, 10)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (76, N'Ảo Thuật ', 4, 10)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (77, N'Âm Nhạc', 5, 10)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (78, N'Ẩm thực - Nấu Ăn', 6, 10)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (79, N'Dance - Zumba', 7, 10)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (80, N'Phong Thủy', 8, 10)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (81, N'Dinh dưỡng cho con', 1, 11)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (82, N'Phương pháp dạy con', 2, 11)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (83, N'Giáo dục giới tính', 3, 11)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (84, N'Hôn Nhân', 1, 12)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (85, N'Đời sống vợ chồng', 2, 12)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (86, N'3d animation', 1, 13)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (87, N'Biên tập video', 2, 13)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (88, N'Dựng phim', 3, 13)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (89, N'Chụp ảnh', 4, 13)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (90, N'UI-UX', 5, 13)
INSERT [dbo].[Categories] ([Id], [Name], [SortOrder], [ParentId]) VALUES (91, N'Kỹ xảo', 6, 13)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'Categories')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'Categories')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'Categories')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'Categories')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Approve', N'Courses')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'Courses')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'Courses')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'Courses')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'Courses')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'DashBoard')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'Function')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'Function')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'Function')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'Function')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'NewUser')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'NewUser')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'ExportExcel', N'NewUser')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'NewUser')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'NewUser')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'ExportExcel', N'Orders')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'Orders')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'Orders')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'Permission')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'Permission')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'Permission')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'Permission')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Approve', N'Products')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'Products')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'Products')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'Products')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'Products')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'Promotions')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'Promotions')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'Promotions')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'Promotions')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'Revenue')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'Revenue')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'ExportExcel', N'Revenue')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'Revenue')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'Revenue')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'Role')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'Role')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'Role')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'Role')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'Statistics')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'Statistics')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'ExportExcel', N'Statistics')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'Statistics')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'Statistics')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'System')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'System')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'System')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'System')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Create', N'User')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Delete', N'User')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'Update', N'User')
INSERT [dbo].[CommandInFunctions] ([CommandId], [FunctionId]) VALUES (N'View', N'User')
GO
INSERT [dbo].[Commands] ([Id], [Name]) VALUES (N'Approve', N'Duyệt')
INSERT [dbo].[Commands] ([Id], [Name]) VALUES (N'Create', N'Thêm')
INSERT [dbo].[Commands] ([Id], [Name]) VALUES (N'Delete', N'Xoá')
INSERT [dbo].[Commands] ([Id], [Name]) VALUES (N'ExportExcel', N'Xuất Excel')
INSERT [dbo].[Commands] ([Id], [Name]) VALUES (N'Update', N'Sửa')
INSERT [dbo].[Commands] ([Id], [Name]) VALUES (N'View', N'Xem')
GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([Id], [Content], [EntityId], [EntityType], [UserId], [ReplyId], [CreationTime], [LastModificationTime]) VALUES (8, N'gfdgdfh', 7, N'courses', N'c397abed-4dad-4764-9850-27c274db055a', NULL, CAST(N'2021-01-14T09:35:01.3489653' AS DateTime2), NULL)
INSERT [dbo].[Comments] ([Id], [Content], [EntityId], [EntityType], [UserId], [ReplyId], [CreationTime], [LastModificationTime]) VALUES (9, N'dhdfh', 7, N'courses', N'c397abed-4dad-4764-9850-27c274db055a', NULL, CAST(N'2021-01-14T09:35:05.0266812' AS DateTime2), NULL)
INSERT [dbo].[Comments] ([Id], [Content], [EntityId], [EntityType], [UserId], [ReplyId], [CreationTime], [LastModificationTime]) VALUES (10, N'dfhdfh', 7, N'courses', N'c397abed-4dad-4764-9850-27c274db055a', NULL, CAST(N'2021-01-14T09:35:09.0104111' AS DateTime2), NULL)
INSERT [dbo].[Comments] ([Id], [Content], [EntityId], [EntityType], [UserId], [ReplyId], [CreationTime], [LastModificationTime]) VALUES (11, N'hdhdfh
', 7, N'courses', N'c397abed-4dad-4764-9850-27c274db055a', NULL, CAST(N'2021-01-14T09:35:23.1685584' AS DateTime2), NULL)
INSERT [dbo].[Comments] ([Id], [Content], [EntityId], [EntityType], [UserId], [ReplyId], [CreationTime], [LastModificationTime]) VALUES (12, N'dfhfh', 7, N'courses', N'c397abed-4dad-4764-9850-27c274db055a', 8, CAST(N'2021-01-14T09:35:38.1883135' AS DateTime2), NULL)
INSERT [dbo].[Comments] ([Id], [Content], [EntityId], [EntityType], [UserId], [ReplyId], [CreationTime], [LastModificationTime]) VALUES (13, N'hfgh', 1, N'lessons', N'b26bfa57-0085-4338-a612-5acba6c4586e', NULL, CAST(N'2021-01-14T11:08:18.2469827' AS DateTime2), NULL)
INSERT [dbo].[Comments] ([Id], [Content], [EntityId], [EntityType], [UserId], [ReplyId], [CreationTime], [LastModificationTime]) VALUES (14, N'lk;kl;', 1, N'lessons', N'b26bfa57-0085-4338-a612-5acba6c4586e', NULL, CAST(N'2021-01-14T11:08:28.6833309' AS DateTime2), NULL)
INSERT [dbo].[Comments] ([Id], [Content], [EntityId], [EntityType], [UserId], [ReplyId], [CreationTime], [LastModificationTime]) VALUES (15, N'hdfhfdh', 1, N'lessons', N'b26bfa57-0085-4338-a612-5acba6c4586e', NULL, CAST(N'2021-01-14T11:08:37.6680675' AS DateTime2), NULL)
INSERT [dbo].[Comments] ([Id], [Content], [EntityId], [EntityType], [UserId], [ReplyId], [CreationTime], [LastModificationTime]) VALUES (16, N'dd', 1, N'lessons', N'b26bfa57-0085-4338-a612-5acba6c4586e', 15, CAST(N'2021-01-14T13:59:29.3132457' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Comments] OFF
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (1, N'Học Lập Trình C/C++ Từ A - Z', N'Trang bị cho bạn kỹ năng lập trình ngôn ngữ C/C++ từ cơ bản đến nâng cao, được minh họa thông qua các bài tập thực hành thực tế nhất về C/C++', N'images/hoc-lap-trinh-c-c-a-toi-z-duong-tich-dat_m_1555574622.jpg', N'<div class="u-s-m-b-15"><p>Ngon Ngu Lap Trinh</p></div>', 998000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2021-01-10T21:48:00.6411726' AS DateTime2), 1, 60, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (2, N'Lập Trình Android Từ Cơ Bản Đến Thành Thạo', N'Khóa học lập trình Android toàn tập tạo dựng một kiến thức vững chắc để học viên có thể tự vận hành các ứng dụng trên Appstore một cách nhanh chóng', N'images/lap-trinh-android-tu-co-ban-den-thanh-thao_m.png', N'<div class="u-s-m-b-15"><p>Lap Trinh Android</p></div>', 998000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2021-01-10T19:44:41.6565938' AS DateTime2), 1, 60, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (3, N'Toàn Tập Ngôn Ngữ Lập Trình C#', N'Học lập trình C# bài bản chi tiết nhất tại nhà. Khóa học à cẩm nang đầy đủ về C# cung cấp trọn bộ kiến thức cơ bản - có thể tạo ra một ứng dụng C# hoàn chỉnh', N'images/hoc-toan-tap-ngon-ngu-lap-trinh-c_m_1555637351.jpg', N'<div class="u-s-m-b-15"><p>Lap Trinh C#</p></div>', 499000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 60, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (4, N'Học Lập Trình JavaScript', N'Học lập trình Javascript đã tổng hợp lại kiến thức trong quá trình làm việc', N'images/hoc-lap-trinh-javacript_m_1561523648.jpg', N'<div class="u-s-m-b-15"><p>Lap Trinh JavaScript</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 60, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (5, N'Lập Trình Kotlin Toàn Tập', N'Khóa học sẽ giúp bạn có được kiến thức toàn diện về ngôn ngữ lập trình Kotlin, phát triển được trên phần mềm java,Native,Web cực đơn giản sau khi học xong khóa này', N'images/lap-trinh-kotlin-toan-tap_m_1555658121.jpg', N'<div class="u-s-m-b-15"><p>Lap Trinh Kotlin</p></div>', 699000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 60, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (6, N'Docker Cở Bản', N'Khóa học sẽ hướng dẫn bạn các thao tác cơ bản làm việc với Docker và áp dụng Docker vào các yêu cầu môi trường cụ thể.', N'images/docker-co-ban_m_1561455294.jpg', N'<div class="u-s-m-b-15"><p>Docker</p></div>', 349000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 60, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (7, N'React Native Cơ Bản', N'Khóa học sẽ hướng dẫn bạn các thao tác cơ bản làm việc với React Native và áp dụng React Native dựng app.', N'images/react-native.png', N'<div class="u-s-m-b-15"><p>React Native</p></div>', 349000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 60, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (8, N'Anh văn giao tiếp cho người hoàn toàn mất gốc', N'Khóa học tiếng anh cho người mất gốc khơi dậy niềm đam mê tiếng Anh, tự tin giao tiếp tiếng Anh như người bản xứ, mở ra cơ hội học tập, làm việc tại các công ty đa quốc gia và tự tin hơn trong giao tiếp với người bản địa dù ở bất kỳ hoàn cảnh nào', N'images/anh-van-giao-tiep-cho-nguoi-hoan-toan-mat-goc_m_1555555777.jpg', N'<div class="u-s-m-b-15"><p>Anh văn giao tiếp cho người hoàn toàn mất gốc</p></div>', 549000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 2, 15, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (9, N'Học tiếng Nhật thật dễ', N'Học tiếng Nhật vỡ lòng một cách sinh động, hứng thú, đầy cảm quan với một giáo trình được biên soạn chi tiết, dễ hiểu và dễ ứng dụng.', N'images/hoc-tieng-nhat-that-de_m_1555562005.jpg', N'<div class="u-s-m-b-15"><p>Học tiếng Nhật thật dễ</p></div>', 398000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2021-01-14T09:34:19.4211565' AS DateTime2), 3, 17, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (10, N'Chiến thuật chinh phục IELTS Speaking', N'Hướng dẫn bạn hiểu toàn diện về IELTS Speaking, các chiến thuật để đạt điểm cao trong kì thi trong 35 bài từ giảng viên Lan Anh', N'images/hoc-chinh-phuc-ielts-speaking_m_1555657441.jpg', N'<div class="u-s-m-b-15"><p>Chiến thuật chinh phục IELTS Speaking</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 15, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (11, N'Facebook Marketing từ A - Z', N'Trọn bộ khoá học Facebook Marketing Online từ A-Z của giảng viên Hồ Ngọc Cương sẽ hướng dẫn chuyên sâu bạn về các thủ thuật liên quan đến quảng cáo Facebook, giúp bạn tự lên các chiến lược về Facebook Marketing hoàn hảo cũng như tự chạy quảng cáo chuyên nghiệp.', N'images/facebook-marketing-a-z_m_1555557477.jpg', N'<div class="u-s-m-b-15"><p>Facebook Marketing A-Z</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 19, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (12, N'VUA EMAIL MARKETING', N'Khóa học Email Marketing của giảng viên Hán Quang Dự sẽ giúp bạn đưa ra những chiến lược kinh doanh cho công ty bằng giải pháp Email Marketing, cách sử dụng công cụ Getresponse, nâng cao chất lượng tìm kiếm, chăm sóc khách hàng.', N'images/Vua-email-marketing-han-quang-du_m_1555569804.jpg', N'<div class="u-s-m-b-15"><p>Vua Email Marketing</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 21, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (13, N'Hướng dẫn làm web Landing Page bán hàng đỉnh cao dành cho người không chuyên', N'Khóa học "Hướng dẫn làm web Landing Page bán hàng đỉnh cao dành cho người không chuyên" sẽ hướng dẫn bạn làm landing page ngay cả khi bạn không biết gì về kỹ thuật IT.', N'images/hoc-lam-web-sieu-toc-cho-nguoi-khong-chuyen_m_1555658815.jpg', N'<div class="u-s-m-b-15"><p>Lam Web Sieu Toc</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 24, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (14, N'Học SEO từ A-Z', N'Khóa Học Seo từ chuyên gia - Trải nghiệm cách bán hàng đỉnh cao trên công cụ tìm kiếm Google với khoá học Seo từ A-Z lên Top bất kỳ từ khoá dài và từ khoá ngắn nào.', N'images/khoa-hoc-seo-online_m_1555575597.jpg', N'<div class="u-s-m-b-15"><p>SEO</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 23, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (15, N'Facebook Marketing Du Kích Tiếp cận hàng ngàn khách hàng với chi phí bằng 0', N'Cách thức tiếp cận hàng ngàn khách hàng tiềm năng trên Facebook với chi phí 0 đồng thông qua các công cụ Marketing Online mới nhất', N'images/Facebook-marketing-chi-phi-0-dong_m_1555573466.jpg', N'<div class="u-s-m-b-15"><p>Facebook Marketing</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 19, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (16, N'Thiết kế nội thất bằng 3D-Max', N'Bạn muốn tự tay thiết kế nội thất cho gia đình? Bạn muốn theo đuổi ngành thiết kế nội thất. Tham gia khóa học thiết kế nội thất online bạn sẽ nắm được kỹ thuật về thiết kế bằng 3D-Max chuyên nghiệp', N'images/thiet-ke-noi-that-bang-3ds-max_m_1606357631.jpg', N'<div class="u-s-m-b-15"><p>Thiet ke noi that 3D-Max</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 34, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (17, N'Tạo hình thiết kế chuyên nghiệp với 3DSMAX', N'Bạn sẽ sử dụng thành thạo các nhóm lệnh và các công cụ của 3DSMAX, biết cách tạo hình sản phẩm, tạo ra được các sản phẩm 3D hoàn mỹ.', N'images/3DSMAX_m.png', N'<div class="u-s-m-b-15"><p>Tao hinh voi 3DSMAX</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 33, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (18, N'Tuyệt chiêu luyện AUTOCAD', N'Vẽ kỹ thuật, thiết kế, trình bày, xử lý bản vẽ kỹ thuật trên máy tính đơn giản, nhanh chóng với công cụ AUTOCAD', N'images/tuyet-chieu-luyen-autocad_m_1555575221.jpg', N'<div class="u-s-m-b-15"><p>Luyen AutoCad</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 31, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (19, N'Cẩm nang A-Z Illustrator cho Designer', N'Giúp bạn nhanh chóng làm chủ phần mềm Adobe Illustrator, cung cấp nền tảng kiến thức cơ bản để tạo ra các sản phẩm thiết kế nâng cao và chủ động trong thiết kế', N'images/cam-nang-illustrator-cho-designer_m_1561368077.jpg', N'<div class="u-s-m-b-15"><p>Cam nang Illustrator</p></div>', 699000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 33, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (20, N'Tuyệt chiêu luyện REVIT ARCH', N'Khóa học Revit Arch - Giúp học viên hiểu quy trình các bước dựng hình một công trình kiến trúc thực tế bằng Revit Arch đến cách triển khai chi tiết các bản vẽ sau 54 bài giảng', N'images/tuyet-chieu-luyen-revit-arch_m_1555575662.jpg', N'<div class="u-s-m-b-15"><p>Luyen REVIT ARCH</p></div>', 699000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 31, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (21, N'Thiết kế Powerpoint chuyên nghiệp', N'Khóa học thiết kế PowerPoint chuyên nghiệp giúp học viên trình bày bài thuyết trình ấn tượng với những slide cuốn hút, lôi kéo khán giả', N'images/thiet-ke-powerpoint-chuyen-nghiep_m_1555572817.jpg', N'<div class="u-s-m-b-15"><p>Thiet Ke PowerPoint</p></div>', 140000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 30, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (22, N'Microsoft Excel 2013 nâng cao', N'Microsoft Excel ứng dụng rất nhiều trong đời sống, công việc. Khóa học này sẽ giúp bạn học chuyên sâu Microsoft Excel 2013 nâng cao giúp công việc quản lí của bạn dễ dàng hơn', N'images/Microsoft_excell_213_nang_cao_m.png', N'<div class="u-s-m-b-15"><p>Microsoft Execel 2013 Nang Cao</p></div>', 175000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 27, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (23, N'Thành thạo với Google Spreadsheets', N'Sau khóa học bạn sẽ tự tin sử dụng thành thạo 2 phần mềm Google Sheet và Excel. Ứng dụng vào công việc hay học tập, vừa học vừa làm', N'images/thanh-thao-google-spredsheets_m_1561369930.jpg', N'<div class="u-s-m-b-15"><p>Thanh Thao Google Spreadsheets</p></div>', 175000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 29, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (24, N'Làm chủ Word 2016 từ cơ bản đến nâng cao', N'Làm chủ Word 2016 từ cơ bản đến nâng cao giúp bạn tự tin làm chủ phần mềm Word 2016, nâng cao kỹ năng tin học văn phòng, tự tin thi chứng chỉ', N'images/lam-chu-word-tu-co-ban-den-nang-cao_m_1555658502.jpg', N'<div class="u-s-m-b-15"><p>Lam Chu Word tu co ban den nang cao</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 28, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (25, N'Thành thạo cách xử lý về hóa đơn chứng từ kế toán - Học là biết LÀM', N'Khóa học cung cấp cho bạn toàn bộ kiến thức về Hóa đơn, từ cách viết hóa đơn, đến xử lý sai sót khi lập hóa đơn, phân loại hóa đơn.', N'images/xu-ly-hoa-don-chung-tu-ke-toan_m_1555576403.jpg', N'<div class="u-s-m-b-15"><p>Thanh thao xu ly don tu ke toan</p></div>', 280000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 29, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (26, N'Bí quyết kiếm tiền trên Youtube', N'Khám phá ngay các tuyệt chiêu kiếm tiền tuyệt vời trên Youtube: cách để có những video triệu view hấp dẫn, cách kéo lượt traffic, cách SEO kênh... để biến Youtube thành kênh kiếm tiền thụ động bền vững siêu hot của bạn!', N'images/hoc-bi-quyet-kiem-tien-voi-youtube_m_1555571473.jpg', N'<div class="u-s-m-b-15"><p>Kiem Tien Youtube</p></div>', 549000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 41, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (27, N'Kinh doanh Online hiệu quả với sản phẩm có sẵn', N'Nắm trong tay những bí quyết lập kế hoạch và triển khai chạy quảng cáo hiệu quả trên 5 kênh Marketing Online thịnh hành nhất để bạn kinh doanh online thành công với bất cứ sản phẩm nào', N'images/kinh-doanh-online-san-pham-co-san_m_1555656673.jpg', N'<div class="u-s-m-b-15"><p>Kinh Doanh Online</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 39, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (28, N'Khởi nghiệp từ con số 1', N'Khóa học khởi nghiệp này sẽ giúp bạn được đào tạo bài bản, chuyên nghiệp các phương thức chuẩn bị tài chính, nhân lực, lập kế hoạch, biện pháp phòng tránh, giảm thiểu rủi ro khi khởi nghiệp, cải thiện tình trạng kinh doanh hiệu quả', N'images/khoi-nghiep-tu-con-so-1_m_1561365572.jpg', N'<div class="u-s-m-b-15"><p>Khoi Nghiep</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 40, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (29, N'Khởi nghiệp kinh doanh online với số vốn 0 đồng', N'Bạn muốn học Kinh Doanh Online nhưng Không có Vốn Trong tay? Bạn không biết bắt đầu từ đâu. Khoá học giúp bạn xây dựng hệ thống Khởi nghiệp kinh doanh tự động từ 2 bàn tay trắng.', N'images/bi-quyet-kinh-doanh-my-pham-online_m_1555564995.jpg', N'<div class="u-s-m-b-15"><p>Khoi Nghiep Kinh Doanh</p></div>', 399000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 40, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (30, N'Kinh doanh mỹ phẩm online', N'Khóa học kinh doanh mỹ phẩm online giúp học viên biết các kênh bán hàng hiệu quả, ứng dụng tìm kiếm, chăm sóc khách hàng, viết nội dung cuốn hút, tăng doanh thu bán hàng mỹ phẩm.', N'images/khoi-nghiep-kinh-doanh-voi-von-0-dong_m_1555561955.jpg', N'<div class="u-s-m-b-15"><p>Kinh Doanh My Pham</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 39, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (31, N'Bí quyết viết CV - Dự phỏng vấn', N'Bạn sẽ nắm toàn bộ cách viết CV ấn tượng - Dự phỏng vấn tự tin - Chinh phục nhà tuyển dụng thành công', N'images/bi-quyet-viet-cv-du-phong-van_m_1555575879.jpg', N'<div class="u-s-m-b-15"><p>CACH VIET CV</p></div>', 399000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 49, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (32, N'Làm chủ kỹ năng ghi nhớ', N'Cải thiện khả năng ghi nhớ một cách dễ dàng thông qua các trò chơi về làm chủ con số, nhớ từ vựng tiếng Anh, nhớ sự kiện lịch sử, nhớ nội dung bài giảng', N'images/khoa-hoc-làm-chu-ky-nang-ghi-nho_m_1555656874.jpg', N'<div class="u-s-m-b-15"><p>CAI THIEN GHI NHO</p></div>', 449000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 49, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (33, N'Nghệ thuật quyến rũ khán giả trong thuyết trình', N'Xoá tan nỗi sợ hãi, tăng sự tự tin và quyến rũ của bạn khi thuyết trình. Đồng thời nắm vững kỹ thuật sử dụng ngôn ngữ cơ thể và di chuyển trên sân khấu và Tự tin khi đứng trước đám đông', N'images/nghe-thuat-quyen-ru-khan-gia_m_1558075961.jpg', N'<div class="u-s-m-b-15"><p>XOA TAN NOI SO HAI</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 49, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (34, N'Giải mã tính cách qua sinh trắc vân tay', N'Sinh trắc học dấu vân tay - nơi thấu hiểu mỗi con người giúp bạn thấu hiểu và đọc vị được tính cách của mình cũng như bất kỳ ai.', N'images/giai-ma-tinh-cach-qua-sinh-trac-van-tay_m_1555642638.jpg', N'<div class="u-s-m-b-15"><p>GIAI MA QUA SINH TRAC HOC</p></div>', 499000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 49, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (35, N'Giao tiếp qua điện thoại', N'Giao tiếp qua điện thoại - Bí quyết để thành công - Giao tiếp gián tiếp đang có xu hướng thay thế dần dần các phương thức giao tiếp trực tiếp truyền thống.', N'images/thaykha_m.jpg', N'<div class="u-s-m-b-15"><p>GIAO TIEP QUA DIEN THOAI</p></div>', 499000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 50, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (36, N'Bí quyết chốt đơn thành công 90% - Telesale, Bán hàng online', N'Khóa học cung cấp cho bạn 4 bước xây dựng kịch bản bán hàng và 7 chiến lược chốt sale khiến khách hàng không thể cưỡng lại được. Tăng tỉ lệ chốt đơn lên 90%.', N'images/bi-quyet-chot-sale-thanh-cong_m_1555572889.jpg', N'<div class="u-s-m-b-15"><p>Xay Dung Ban Hang</p></div>', 200000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 56, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (37, N'Chiến binh bán hàng', N'Khóa học giúp bạn đập tan mọi rào cản khó khăn từ khách hàng, nâng cao khả năng giao tiếp, đọc vị tâm lý khách hàng trong 60s.', N'images/chienbinhbanhang-11_m.jpg', N'<div class="u-s-m-b-15"><p>Giai quyet rao can cua khach hang</p></div>', 175000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 57, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (38, N'Nghệ thuật bán hàng qua điện thoại', N'Bí quyết để trở thành Sát thủ bán hàng qua điện thoại, có trong tay chiến lược xây dựng danh sách khách hàng, cùng hàng loạt tuyệt chiêu để có được những kịch bản tele ưng ý', N'images/kich-ban-telesale_m_1555569937.jpg', N'<div class="u-s-m-b-15"><p>Nghe thuat ban hang</p></div>', 240000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 56, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (39, N'Tuyệt chiêu để chốt Sales', N'Làm sao để tiếp cận khách hàng, bí quyết chốt đơn ngay trong vài phút gặp mặt? Khoá học giúp nắm được những kỹ thuật căn bản để Tiếp cận, Chào hàng, Vượt qua phản đối, chốt Sales.', N'images/tuyet-chieu-de-chot-sale_m_1557996232.jpg', N'<div class="u-s-m-b-15"><p>Tuyet chieu chot sales</p></div>', 175000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 55, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (40, N'36 Tuyệt chiêu bán hàng siêu đẳng', N'Với 36 tuyệt chiêu bán hàng siêu đẳng bạn sẽ nắm trong tay tất tần tận các kỹ năng, phương pháp, kịch bản để thuyết phục khách hàng tin tưởng và sử dụng sản phẩm của mình lâu dài và hiệu quả nhất', N'images/tuyet-chieu-ban-hang-nguyen-vinh-cuong_m_1555570080.jpg', N'<div class="u-s-m-b-15"><p>Tuyet chieu ban hang</p></div>', 499000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 56, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (41, N'Bí quyết trẻ đẹp từ trong ra ngoài', N'Là con gái thì phải biết "Làm trẻ đẹp da từ trong da ngoài". Biết cách xây dựng nền tảng cho bản thân để trở nên đẹp, thấy giá trị của bản thân và yêu bản thân hơn.', N'images/dep-tu-trong-ra-ngoai_m_1557995881.jpg', N'<div class="u-s-m-b-15"><p>Bi Quyet Lam Tre</p></div>', 499000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 10, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (42, N'Massage dưỡng sinh Đầu - Vai - Gáy', N'Massage là một phương pháp giúp bảo vệ sức khỏe và thư giãn hệ thần kinh. Massage thường xuyên nhằm tăng cường thể chất, củng cố hệ miễn dịch để chăm sóc bản thân và gia đình mình một cách hiệu quả.', N'images/massage-duong-sinh-dau-vai-gay_m_1557995407.jpg', N'<div class="u-s-m-b-15"><p>Massage Duong Sinh</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 70, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (43, N'Tập Yoga cơ bản ngay tại nhà với Nguyễn Hiếu', N'Học Yoga cơ bản ngay tại nhà giúp cải thiện sức khoẻ tinh thần, thể chất của bạn. Ngoài ra, việc học Yoga Online tại nhà cũng giúp bạn tiết kiệm được nhiều thời gian và chi phí so với việc học ở các trung tâm.', N'images/tap-yoga-co-ban-tai-nha-cung-nguyen-hieu-yoga_m_1555558750.jpg', N'<div class="u-s-m-b-15"><p>Tap Yoga Co Ban</p></div>', 549000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 69, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (44, N'36 Thế Yoga tăng cường sinh lý', N'Bài tập kích hoạt sinh lực, tăng sự linh hoạt, quyến rũ, tạo niềm vui cuộc sống, hạnh phúc gia đình.', N'images/hoc-yoga-tang-cuong-sinh-ly_m_1556177994.jpg', N'<div class="u-s-m-b-15"><p>36 The Yoga</p></div>', 399000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 69, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (45, N'Yoga cho Thân Khỏe, Tâm An', N'Khóa học giúp bạn cảm nhận chuyển biến tích cực về thể chất lẫn tinh thần. Nhờ đó bạn có thể làm việc hiệu quả và tận hưởng cuộc sống với năng lượng dồi dào.', N'images/yoga-than-khoe-tam-an_m_1558076272.jpg', N'<div class="u-s-m-b-15"><p>Yoga cho than khoe</p></div>', 399000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 69, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (46, N'Tự học piano trong 10 ngày', N'Khóa học dành cho người học từ 16 tuổi trở lên. Sau khóa học, bạn sẽ đọc hiểu được các bản nhạc piano cơ bản, chơi được piano bằng 2 tay, đồng thời phát triển kỹ năng thị tấu vừa đàn vừa nhìn bản nhạc.', N'images/tu-hoc-piano-trong-10-ngay_m_1555574091.jpg', N'<div class="u-s-m-b-15"><p>Tu Hoc Piano</p></div>', 479000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 77, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (47, N'Kỹ năng học guitar hiệu quả cho người mới bắt đầu', N'Bạn sẽ nắm chắc kiến thức âm nhạc, cách cảm âm và kỹ năng chơi guitar cơ bản. Hoàn thành khóa học guitar bạn có thể đánh được những bài hát cơ bản và đệm hát một cách chuyên nghiệp. Bạn có thể hoàn toàn tự tin biểu diễn trước đám đông thể hiện cá tính âm nhạc riêng của mình.', N'images/guitar-cho-nguoi-moi-bat-dau_m_1555574034.jpg', N'<div class="u-s-m-b-15"><p>Hoc guitar</p></div>', 449000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 77, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (48, N'Trở thành ảo thuật gia chỉ trong 21 ngày', N'Bạn sẽ thực hành tốt ngay sau khi hoàn thành khóa học ảo thuật đến từ chuyên gia cùng vời những màn ảo thuật đơn giản, vui vẻ đầy bất ngờ, kịch tính và cuốn hút khán giả. Bạn sẽ trở nên tự tin hơn với "tài lẻ" của mình và nhiều người tán phục', N'images/tro-thanh-phu-thuy-trong-21-ngay_m_1555577506.jpg', N'<div class="u-s-m-b-15"><p>Hoc Lam Ao Thuat</p></div>', 499000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 76, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (49, N'Học Độc tấu Guitar trong 36 ngày', N'Học Độc tấu Guitar trong 36 ngày giúp bạn nắm được những kỹ năng chơi đàn cơ bản, từ đó tiếp tục học độc tấu cổ điển hoặc đệm hát, ginger style.', N'images/hoc-doc-tau-guitar-trong-36-ngay_m_1557995488.jpg', N'<div class="u-s-m-b-15"><p>Doc Tau Guitar</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 77, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (50, N'Tự học thổi sáo trúc trong 21 ngày', N'Khóa học sáo trúc "Thổi Sáo Trúc với lộ trình 21 ngày" sẽ giúp bạn nắm chắc những kỹ năng cơ bản cần thiết để chơi sáo, giúp tự tin trổ tài thổi sáo của mình trong những buổi văn nghệ.', N'images/tu-hoc-thoi-sao-trong-21-ngay_m_1555575179.jpg', N'<div class="u-s-m-b-15"><p>Thoi Soa Truc</p></div>', 499000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 77, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (51, N'Bí quyết giữ lửa hôn nhân và hạnh phúc gia đình', N'Bí quyết giữ hạnh phúc gia đình giúp cân bằng cuộc sống hôn nhân và gia đình - Là chìa khóa đảm bảo cho cuộc hôn nhân của mình luôn nồng ấm và hạnh phúc hơn', N'images/bi-quyet-giu-lua-hon-nhan_m_1558075360.jpg', N'<div class="u-s-m-b-15"><p>Bi Quyet Giu Lua Hon Nhan</p></div>', 499000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 85, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (52, N'Nghệ thuật quyến rũ bạn đời', N'Bí quyết giữ hạnh phúc gia đình giúp cân bằng cuộc sống hôn nhân và gia đình - Là chìa khóa đảm bảo cho cuộc hôn nhân của mình luôn nồng ấm và hạnh phúc hơn', N'images/khoa-hoc-nghe-thuat-quyen-ru-ban-doi_m_1555571511.jpg', N'<div class="u-s-m-b-15"><p>Quyen Ru Ban Doi</p></div>', 399000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 84, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (53, N'Bí quyết Tán gái', N'Khóa học Bí quyết Tán gái sẽ mang đến cho phái nam những phương pháp làm quen, bí kíp tán gái và chinh phục bạn gái bá đạo và hiệu quả nhất để nhanh chóng chinh phục được trái tim của nàng', N'images/hoc-bi-kip-tan-gai_m_1555642006.jpg', N'<div class="u-s-m-b-15"><p>Bi Quyet Tan Gai</p></div>', 399000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 84, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (54, N'Trở thành nghệ sĩ tán gái bậc thầy', N'Khóa học Bí quyết Tán gái sẽ mang đến cho phái nam những phương pháp làm quen, bí kíp tán gái và chinh phục bạn gái bá đạo và hiệu quả nhất để nhanh chóng chinh phục được trái tim của nàng', N'images/nghe-thuat-tan-gai-bac-thay_m_1555573992.jpg', N'<div class="u-s-m-b-15"><p>Bac Thay Tan Gai</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 84, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (55, N'7 ngày trước cưới - hành trang cho cuộc sống hôn nhân', N'Khoá học 7 ngày trước cưới - hành trang cho cuộc sống hôn nhân giúp bạn có tâm lý, tư tưởng vững vàng khi bước vào cuộc sống hôn nhân.', N'images/7-ngay-truoc-cuoi-hanh-trang-cho-cuoc-song-hon-nhan_m_1561427058.jpg', N'<div class="u-s-m-b-15"><p>Hanh Trang Cuoc Song Hon Nhan</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 85, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (56, N'19 Tuyệt chiêu nuôi dạy con thành tài', N'Lắng nghe con, phát huy điểm mạnh của con, gần gũi với con cái, thấu hiểu con cái để nuôi dạy con tốt nhất.', N'images/19tuyet-chieu-day-con-thanh-tai_m_1555577063.jpg', N'<div class="u-s-m-b-15"><p>Tuyet Chieu Nuoi Day Con</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 82, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (57, N'Bí quyết cho trẻ ăn dặm lớn nhanh, khỏe mạnh', N'Dinh dưỡng cho trẻ nhỏ, cách cho ăn dặm, chăm sóc con từ 6 - 12 tháng tuổi thông minh, khoẻ mạnh, lớn nhanh.', N'images/ANdam_m.jpg', N'<div class="u-s-m-b-15"><p>Bi Quyet Cho Tre An Lon Nhanh</p></div>', 399000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 82, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (58, N'Dạy con phát triển toàn diện theo phương pháp Do Thái', N'Yêu con, thương con nhưng phải dạy con đúng phương pháp. Vì thế hãy dạy con phát triển toàn diện theo phương pháp Do Thái', N'images/day-con-phat-trien-toan-dien-theo-phuong-phap-do-thai_m_1555659245.jpg', N'<div class="u-s-m-b-15"><p>Dat Con Phat Trien Toan Dien</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 82, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (59, N'Nuôi dạy con kiệt xuất theo phương pháp người Do Thái', N'Khóa học dành cho các bậc cha mẹ đang muốn xây dựng con thành một đứa trẻ thành công, dạy con tư duy, kiến thức nền tảng để mạnh mẽ bước vào đời giúp trẻ phát triển toàn diện trogn tương lai', N'images/hoc-nuoi-day-con-kiet-suot-theo-phuong-phap-nguoi-do-thai_m_1555657021.jpg', N'<div class="u-s-m-b-15"><p>Nuoi Day Con</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 82, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (60, N'Bento - Con ăn khỏe, cả nhà vui vẻ', N'Bạn sẽ biết cách làm những hộp cơm Bento dinh dưỡng, bắt mắt, hấp dẫn. Chắc chắn Bento là giải pháp tuyệt vời cho các bà mẹ có con kén ăn.', N'images/hinhchily800_(1)_m.jpg', N'<div class="u-s-m-b-15"><p>Bento danh cho con an</p></div>', 199000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 81, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (61, N'Làm phim hoạt hình 2D với MAYA', N'Hướng dẫn làm phim hoạt hình 2D tạo nên 1 tác phẩm tuyệt vời một cách chuyên nghiệp với Maya', N'images/tao-hoat-hinh-2d-voi-maya_m_1556178292.jpg', N'<div class="u-s-m-b-15"><p>Lam Phim Hoat Hinh 2D</p></div>', 749000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 88, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (62, N'Làm phim hoạt hình 3D với MAYA', N'3D Maya giúp nâng cao năng suất làm việc, xử lý mô hình làm mịn toàn diện và render linh hoạt để bạn hoàn thành trọn vẹn ước mơ tạo ra bộ phim hoạt hình của chính mình', N'images/khoa-hoc-lam-phim-hoat-hinh-3d-voi-maya_m_1555642625.jpg', N'<div class="u-s-m-b-15"><p>Lam Phim Hoat Hinh 3D</p></div>', 749000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 88, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (63, N'Học nhiếp ảnh từ cơ bản đến nâng cao', N'Tất cả những bí mật về nhiếp ảnh và xử lý ảnh sẽ được bật mí ngay trong khóa học để bạn có được những bức ảnh đẹp nhất, chất nhất và ấn tượng nhất!', N'images/hoc-nhiep-anh-tu-co-ban-den-nang-cao_m_1555575047.jpg', N'<div class="u-s-m-b-15"><p>Hoc Nhiep Anh</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 89, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (64, N'Nhiếp ảnh cơ bản', N'Giúp bạn tự tin thực hiện các thao tác về máy ảnh và kỹ năng chụp ảnh chuyên nghiệp, có được những bức ảnh đẹp tuyệt vời cùng những khoảnh khắc có một không hai trong nhiếp ảnh! ', N'images/nhiep-anh-co-ban_m_1558082726.jpg', N'<div class="u-s-m-b-15"><p>Nhiep Anh Co Ban</p></div>', 599000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 89, N'teacher1')
INSERT [dbo].[Courses] ([Id], [Name], [Description], [Image], [Content], [Price], [CreationTime], [LastModificationTime], [Status], [CategoryId], [CreatedUserName]) VALUES (65, N'Sản xuất phim quảng cáo và hoạt hình 2D với Photoshop và After effects', N'Học cách thiết kế nhân vật, vẽ storyboard bằng phần mềm: Photoshop, Illustrator tạo xương, chuyển động bằng phần mềm: After effects', N'images/san-xuat-phim-quang-cao-va-hoat-hinh-2d_m_1561429115.jpg', N'<div class="u-s-m-b-15"><p>San xuat quang cao va hoat hinh 2D</p></div>', 699000, CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-12T00:00:00.0000000' AS DateTime2), 1, 88, N'teacher1')
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[FeedBacks] ON 

INSERT [dbo].[FeedBacks] ([Id], [Name], [Email], [PhoneNumber], [Message], [CreationTime], [LastModificationTime]) VALUES (1, N'Tran Bao Long', N'long0072017@gmail.com', N'0111777888', N'sadfgsdgsdgsdg', CAST(N'2021-01-14T00:48:51.8997667' AS DateTime2), NULL)
INSERT [dbo].[FeedBacks] ([Id], [Name], [Email], [PhoneNumber], [Message], [CreationTime], [LastModificationTime]) VALUES (2, N'Tran Bao Long test', N'long0072017@gmail.com', N'0666777888', N'dfsghdfhdfhdfh', CAST(N'2021-01-14T13:13:07.9162038' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[FeedBacks] OFF
GO
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'Categories', N'Danh mục', N'/products/categories', 1, N'Products', N'fa-edit')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'Courses', N'Khóa Học', N'/products/courses', 2, N'Products', N'fa-edit')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'DashBoard', N'Trang Chủ', N'/dashboard', 1, NULL, N'fa-dashboard')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'Function', N'Chức năng', N'/systems/functions', 3, N'System', N'fa-desktop')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'NewUser', N'Đăng ký', N'/statistics/new-user', 1, N'Statistics', N'fa-wrench')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'Orders', N'Đặt Hàng', N'/products/orders', 4, N'Products', N'fa-edit')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'Permission', N'Quyền hạn', N'/systems/permissions', 4, N'System', N'fa-desktop')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'Products', N'Sản Phẩm', N'/products', 2, NULL, N'fa-table')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'Promotions', N'Sự Kiện', N'/products/promotions', 3, N'Products', N'fa-edit')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'Revenue', N'Doanh thu', N'/statistics/revenue', 2, N'Statistics', N'fa-wrench')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'Role', N'Nhóm quyền', N'/systems/roles', 2, N'System', N'fa-desktop')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'Statistics', N'Thống kê', N'/statistics', 3, NULL, N'fa-bar-chart-o')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'System', N'Hệ thống', N'/systems', 4, NULL, N'fa-th-list')
INSERT [dbo].[Functions] ([Id], [Name], [Url], [SortOrder], [ParentId], [Icon]) VALUES (N'User', N'Người dùng', N'/systems/users', 1, N'System', N'fa-desktop')
GO
SET IDENTITY_INSERT [dbo].[Lessons] ON 

INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (1, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 7, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (2, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 7, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (3, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 7, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (4, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 7, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (5, N'Bài 2 Biến Let Var Const và Template virals trong ES6', N'videos/Bai2_Bien_Let_ Var_ Const_va_Template_Virals_trong_ES6.MP4', N'files/videotest1.rar', 5, 1, 7, N'00:21:57')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (6, N'Bài 3 Arrow Function ES6', N'videos/Bai3_Arrow_Function ES6.MP4', N'files/videotest1.rar', 6, 1, 7, N'00:19:29')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (7, N'Bài 4 Kiểu Object', N'videos/Bai4_Kieu_Object.MP4', N'files/videotest1.rar', 7, 1, 7, N'00:15:57')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (8, N'Bài 5 phân rẽ cấu trúc Destruring', N'videos/Bai5_Phan_ra_cau_truc Destructuring.MP4', N'files/videotest1.rar', 8, 1, 7, N'00:13:03')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (9, N'Bài6_Rest_Paremater', N'videos/Bai6_Rest_Paremater.MP4', N'files/videotest1.rar', 9, 1, 7, N'00:06:41')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (10, N'Bài 7 Khai báo class trong ES6', N'videos/Bai7_Khai_bao_Class_trong_ES6.MP4', N'files/videotest1.rar', 10, 1, 7, N'00:13:38')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (11, N'Bài8 Cách xử lý trong ES6', N'videos/Bai8_Cach_xy_ly_mang trong_ES6.MP4', N'files/videotest1.rar', 11, 1, 7, N'00:16:04')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (12, N'Bài 9 Cách sử dụng mảng map trong ES6', N'videos/Bai9_Cach_su_dung_mang_Map_trong_ES6.MP4', N'files/videotest1.rar', 12, 1, 7, N'00:15:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (13, N'Bài 10 Cách sử dụng mảng Set trong ES6', N'videos/Bai10_cach_su_dung_mang_Set_trong_ES6.MP4', N'files/videotest1.rar', 13, 1, 7, N'00:04:28')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (14, N'Bài 11 Khảo sát vòng đời Component', N'videos/Bai11_Khao_sat_vong_doi_cua_Component.MP4', N'files/videotest1.rar', 14, 1, 7, N'00:11:22')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (15, N'Bài 12 tìm hiểu thư mục và chạy ứng dụng helloworld', N'videos/Bai12_Tin_hieu_thu_muc_va_chay_ung_dung_helloworld.MP4', N'files/videotest1.rar', 15, 1, 7, N'00:24:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (16, N'Bài 13 Tông quan về Component', N'videos/Bai13_Tong_quan_ve_Component.MP4', N'files/videotest1.rar', 16, 1, 7, N'00:16:39')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (17, N'Bài 14 Cách chạy code cho từng platform', N'videos/Bai14_Cach_chi_dinh_code_cho_tung_platform.MP4', N'files/videotest1.rar', 17, 1, 7, N'00:09:25')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (18, N'Bài 15 Khái niệm props và state', N'videos/Bai15_Khai_niem_props_va_state.MP4', N'files/videotest1.rar', 18, 1, 7, N'00:09:45')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (19, N'Bài 16 Thực hành props', N'videos/Bai16_Thuc_hanh_props.MP4', N'files/videotest1.rar', 19, 1, 7, N'00:25:17')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (20, N'Bài 17 Thực hành state', N'videos/Bai17Thuc_hanh_state.MP4', N'files/videotest1.rar', 20, 1, 7, N'00:15:28')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (21, N'Bài 18 Style trong ReactNative', N'videos/Bai18_Style_trong_ReactNative.MP4', N'files/videotest1.rar', 21, 1, 7, N'00:05:05')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (22, N'Bài 19 Thực hành trong Style', N'videos/Bai19_Thuc_hanh_Style.MP4', N'files/videotest1.rar', 22, 1, 7, N'00:13:29')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (23, N'Bài 20 Width vs Height vs Flex', N'videos/Bai20_Width_vs_Height_vs_Flex.MP4', N'files/videotest1.rar', 23, 1, 7, N'00:05:54')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (24, N'Bài 21 Thực hành Width vs Height vs Flex', N'videos/Bai21_Thuc_hanh_Width_vs_Height_vs_Flex.MP4', N'files/videotest1.rar', 24, 1, 7, N'00:23:29')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (25, N'Bài 22 Flexbox', N'videos/Bai22_Flexbox.MP4', N'files/videotest1.rar', 25, 1, 7, N'00:10:37')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (26, N'Bài 23 Thực hàn FlexBox', N'videos/Bai23_Thuc_hanh_FlexBox.MP4', N'files/videotest1.rar', 26, 1, 7, N'00:17:30')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (27, N'Bài 24 Text Component', N'videos/Bai24_Text_Component.MP4', N'files/videotest1.rar', 27, 1, 7, N'00:16:49')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (28, N'Bài 25 Thực hành Text Component', N'videos/Bai25_Thuc_hanh_Text_Component.MP4', N'files/videotest1.rar', 28, 1, 7, N'00:23:19')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (29, N'Bài 26 TextInput Component', N'videos/Bai26_TextInput_Component.MP4', N'files/videotest1.rar', 29, 1, 7, N'00:16:57')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (30, N'Bài 27 Thực hành TextInput', N'videos/Bai27_Thuc_hanh_TextInput.MP4', N'files/videotest1.rar', 30, 1, 7, N'00:22:47')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (31, N'Bài 28 button component', N'videos/Bai28_button_component.MP4', N'files/videotest1.rar', 31, 1, 7, N'00:08:13')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (32, N'Bài 29 image component', N'videos/Bai29_image_component.MP4', N'files/videotest1.rar', 32, 1, 7, N'00:21:47')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (33, N'Bài 30 Thực hành image', N'videos/Bai30_thuc_hanh_image.MP4', N'files/videotest1.rar', 33, 1, 7, N'00:34:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (34, N'Bài 31 View component', N'videos/Bai31_View_component.MP4', N'files/videotest1.rar', 34, 1, 7, N'00:11:12')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (35, N'Bài 32 Thực hành view', N'videos/Bai32_thuc_hanh_view.MP4', N'files/videotest1.rar', 35, 1, 7, N'00:16:27')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (36, N'Bài 33 Tìm hiểu ý nghĩa import và export', N'videos/Bai33_tim_hieu_y_nghia_import_va_export_trong_ReactNative.MP4', N'files/videotest1.rar', 36, 1, 7, N'00:29:10')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (37, N'Bài 34 Xây dựng giao diện đăng nhập pokemon', N'videos/Bai34_Xay_dung_giao_dien_dang_nhap_Pokemon.MP4', N'files/videotest1.rar', 37, 1, 7, N'01:17:22')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (38, N'Bài 35 Cách xử lý username và password', N'videos/Bai35_Cach_xu_ly_username_va_password.MP4', N'files/videotest1.rar', 38, 1, 7, N'00:21:43')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (39, N'Bài 36 Thiết kế ứng dụng Calculator', N'videos/Bai36_Thiet_ke_giao_dien_ung_dung_Calculator.MP4', N'files/videotest1.rar', 39, 1, 7, N'00:38:19')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (40, N'Bài 37 Xử lý ứng dụng của calculator', N'videos/Bai37_Xu_ly_logic_ung_dung_calculator.MP4', N'files/videotest1.rar', 40, 1, 7, N'00:26:05')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (41, N'Bài 38 Navigator', N'videos/Bai38_Navigator.MP4', N'files/videotest1.rar', 41, 1, 7, N'00:38:25')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (42, N'Bài 39 Truyền tham số trong Navigator', N'videos/Bai39_Truyen_tham_so_trong_Navigator.MP4', N'files/videotest1.rar', 42, 1, 7, N'00:19:54')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (43, N'Bài 40 ProgressBar', N'videos/Bai40_ProgressBar.MP4', N'files/videotest1.rar', 43, 1, 7, N'00:11:31')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (44, N'Bài 41 Activity Indicator', N'videos/Bai41_Activity_Indicator.MP4', N'files/videotest1.rar', 44, 1, 7, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (45, N'Bài 42 Notification', N'videos/Bai42_Notification.MP4', N'files/videotest1.rar', 45, 1, 7, N'00:33:31')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (46, N'Bài 43 SearchView vs ListView', N'videos/Bai43_SearchView_vs_ListView.MP4', N'files/videotest1.rar', 46, 1, 7, N'00:47:44')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (47, N'Bài 44 ScrollView', N'videos/Bai44_ScrollView.MP4', N'files/videotest1.rar', 47, 1, 7, N'00:09:18')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (48, N'Bài 45 Cách sử dụng ListView', N'videos/Bai45_Cach_su_dung_ListView.MP4', N'files/videotest1.rar', 48, 1, 7, N'00:29:01')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (49, N'Bài 46 Cách thêm dữ liệu Listview', N'videos/Bai46_Cach_them_du_lieu_Listview.MP4', N'files/videotest1.rar', 49, 1, 7, N'00:12:36')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (50, N'Bài 47 Hiển thị listview dạng object', N'videos/Bai47_Hien_thi_listview_dang_object.MP4', N'files/videotest1.rar', 50, 1, 7, N'00:20:52')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (51, N'Bài 48 Hiển thị listview dạng Grid', N'videos/Bai48_hien_Thi_ListView_dang_Grid.MP4', N'files/videotest1.rar', 51, 1, 7, N'00:19:35')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (52, N'Bài 49 Picker', N'videos/Bai49_Picker.MP4', N'files/videotest1.rar', 52, 1, 7, N'00:28:36')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (53, N'Bài 50 Switch Button', N'videos/Bai50_Switch_Button.MP4', N'files/videotest1.rar', 53, 1, 7, N'00:07:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (54, N'Bài 51 Silder', N'videos/Bai51_Silder.MP4', N'files/videotest1.rar', 54, 1, 7, N'00:13:51')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (55, N'Bài 52 KeyboardAvoidi gView', N'videos/Bai52_KeyboardAvoidi_gView.MP4', N'files/videotest1.rar', 55, 1, 7, N'00:14:51')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (56, N'Bài 53 DrawerLayout', N'videos/Bai53_DrawerLayout.MP4', N'files/videotest1.rar', 56, 1, 7, N'00:31:16')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (57, N'Bài 54 Cách sử dụng thư viện ViewPager,Tab_cho_Android_va_IOS', N'videos/Bai54_Cach_su_dung_thu_vien_ViewPager,Tab_cho_Android_va_IOS.MP4', N'files/videotest1.rar', 57, 1, 7, N'00:42:08')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (58, N'Bài 55 Modal', N'videos/Bai55_Modal.MP4', N'files/videotest1.rar', 58, 1, 7, N'00:23:10')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (59, N'Bài 56 WebView', N'videos/Bai56_WebView.MP4', N'files/videotest1.rar', 59, 1, 7, N'00:32:41')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (60, N'Bài 57 Cách cấu hình và sử dụng GoogleMap', N'videos/Bai57_Cach_cau_hình_va_su_dung_GoogleMap.MP4', N'files/videotest1.rar', 60, 1, 7, N'00:33:15')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (61, N'Bài 58 Tìm hiểu props mapview', N'videos/Bai58_Tim_hieu_props_mapview.MP4', N'files/videotest1.rar', 60, 1, 7, N'00:23:52')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (62, N'Bài 59 Cách sử dụng và thêm marker mapview', N'videos/Bai59_cach_su_dung_va_them_marker_mapview.MP4', N'files/videotest1.rar', 60, 1, 7, N'00:48:33')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (63, N'Bài 60 CustomCallout MapView', N'videos/Bai60_CustomCallout_MapView.MP4', N'files/videotest1.rar', 60, 1, 7, N'00:13:18')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (64, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 1, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (65, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 1, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (66, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 1, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (67, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 1, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (68, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 2, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (69, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 2, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (70, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 2, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (71, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 2, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (72, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 3, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (73, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 3, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (74, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 3, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (75, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 3, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (76, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 4, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (77, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 4, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (78, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 4, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (79, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 4, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (80, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 5, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (81, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 5, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (82, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 5, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (83, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 5, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (84, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 6, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (85, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 6, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (86, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 6, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (87, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 6, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (88, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 8, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (89, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 8, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (90, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 8, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (91, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 8, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (93, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 9, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (94, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 9, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (95, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 9, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (96, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 10, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (97, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 10, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (98, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 10, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (99, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 10, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (100, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 11, N'00:14:55')
GO
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (101, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 11, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (102, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 11, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (103, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 11, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (104, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 12, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (105, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 12, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (106, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 12, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (107, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 12, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (108, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 13, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (109, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 13, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (110, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 13, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (111, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 13, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (112, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 14, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (113, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 14, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (114, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 14, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (115, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 14, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (116, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 15, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (117, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 15, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (118, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 15, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (119, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 15, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (120, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 16, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (121, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 16, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (122, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 16, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (123, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 16, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (124, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 17, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (125, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 17, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (126, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 17, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (127, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 17, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (128, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 18, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (129, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 18, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (130, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 18, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (131, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 18, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (132, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 19, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (133, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 19, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (134, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 19, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (135, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 19, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (136, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 20, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (137, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 20, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (138, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 20, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (139, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 20, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (140, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 21, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (141, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 21, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (142, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 21, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (143, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 21, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (144, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 22, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (145, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 22, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (146, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 22, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (147, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 22, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (148, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 23, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (149, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 23, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (150, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 23, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (151, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 23, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (152, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 24, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (153, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 24, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (154, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 24, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (155, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 24, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (156, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 25, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (157, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 25, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (158, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 25, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (159, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 25, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (160, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 26, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (161, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 26, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (162, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 26, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (163, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 26, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (164, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 27, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (165, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 27, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (166, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 27, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (167, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 27, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (168, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 28, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (169, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 28, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (170, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 28, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (171, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 28, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (172, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 29, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (173, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 29, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (174, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 29, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (175, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 29, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (176, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 30, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (177, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 30, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (178, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 30, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (179, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 30, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (180, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 31, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (181, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 31, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (182, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 31, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (183, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 31, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (184, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 32, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (185, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 32, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (186, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 32, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (187, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 32, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (188, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 33, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (189, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 33, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (190, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 33, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (191, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 33, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (192, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 34, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (193, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 34, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (194, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 34, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (195, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 34, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (196, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 35, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (197, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 35, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (198, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 35, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (199, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 35, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (200, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 0, 36, N'00:14:55')
GO
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (201, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 36, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (202, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 36, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (203, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 36, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (204, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 37, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (205, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 37, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (206, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 37, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (207, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 37, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (208, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 38, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (209, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 38, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (210, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 38, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (211, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 38, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (212, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 39, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (213, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 39, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (214, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 39, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (215, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 39, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (216, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 40, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (217, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 40, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (218, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 40, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (219, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 40, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (220, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 41, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (221, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 41, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (222, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 41, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (223, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 41, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (224, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 42, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (225, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 42, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (226, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 42, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (227, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 42, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (228, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 43, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (229, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 43, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (230, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 43, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (231, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 43, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (232, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 44, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (233, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 44, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (234, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 44, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (235, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 44, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (236, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 45, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (237, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 45, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (238, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 45, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (239, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 45, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (240, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 46, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (241, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 46, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (242, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 46, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (243, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 46, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (244, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 47, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (245, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 47, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (246, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 47, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (247, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 47, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (248, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 48, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (249, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 48, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (250, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 48, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (251, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 48, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (252, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 49, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (253, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 49, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (254, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 49, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (255, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 49, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (256, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 50, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (257, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 50, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (258, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 50, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (259, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 50, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (260, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 51, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (261, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 51, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (262, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 51, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (263, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 51, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (264, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 52, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (265, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 52, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (266, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 52, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (267, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 52, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (268, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 53, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (269, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 53, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (270, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 53, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (271, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 53, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (272, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 54, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (273, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 54, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (274, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 54, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (275, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 54, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (276, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 55, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (277, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 55, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (278, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 55, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (279, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 55, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (280, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 56, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (281, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 56, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (282, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 56, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (283, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 56, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (284, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 57, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (285, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 57, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (286, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 57, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (287, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 57, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (288, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 58, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (289, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 58, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (290, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 58, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (291, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 58, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (292, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 59, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (293, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 59, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (294, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 59, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (295, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 59, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (296, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 60, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (297, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 60, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (298, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 60, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (299, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 60, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (300, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 61, N'00:14:55')
GO
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (301, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 61, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (302, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 61, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (303, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 61, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (304, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 62, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (305, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 62, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (306, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 62, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (307, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 62, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (308, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 63, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (309, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 63, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (310, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 63, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (311, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 63, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (312, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 64, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (313, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 64, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (314, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 64, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (315, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 64, N'00:11:24')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (316, N'Bài 0 Chia sẽ kinh nghiệm tìm hiểu code', N'videos/Bai0_Chia_se_kinh_nghiem_tim_hieu_code.MP4', N'', 1, 1, 65, N'00:14:55')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (317, N'Bài 1_1 Cấu hình sublimText cho React Native', N'videos/Bai1_1_Cau_hinh_sublimText_Cho_React_Naitve_.MP4', N'', 2, 1, 65, N'00:06:58')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (318, N'Bài 1_2 Cách Xuất log và gói code javascript', N'videos/Bai1_2_cach_xuat log_va_goi_code_javascript.MP4', N'', 3, 1, 65, N'00:06:14')
INSERT [dbo].[Lessons] ([Id], [Name], [VideoPath], [Attachment], [SortOrder], [Status], [CourseId], [Times]) VALUES (319, N'Bài 1 Hướng Dẫn Cài Đặt React Native', N'videos/Bai1_Huong dan_cai_dat_React_Native.MP4', N'files/videotest1.rar', 4, 1, 65, N'00:11:24')
SET IDENTITY_INSERT [dbo].[Lessons] OFF
GO
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (9, N'e0011b41-1f3f-4f4e-9740-1498e7a3c9cd', 449000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (6, N'73844cab-f6f7-42a5-aeb0-17919013aeb2', 699000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (11, N'df2896ef-8f51-4491-b0a1-2c17a3fe3811', 998000, 499000)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (8, N'36a9b19a-d18a-4855-b0b3-3178c197cbbb', 749000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (8, N'da78cd7f-436a-4225-9816-33f8c995dcf9', 599000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (2, N'bf15ad46-9ea9-4653-add1-37fd0c476a2d', 349000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (10, N'8c75df70-b9d9-485d-b9e0-442062163d35', 1996000, 998000)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (3, N'14cffa13-a289-4d14-99b4-514e84cc04bc', 199000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (13, N'8cbe4c46-571a-4e19-b191-603f916b5644', 199000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (8, N'4c33e277-cbaa-4749-b600-6378e6e2f72b', 749000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (12, N'66525d28-4ae4-46bf-a578-668bf5115bd6', 199000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (6, N'75a47213-19e1-4846-b453-775ffea8c9d0', 599000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (7, N'2ee37379-ae6f-4908-a8db-996b0ffdbae5', 199000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (11, N'00d20a40-6535-41f2-94b0-acfca96b42e4', 1996000, 998000)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (4, N'75119fe3-4f68-4d7b-ba6b-cb0510e7b53c', 199000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (5, N'62a85d59-737e-4f92-aa63-cdf658b41a4c', 199000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (12, N'145027b7-2d34-464f-a58c-d5f76ac62a92', 199000, NULL)
INSERT [dbo].[OrderDetails] ([OrderId], [ActiveCourseId], [Price], [PromotionPrice]) VALUES (1, N'd57e28a9-f361-4a6a-9024-f3f822955f74', 199000, NULL)
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (1, 0, NULL, 199000, N'hfgj', N'a@gmail.com', N'sgdfghdfhdf', N'152352523', N'fdhdfhdfgh', CAST(N'2021-01-12T12:55:46.3750593' AS DateTime2), NULL, 0)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (2, 1, N'b26bfa57-0085-4338-a612-5acba6c4586e', 349000, N'Trần Bảo Long', N'lockhanhlong007@gmail.com', NULL, N'0965453699', N'Thanh toán VNpay', CAST(N'2021-01-12T13:11:13.6294275' AS DateTime2), CAST(N'2021-01-12T13:11:58.2393329' AS DateTime2), 4)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (3, 0, NULL, 199000, N'sgdsdgsd', N'a@gmail.com', N'sdgsdfgdfg', N'14124124', N'dhdfhdfh', CAST(N'2021-01-12T13:16:48.6477856' AS DateTime2), NULL, 0)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (4, 1, N'b26bfa57-0085-4338-a612-5acba6c4586e', 199000, N'Trần Bảo Long', N'lockhanhlong007@gmail.com', NULL, N'0965453699', N'Thanh toán VNpay', CAST(N'2021-01-12T13:19:32.1117896' AS DateTime2), NULL, 0)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (5, 0, NULL, 199000, N'sgsdgsdg', N'ra@gmail.com', N'dsgsdgsdg', N'1241412', N'dhdfhfdh', CAST(N'2021-01-13T13:42:14.8495163' AS DateTime2), NULL, 0)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (6, 1, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1298000, N'Trần Bảo Long', N'lockhanhlong007@gmail.com', NULL, N'0965453699', N'Thanh toán VNpay', CAST(N'2021-01-13T22:25:34.0997149' AS DateTime2), CAST(N'2021-01-13T22:27:15.1393233' AS DateTime2), 4)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (7, 1, N'b26bfa57-0085-4338-a612-5acba6c4586e', 199000, N'Trần Bảo Long', N'lockhanhlong007@gmail.com', NULL, N'0965453699', N'Thanh toán VNpay', CAST(N'2021-01-13T22:29:40.5021833' AS DateTime2), CAST(N'2021-01-13T22:30:03.6092031' AS DateTime2), 4)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (8, 1, N'b26bfa57-0085-4338-a612-5acba6c4586e', 2097000, N'Trần Bảo Long', N'lockhanhlong007@gmail.com', NULL, N'0965453699', N'Thanh toán VNpay', CAST(N'2021-01-13T22:34:04.2362930' AS DateTime2), CAST(N'2021-01-13T22:34:28.2534501' AS DateTime2), 4)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (9, 1, N'b26bfa57-0085-4338-a612-5acba6c4586e', 449000, N'Trần Bảo Long', N'lockhanhlong007@gmail.com', NULL, N'0965453699', N'Thanh toán VNpay', CAST(N'2021-01-13T22:37:16.3021715' AS DateTime2), CAST(N'2021-01-13T22:37:34.7264193' AS DateTime2), 4)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (10, 1, N'b26bfa57-0085-4338-a612-5acba6c4586e', 998000, N'Trần Bảo Long', N'lockhanhlong007@gmail.com', NULL, N'0965453699', N'Thanh toán VNpay', CAST(N'2021-01-13T22:41:04.8424653' AS DateTime2), CAST(N'2021-01-13T22:41:23.4603468' AS DateTime2), 4)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (11, 1, N'b26bfa57-0085-4338-a612-5acba6c4586e', 1497000, N'Trần Bảo Long', N'lockhanhlong007@gmail.com', NULL, N'0965453699', N'Thanh toán VNpay', CAST(N'2021-01-13T22:43:42.7373920' AS DateTime2), CAST(N'2021-01-13T22:44:06.8928576' AS DateTime2), 4)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (12, 1, N'b26bfa57-0085-4338-a612-5acba6c4586e', 398000, N'Trần Bảo Long', N'lockhanhlong007@gmail.com', NULL, N'0965453699', N'Thanh toán VNpay', CAST(N'2021-01-14T13:00:03.7034182' AS DateTime2), CAST(N'2021-01-14T13:01:34.1742977' AS DateTime2), 4)
INSERT [dbo].[Orders] ([Id], [PaymentMethod], [UserId], [Total], [Name], [Email], [Address], [PhoneNumber], [Message], [CreationTime], [LastModificationTime], [Status]) VALUES (13, 0, NULL, 199000, N'sgsdgs', N'a@gmail.com', N'sdgsdg', N'14124', N'shgsdhsh', CAST(N'2021-01-14T13:07:00.9474037' AS DateTime2), NULL, 0)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Categories', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Function', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Permission', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Role', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'System', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'User', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Categories', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Function', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Orders', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Permission', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Role', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'System', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'User', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Orders', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Categories', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Function', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Orders', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Permission', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Role', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'System', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'User', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Categories', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'DashBoard', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Function', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Orders', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Permission', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Role', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'System', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'User', N'391f95fd-b3f8-4c85-95fd-334bcb31de37', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'c41a478e-0323-4243-ae99-85909be34de4', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'c41a478e-0323-4243-ae99-85909be34de4', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'c41a478e-0323-4243-ae99-85909be34de4', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'c41a478e-0323-4243-ae99-85909be34de4', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'c41a478e-0323-4243-ae99-85909be34de4', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'c41a478e-0323-4243-ae99-85909be34de4', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'c41a478e-0323-4243-ae99-85909be34de4', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'c41a478e-0323-4243-ae99-85909be34de4', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'c41a478e-0323-4243-ae99-85909be34de4', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'c41a478e-0323-4243-ae99-85909be34de4', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'DashBoard', N'c41a478e-0323-4243-ae99-85909be34de4', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'c41a478e-0323-4243-ae99-85909be34de4', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'c41a478e-0323-4243-ae99-85909be34de4', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Categories', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'DashBoard', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Function', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Orders', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Permission', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Role', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'System', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'User', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Approve')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Categories', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'DashBoard', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Function', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Orders', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Permission', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Role', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'System', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'User', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Create')
GO
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Categories', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'DashBoard', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Function', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Orders', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Permission', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Role', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'System', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'User', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Delete')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Categories', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'DashBoard', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Function', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Orders', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Permission', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Role', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'System', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'User', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'ExportExcel')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Categories', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'DashBoard', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Function', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Orders', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Permission', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Role', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'System', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'User', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'Update')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Categories', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Courses', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'DashBoard', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Function', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'NewUser', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Orders', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Permission', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Products', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Promotions', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Revenue', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Role', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'Statistics', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'System', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
INSERT [dbo].[Permissions] ([FunctionId], [RoleId], [CommandId]) VALUES (N'User', N'6fcf54b2-b8f0-4864-a358-9a0b072fc035', N'View')
GO
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (1, 1)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (5, 1)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (1, 2)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (5, 2)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (1, 3)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (5, 3)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (1, 4)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (1, 5)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (1, 6)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (4, 9)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (5, 11)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (5, 15)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (5, 16)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (5, 17)
INSERT [dbo].[PromotionInCourses] ([PromotionId], [CourseId]) VALUES (4, 20)
GO
SET IDENTITY_INSERT [dbo].[Promotions] ON 

INSERT [dbo].[Promotions] ([Id], [FromDate], [ToDate], [ApplyForAll], [DiscountPercent], [DiscountAmount], [Status], [Name], [Content]) VALUES (1, CAST(N'2020-12-13T00:00:00.0000000' AS DateTime2), CAST(N'2021-12-14T00:00:00.0000000' AS DateTime2), 0, 50, NULL, 1, N'Event 1', N'Giam Gia 50%')
INSERT [dbo].[Promotions] ([Id], [FromDate], [ToDate], [ApplyForAll], [DiscountPercent], [DiscountAmount], [Status], [Name], [Content]) VALUES (4, CAST(N'2020-12-01T00:00:00.0000000' AS DateTime2), CAST(N'2021-12-14T00:00:00.0000000' AS DateTime2), 0, NULL, 50000, 1, N'Event 123', N'Giam Gia')
INSERT [dbo].[Promotions] ([Id], [FromDate], [ToDate], [ApplyForAll], [DiscountPercent], [DiscountAmount], [Status], [Name], [Content]) VALUES (5, CAST(N'2019-12-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-12-14T00:00:00.0000000' AS DateTime2), 0, NULL, 40000, 1, N'Event 321', N'Giam Gia')
SET IDENTITY_INSERT [dbo].[Promotions] OFF
GO
/****** Object:  Index [IX_ActivateCourses_CourseId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_ActivateCourses_CourseId] ON [dbo].[ActivateCourses]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ActivateCourses_UserId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_ActivateCourses_UserId] ON [dbo].[ActivateCourses]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Announcements_UserId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_Announcements_UserId] ON [dbo].[Announcements]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AnnouncementUsers_AnnouncementId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_AnnouncementUsers_AnnouncementId] ON [dbo].[AnnouncementUsers]
(
	[AnnouncementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CommandInFunctions_FunctionId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_CommandInFunctions_FunctionId] ON [dbo].[CommandInFunctions]
(
	[FunctionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Comments_UserId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_Comments_UserId] ON [dbo].[Comments]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Courses_CategoryId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_Courses_CategoryId] ON [dbo].[Courses]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Lessons_CourseId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_Lessons_CourseId] ON [dbo].[Lessons]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_OrderId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_OrderId] ON [dbo].[OrderDetails]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_UserId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_UserId] ON [dbo].[Orders]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Permissions_FunctionId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_Permissions_FunctionId] ON [dbo].[Permissions]
(
	[FunctionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Permissions_RoleId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_Permissions_RoleId] ON [dbo].[Permissions]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PromotionInCourses_CourseId]    Script Date: 1/14/2021 2:42:11 PM ******/
CREATE NONCLUSTERED INDEX [IX_PromotionInCourses_CourseId] ON [dbo].[PromotionInCourses]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Courses] ADD  CONSTRAINT [DF__Courses__Price__5CD6CB2B]  DEFAULT (CONVERT([bigint],(0))) FOR [Price]
GO
ALTER TABLE [dbo].[ActivateCourses]  WITH CHECK ADD  CONSTRAINT [FK_ActivateCourses_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[ActivateCourses] CHECK CONSTRAINT [FK_ActivateCourses_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[ActivateCourses]  WITH CHECK ADD  CONSTRAINT [FK_ActivateCourses_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActivateCourses] CHECK CONSTRAINT [FK_ActivateCourses_Courses_CourseId]
GO
ALTER TABLE [dbo].[Announcements]  WITH CHECK ADD  CONSTRAINT [FK_Announcements_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Announcements] CHECK CONSTRAINT [FK_Announcements_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AnnouncementUsers]  WITH CHECK ADD  CONSTRAINT [FK_AnnouncementUsers_Announcements_AnnouncementId] FOREIGN KEY([AnnouncementId])
REFERENCES [dbo].[Announcements] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AnnouncementUsers] CHECK CONSTRAINT [FK_AnnouncementUsers_Announcements_AnnouncementId]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[CommandInFunctions]  WITH CHECK ADD  CONSTRAINT [FK_CommandInFunctions_Commands_CommandId] FOREIGN KEY([CommandId])
REFERENCES [dbo].[Commands] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CommandInFunctions] CHECK CONSTRAINT [FK_CommandInFunctions_Commands_CommandId]
GO
ALTER TABLE [dbo].[CommandInFunctions]  WITH CHECK ADD  CONSTRAINT [FK_CommandInFunctions_Functions_FunctionId] FOREIGN KEY([FunctionId])
REFERENCES [dbo].[Functions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CommandInFunctions] CHECK CONSTRAINT [FK_CommandInFunctions_Functions_FunctionId]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_Categories_CategoryId]
GO
ALTER TABLE [dbo].[Lessons]  WITH CHECK ADD  CONSTRAINT [FK_Lessons_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Lessons] CHECK CONSTRAINT [FK_Lessons_Courses_CourseId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_ActivateCourses_ActiveCourseId] FOREIGN KEY([ActiveCourseId])
REFERENCES [dbo].[ActivateCourses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_ActivateCourses_ActiveCourseId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders_OrderId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Commands_CommandId] FOREIGN KEY([CommandId])
REFERENCES [dbo].[Commands] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_Commands_CommandId]
GO
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Functions_FunctionId] FOREIGN KEY([FunctionId])
REFERENCES [dbo].[Functions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_Functions_FunctionId]
GO
ALTER TABLE [dbo].[PromotionInCourses]  WITH CHECK ADD  CONSTRAINT [FK_PromotionInCourses_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionInCourses] CHECK CONSTRAINT [FK_PromotionInCourses_Courses_CourseId]
GO
ALTER TABLE [dbo].[PromotionInCourses]  WITH CHECK ADD  CONSTRAINT [FK_PromotionInCourses_Promotions_PromotionId] FOREIGN KEY([PromotionId])
REFERENCES [dbo].[Promotions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionInCourses] CHECK CONSTRAINT [FK_PromotionInCourses_Promotions_PromotionId]
GO
/****** Object:  StoredProcedure [dbo].[CourseDetail]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[CourseDetail]
@id int
as	
begin
select Id, Name, CategoryId, Status, Image, Content, Description, CreationTime, CreatedUserName, CategoryName, CreatedName, sum(Price) Price, sum(DiscountAmount) DiscountAmount,sum(DiscountPercent) DiscountPercent 
from (
select ct.Name as CategoryName,c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, u.Name as CreatedName, c.Price, 0 DiscountAmount,0 DiscountPercent
	from Courses c, Categories ct, AspNetUsers u
	where c.CategoryId = ct.Id and u.UserName = c.CreatedUserName
	union all
	select ct.Name as CategoryName,c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, u.Name as CreatedName, c.Price,IIF(p.DiscountAmount is null,0,p.DiscountAmount),IIF(p.DiscountPercent is null,0,p.DiscountPercent)
	from Courses c
	inner join Categories ct
	on c.CategoryId = ct.Id
	inner join AspNetUsers u
	on u.UserName = c.CreatedUserName
	inner join PromotionInCourses pc
	on pc.CourseId = c.Id
	inner join Promotions p
	on p.Id = pc.PromotionId
	where p.FromDate <= GETDATE() and  p.ToDate >= GETDATE()
	) result
	where Id = @id
	group by Id, Name, CategoryId, Status, Image, Content, Description, CategoryId, CreationTime, CategoryName, CreatedUserName, CreatedName
end
GO
/****** Object:  StoredProcedure [dbo].[GetCountSalesDaily]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[GetCountSalesDaily]
	@fromDate NVARCHAR(20),
	@toDate NVARCHAR(20)
AS
BEGIN
				select CAST(o.CreationTime AS DATE) as Date,
				c.Name,
				u.UserName,
				u.Email,
				u.Name,
				count(c.Name) as CountProducts,
				sum(IIF(od.PromotionPrice is null, od.Price,od.PromotionPrice)) as Revenue,
				sum(IIF(od.PromotionPrice is null, od.Price,od.PromotionPrice) * 30 / 100) as Profit
				from Orders o
				inner join OrderDetails od
				on o.Id = od.OrderId
				inner join ActivateCourses ac
				on ac.Id = od.ActiveCourseId
				inner join Courses c
				on c.Id = ac.CourseId
				inner join AspNetUsers u
				on c.CreatedUserName = u.UserName
				where o.Status = 4 and o.CreationTime <= cast(@toDate as date) 
				AND o.CreationTime >= cast(@fromDate as date)
				group by o.CreationTime, c.Name, u.UserName, u.Email, u.Name
				order by o.CreationTime
END
GO
/****** Object:  StoredProcedure [dbo].[GetRevenueDaily]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetRevenueDaily]
	@fromDate NVARCHAR(20),
	@toDate NVARCHAR(20)
AS
BEGIN
				select CAST(o.CreationTime AS DATE) as Date,
				sum(IIF(od.PromotionPrice is null, od.Price,od.PromotionPrice)) as Revenue,
				sum(IIF(od.PromotionPrice is null, od.Price,od.PromotionPrice) * 30 / 100) as Profit
				from Orders o
				inner join OrderDetails od
				on o.Id = od.OrderId
				where o.Status = 4 and o.CreationTime <= cast(@toDate as date) 
				AND o.CreationTime >= cast(@fromDate as date)
				group by o.CreationTime
END
GO
/****** Object:  StoredProcedure [dbo].[HomeCategories]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[HomeCategories]
@categoryId int
as	
begin
select top 4 Id, Name, CategoryId, Status, Image, Content, Description, CategoryName, CreationTime, CreatedUserName, sum(Price) Price, sum(DiscountAmount) DiscountAmount,sum(DiscountPercent) DiscountPercent from (
select ct.Name as CategoryName, c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price, 0 DiscountAmount,0 DiscountPercent
	from Courses c, Categories ct
	where c.CategoryId = ct.Id and ct.ParentId = @categoryId
	union all
	select ct.Name as CategoryName, c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price,IIF(p.DiscountAmount is null,0,p.DiscountAmount),IIF(p.DiscountPercent is null,0,p.DiscountPercent)
	from Courses c
	inner join Categories ct
	on c.CategoryId = ct.Id and ct.ParentId = @categoryId
	inner join PromotionInCourses pc
	on pc.CourseId = c.Id
	inner join Promotions p
	on p.Id = pc.PromotionId
	where p.FromDate <= GETDATE() and  p.ToDate >= GETDATE()

	) result group by Id, Name, CategoryId, Status, Image, Content, Description, CategoryName, CategoryId, CreationTime, CreatedUserName
	order by CreationTime desc
end
GO
/****** Object:  StoredProcedure [dbo].[ListCourses]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ListCourses]
as
begin
SET NOCOUNT ON;
select Id, Name, CategoryId, Status, Image, Content, Description, CreationTime, CategoryName, CreatedUserName, sum(Price) Price, sum(DiscountAmount) DiscountAmount,sum(DiscountPercent) DiscountPercent 
from (
select ct.Name as CategoryName,c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price, 0 DiscountAmount,0 DiscountPercent
	from Courses c, Categories ct
	where c.CategoryId = ct.Id
	union all
	select ct.Name as CategoryName,c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price,IIF(p.DiscountAmount is null,0,p.DiscountAmount),IIF(p.DiscountPercent is null,0,p.DiscountPercent)
	from Courses c
	inner join Categories ct
	on c.CategoryId = ct.Id
	inner join PromotionInCourses pc
	on pc.CourseId = c.Id
	inner join Promotions p
	on p.Id = pc.PromotionId
	where p.FromDate <= GETDATE() and  p.ToDate >= GETDATE()
	) result
	group by Id, Name, CategoryId, Status, Image, Content, Description, CategoryId, CreationTime, CategoryName, CreatedUserName
end
GO
/****** Object:  StoredProcedure [dbo].[ListCoursesByCategoryId]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ListCoursesByCategoryId]
@categoryId int
as
begin
SET NOCOUNT ON;
select Id, Name, CategoryId, Status, Image, Content, Description, CreationTime, CategoryName, CreatedUserName, sum(Price) Price, sum(DiscountAmount) DiscountAmount,sum(DiscountPercent) DiscountPercent 
from (
select ct.Name as CategoryName,c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price, 0 DiscountAmount,0 DiscountPercent
	from Courses c, Categories ct
	where c.CategoryId = ct.Id and ct.Id = @categoryId
	union all
	select ct.Name as CategoryName,c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price,IIF(p.DiscountAmount is null,0,p.DiscountAmount),IIF(p.DiscountPercent is null,0,p.DiscountPercent)
	from Courses c
	inner join Categories ct
	on c.CategoryId = ct.Id and ct.Id = @categoryId
	inner join PromotionInCourses pc
	on pc.CourseId = c.Id
	inner join Promotions p
	on p.Id = pc.PromotionId
	where p.FromDate <= GETDATE() and  p.ToDate >= GETDATE()
	) result
	group by Id, Name, CategoryId, Status, Image, Content, Description, CategoryId, CreationTime, CategoryName, CreatedUserName
end
GO
/****** Object:  StoredProcedure [dbo].[ListCoursesByCategoryParentId]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ListCoursesByCategoryParentId]
@categoryId int
as
begin
SET NOCOUNT ON;
select Id, Name, CategoryId, Status, Image, Content, Description, CreationTime, CategoryName, CreatedUserName, sum(Price) Price, sum(DiscountAmount) DiscountAmount,sum(DiscountPercent) DiscountPercent 
from (
select ct.Name as CategoryName,c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price, 0 DiscountAmount,0 DiscountPercent
	from Courses c, Categories ct
	where c.CategoryId = ct.Id and ct.ParentId = @categoryId
	union all
	select ct.Name as CategoryName,c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price,IIF(p.DiscountAmount is null,0,p.DiscountAmount),IIF(p.DiscountPercent is null,0,p.DiscountPercent)
	from Courses c
	inner join Categories ct
	on c.CategoryId = ct.Id and ct.ParentId = @categoryId
	inner join PromotionInCourses pc
	on pc.CourseId = c.Id
	inner join Promotions p
	on p.Id = pc.PromotionId
	where p.FromDate <= GETDATE() and  p.ToDate >= GETDATE()
	) result
	group by Id, Name, CategoryId, Status, Image, Content, Description, CategoryId, CreationTime, CategoryName, CreatedUserName
end
GO
/****** Object:  StoredProcedure [dbo].[NewCourses]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NewCourses]
as	
begin
select top 6 Id, Name, CategoryId, Status, Image, Content, Description, CategoryName, CreationTime, CreatedUserName, sum(Price) Price, sum(DiscountAmount) DiscountAmount,sum(DiscountPercent) DiscountPercent from (
select ct.Name as CategoryName, c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price, 0 DiscountAmount,0 DiscountPercent
	from Courses c, Categories ct
	where c.CategoryId = ct.Id
	union all
	select ct.Name as CategoryName, c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price,IIF(p.DiscountAmount is null,0,p.DiscountAmount),IIF(p.DiscountPercent is null,0,p.DiscountPercent)
	from Courses c
	inner join Categories ct
	on c.CategoryId = ct.Id
	inner join PromotionInCourses pc
	on pc.CourseId = c.Id
	inner join Promotions p
	on p.Id = pc.PromotionId
	where p.FromDate <= GETDATE() and  p.ToDate >= GETDATE()
	) result group by Id, Name, CategoryId, Status, Image, Content, Description, CategoryName, CategoryId, CreationTime, CreatedUserName
	order by CreationTime desc
end
GO
/****** Object:  StoredProcedure [dbo].[RelatedCourses]    Script Date: 1/14/2021 2:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[RelatedCourses]
@categoryId int,
@courseId int
as	
begin
select top 6 Id, Name, CategoryId, Status, Image, Content, Description, CategoryName, CreationTime, CreatedUserName, sum(Price) Price, sum(DiscountAmount) DiscountAmount,sum(DiscountPercent) DiscountPercent from (
select ct.Name as CategoryName, c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price, 0 DiscountAmount,0 DiscountPercent
	from Courses c, Categories ct
	where c.CategoryId = ct.Id
	union all
	select ct.Name as CategoryName, c.Id, c.Name,c.CategoryId, c.Status, c.Image, c.Content, c.Description, c.CreationTime, c.CreatedUserName, c.Price,IIF(p.DiscountAmount is null,0,p.DiscountAmount),IIF(p.DiscountPercent is null,0,p.DiscountPercent)
	from Courses c
	inner join Categories ct
	on c.CategoryId = ct.Id
	inner join PromotionInCourses pc
	on pc.CourseId = c.Id
	inner join Promotions p
	on p.Id = pc.PromotionId
	where p.FromDate <= GETDATE() and  p.ToDate >= GETDATE()
	) result 
	where result.CategoryId = @categoryId and result.Id != @courseId
	group by Id, Name, CategoryId, Status, Image, Content, Description, CategoryName, CategoryId, CreationTime, CreatedUserName
	order by CreationTime desc
end
GO
USE [master]
GO
ALTER DATABASE [DbKhoaHocTrucTuyen] SET  READ_WRITE 
GO
