USE [master]
GO
/****** Object:  Database [BookStore0]    Script Date: 2/1/2024 12:01:06 ******/
CREATE DATABASE [BookStore0]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookStore0', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BookStore0.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookStore0_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BookStore0_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BookStore0] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookStore0].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookStore0] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookStore0] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookStore0] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookStore0] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookStore0] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookStore0] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookStore0] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookStore0] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookStore0] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookStore0] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookStore0] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookStore0] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookStore0] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookStore0] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookStore0] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BookStore0] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookStore0] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookStore0] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookStore0] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookStore0] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookStore0] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookStore0] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookStore0] SET RECOVERY FULL 
GO
ALTER DATABASE [BookStore0] SET  MULTI_USER 
GO
ALTER DATABASE [BookStore0] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookStore0] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookStore0] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookStore0] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookStore0] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BookStore0] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BookStore0', N'ON'
GO
ALTER DATABASE [BookStore0] SET QUERY_STORE = ON
GO
ALTER DATABASE [BookStore0] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BookStore0]
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 2/1/2024 12:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsVisible] [bit] NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[UpdatedDate] [date] NOT NULL,
 CONSTRAINT [PK_Authors] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 2/1/2024 12:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Format] [nvarchar](max) NOT NULL,
	[ISBN] [bigint] NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[img_path] [nvarchar](max) NULL,
	[CategoryId] [int] NOT NULL,
	[AuthorId] [int] NOT NULL,
	[BookStar] [float] NULL,
	[PublicationYear] [date] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[QuantityInStock] [int] NOT NULL,
	[IsDeleted] [bit] NULL,
	[IsVisible] [bit] NULL,
	[CreatedDate] [date] NOT NULL,
	[UpdatedDate] [date] NOT NULL,
 CONSTRAINT [PK_Books] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 2/1/2024 12:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItem]    Script Date: 2/1/2024 12:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BookID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[CartId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2/1/2024 12:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsVisible] [bit] NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[UpdatedDate] [date] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 2/1/2024 12:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[BookName] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderTable]    Script Date: 2/1/2024 12:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderTable](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleMaster]    Script Date: 2/1/2024 12:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RollName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRolesMapping]    Script Date: 2/1/2024 12:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRolesMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usertbl]    Script Date: 2/1/2024 12:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usertbl](
	[Name] [nvarchar](120) NOT NULL,
	[Lastlogin] [date] NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Password] [nvarchar](18) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Authors] ON 

INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (54, N'Adam Kay', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (55, N'Daniel Kahneman', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (56, N'Paul Kalanithi', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (57, N'Russ Harris', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (58, N'Viktor E. Frankl', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (59, N'Oliver Sacks', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (60, N'Michael Mosley', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (61, N'Jordan B. Peterson', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (62, N'Atul Gawande', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (63, N'Giulia Enders', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (64, N'Norman Doidge', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (65, N'Anthony William', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (66, N'Keri Smith', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (67, N'Dr. Natasha Campbell-McBride', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (68, N'Austin Kleon', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (69, N'Eline Snel', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (70, N'Michael Greger', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (71, N'Tina Payne Bryson', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (72, N'Juju Sundin', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (73, N'American Psychiatric Association', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (74, N'Philippa Perry', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (75, N'American Psychological Association', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (76, N'Dr. Eben Alexander', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (77, N'Rebecca Skloot', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (78, N'Tony Attwood', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (79, N'Henry Marsh', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (80, N'Steven R. Gundry', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (81, N'Michael Pollan', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (82, N'John Gottman', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (83, N'Allen Carr', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (84, N'J. Mark G. Williams', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (85, N'Jennifer Worth', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (86, N'Matthew McKay', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (87, N'Bruce D. Perry', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (88, N'Frederic Delavier', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (89, N'Johanna Basford', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (90, N'Esther Perel', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (91, N'Joe Dispenza', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (92, N'Stephen Hawking', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (93, N'Charles Duhigg', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (94, N'Neil Degrasse Tyson', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (95, N'Tim Marshall', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (96, N'Randall Munroe', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (97, N'Jared Diamond', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (98, N'Leslie Kaminoff', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (99, N'Peter Mayle', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (100, N'Saroo Brierley', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (101, N'Jon Krakauer', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (102, N'Bill Bryson', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (103, N'Raynor Winn', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (104, N'Ben Goldacre', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (105, N'Wynn Kapit', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (106, N'Nassim Nicholas Taleb', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (107, N'Jon Ronson', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (108, N'Carlo Rovelli', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (109, N'Rachel Ignotofsky', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (110, N'Naomi Klein', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (111, N'Rick Hanson', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (112, N'Barbara Oakley', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (113, N'Greta Thunberg', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (114, N'Peter Wohlleben', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (115, N'James Dashner', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (116, N'Douglas R. Hofstadter', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (117, N'Nick Bostrom', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (118, N'Luke Heaton', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (119, N'Richard Dawkins', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (120, N'Edwin A. Abbott', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (121, N'Louise Tucker', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (122, N'Eric Taylor', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (123, N'James Gurney', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (124, N'Blake Snyder', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (125, N'Alexa Chung', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (126, N'Brandon Stanton', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (127, N'TAYLOR JENKINS REID', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (128, N'Susan Sontag', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (129, N'Chika Miyata', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (130, N'Neil Gaiman', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (131, N'Josef Albers', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (132, N'Derren Brown', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (133, N'Elizabeth James', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (134, N'Beth Kempton', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (135, N'John Thompson', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (136, N'Kassia St. Clair', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (137, N'Dr. Shinichi Suzuki', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (138, N'Banksy', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (139, N'Aziz Ansari', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (140, N'Betty Edwards', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (141, N'Michael Diamond', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (142, N'Bruce Foster', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (143, N'Ellen Lupton', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (144, N'Gabri Joy Kirkendall', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (145, N'Florence Welch', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (146, N'Matt Zoller Seitz', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (147, N'Leonard Koren', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (148, N'Matthew Frederick', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (149, N'Bruno Munari', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (150, N'British Library', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (151, N'Scott McCloud', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (152, N'ABRSM', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
GO
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (153, N'James Bastien', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (154, N'InÃ¨s de La Fressange', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (155, N'Daniel J. Levitin', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (156, N'Henry Carroll', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (157, N'Archive for Research in Archetypal Symbolism', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (158, N'T. Colin Campbell', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (159, N'Robert McKee', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (160, N'Jeffrey Brown', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (161, N'Gaston Bachelard', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (162, N'Tina Fey', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (163, N'Vicki Wienand', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (164, N'Tomoko Nakamichi', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (165, N'Jason Hazeley', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Authors] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (166, N'Unknown', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
SET IDENTITY_INSERT [dbo].[Authors] OFF
GO
SET IDENTITY_INSERT [dbo].[Books] ON 

INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (314, N'This is Going to Hurt', N'Paperback', 9781509858637, CAST(7.60 AS Decimal(10, 2)), N'/book-covers/Medical/0000001.jpg', 1, 54, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (315, N'Thinking, Fast and Slow', N'Paperback', 9780141033570, CAST(11.50 AS Decimal(10, 2)), N'~/book-covers/Medical/0000002.jpg', 1, 55, 1.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (316, N'When Breath Becomes Air', N'Paperback', 9781784701994, CAST(9.05 AS Decimal(10, 2)), N'~/book-covers/Medical/0000003.jpg', 1, 56, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (317, N'The Happiness Trap', N'Paperback', 9781845298258, CAST(8.34 AS Decimal(10, 2)), N'/book-covers/Medical/0000004.jpg', 1, 57, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (318, N'Man''s Search For Meaning', N'Paperback', 9781846041242, CAST(9.66 AS Decimal(10, 2)), N'~/book-covers/Medical/0000005.jpg', 1, 58, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (319, N'The Man Who Mistook His Wife for a Hat', N'Paperback', 9780330523622, CAST(5.92 AS Decimal(10, 2)), N'~/book-covers/Medical/0000006.jpg', 1, 59, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (320, N'The 8-week Blood Sugar Diet', N'Paperback', 9781780722405, CAST(8.85 AS Decimal(10, 2)), N'~/book-covers/Medical/0000007.jpg', 1, 60, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (321, N'The Clever Guts Diet', N'Paperback', 9781780723044, CAST(8.92 AS Decimal(10, 2)), N'~/book-covers/Medical/0000008.jpg', 1, 60, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (323, N'Being Mortal', N'Paperback', 9781846685828, CAST(9.03 AS Decimal(10, 2)), N'~/book-covers/Medical/0000010.jpg', 1, 62, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (324, N'Gut', N'Paperback', 9781925228601, CAST(10.49 AS Decimal(10, 2)), N'~/book-covers/Medical/0000011.jpg', 1, 63, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (325, N'The Brain That Changes Itself', N'Paperback', 9780141038872, CAST(11.03 AS Decimal(10, 2)), N'~/book-covers/Medical/0000012.jpg', 1, 64, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (326, N'Medical Medium Liver Rescue', N'Hardback', 9781401954406, CAST(23.76 AS Decimal(10, 2)), N'~/book-covers/Medical/0000013.jpg', 1, 65, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (327, N'Wreck This Journal', N'Paperback', 9780141976143, CAST(9.59 AS Decimal(10, 2)), N'~/book-covers/Medical/0000014.jpg', 1, 66, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (329, N'12 Rules for Life', N'Paperback', 9780141988511, CAST(10.26 AS Decimal(10, 2)), N'~/book-covers/Medical/0000016.jpg', 1, 61, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (330, N'Gut and Psychology Syndrome', N'Paperback', 9780954852023, CAST(19.48 AS Decimal(10, 2)), N'~/book-covers/Medical/0000017.jpg', 1, 166, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (331, N'Medical Medium Thyroid Healing', N'Hardback', 9781401948368, CAST(17.26 AS Decimal(10, 2)), N'~/book-covers/Medical/0000018.jpg', 1, 65, 1.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (332, N'Steal Like an Artist', N'Paperback', 9780761169253, CAST(8.81 AS Decimal(10, 2)), N'~/book-covers/Medical/0000019.jpg', 1, 68, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (333, N'Sitting Still Like A Frog', N'Paperback', 9781611800586, CAST(10.40 AS Decimal(10, 2)), N'~/book-covers/Medical/0000020.jpg', 1, 69, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 7, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (334, N'How Not To Die', N'Paperback', 9781509852505, CAST(10.33 AS Decimal(10, 2)), N'~/book-covers/Medical/0000021.jpg', 1, 70, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (335, N'The Whole-Brain Child', N'Paperback', 9781780338378, CAST(11.23 AS Decimal(10, 2)), N'~/book-covers/Medical/0000022.jpg', 1, 71, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (336, N'Birth Skills', N'Paperback', 9780091922146, CAST(17.03 AS Decimal(10, 2)), N'~/book-covers/Medical/0000023.jpg', 1, 72, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (337, N'Diagnostic and Statistical Manual of Mental Disorders (DSM-5)', N'Paperback', 9780890425558, CAST(95.94 AS Decimal(10, 2)), N'~/book-covers/Medical/0000024.jpg', 1, 73, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 7, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (338, N'Medical Medium Celery Juice', N'Hardback', 9781401957650, CAST(14.01 AS Decimal(10, 2)), N'~/book-covers/Medical/0000025.jpg', 1, 65, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (339, N'The Book You Wish Your Parents Had Read (and Your Children Will Be Glad That You Did)', N'Hardback', 9780241250990, CAST(13.03 AS Decimal(10, 2)), N'~/book-covers/Medical/0000026.jpg', 1, 74, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (340, N'Publication Manual of the American Psychological Association', N'Paperback', 9781433805615, CAST(30.49 AS Decimal(10, 2)), N'~/book-covers/Medical/0000027.jpg', 1, 75, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (341, N'Proof of Heaven', N'Paperback', 9781451695199, CAST(13.01 AS Decimal(10, 2)), N'~/book-covers/Medical/0000028.jpg', 1, 76, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (342, N'The Immortal Life of Henrietta Lacks', N'Paperback', 9780330533447, CAST(8.48 AS Decimal(10, 2)), N'~/book-covers/Medical/0000029.jpg', 1, 77, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (343, N'The Complete Guide to Asperger''s Syndrome', N'Paperback', 9781843106692, CAST(20.08 AS Decimal(10, 2)), N'~/book-covers/Medical/0000030.jpg', 1, 78, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (344, N'The Checklist Manifesto', N'Paperback', 9781846683145, CAST(9.04 AS Decimal(10, 2)), N'~/book-covers/Medical/0000031.jpg', 1, 62, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (345, N'Do No Harm', N'Paperback', 9781780225920, CAST(8.00 AS Decimal(10, 2)), N'~/book-covers/Medical/0000032.jpg', 1, 79, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (346, N'The Anatomy Coloring Book', N'Paperback', 9780321832016, CAST(24.25 AS Decimal(10, 2)), N'~/book-covers/Medical/0000033.jpg', 1, 105, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (347, N'The Plant Paradox', N'Hardback', 9780062427137, CAST(16.53 AS Decimal(10, 2)), N'~/book-covers/Medical/0000034.jpg', 1, 80, 1.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (348, N'Wreck This Journal Everywhere', N'Paperback', 9781846148583, CAST(5.83 AS Decimal(10, 2)), N'~/book-covers/Medical/0000035.jpg', 1, 66, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (349, N'How to Change Your Mind', N'Paperback', 9780141985138, CAST(10.28 AS Decimal(10, 2)), N'~/book-covers/Medical/0000036.jpg', 1, 81, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (350, N'Raising an Emotionally Intelligent Child', N'Paperback', 9780684838656, CAST(11.21 AS Decimal(10, 2)), N'~/book-covers/Medical/0000037.jpg', 1, 82, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (351, N'Allen Carr''s Easy Way to Stop Smoking', N'Paperback', 9781405923316, CAST(9.53 AS Decimal(10, 2)), N'~/book-covers/Medical/0000038.jpg', 1, 83, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 7, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (352, N'The Mindful Way through Depression', N'Paperback', 9781593851286, CAST(17.54 AS Decimal(10, 2)), N'~/book-covers/Medical/0000039.jpg', 1, 84, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (353, N'Call The Midwife', N'Paperback', 9780753823835, CAST(7.90 AS Decimal(10, 2)), N'~/book-covers/Medical/0000040.jpg', 1, 85, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (354, N'The Dialectical Behavior Therapy Skills Workbook', N'Paperback', 9781572245136, CAST(15.49 AS Decimal(10, 2)), N'~/book-covers/Medical/0000041.jpg', 1, 86, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (355, N'The Reality Slap', N'Paperback', 9781780332024, CAST(7.82 AS Decimal(10, 2)), N'~/book-covers/Medical/0000042.jpg', 1, 57, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (356, N'The Boy Who Was Raised as a Dog, 3rd Edition', N'Paperback', 9780465094455, CAST(13.64 AS Decimal(10, 2)), N'~/book-covers/Medical/0000043.jpg', 1, 87, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (357, N'Strength Training Anatomy', N'Paperback', 9780736092265, CAST(13.83 AS Decimal(10, 2)), N'~/book-covers/Medical/0000044.jpg', 1, 88, 1.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (358, N'The Brain That Changes Itself', N'Paperback', 9780143113102, CAST(15.22 AS Decimal(10, 2)), N'~/book-covers/Medical/0000045.jpg', 1, 64, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (359, N'Lost Ocean', N'Paperback', 9780753557150, CAST(12.39 AS Decimal(10, 2)), N'~/book-covers/Medical/0000046.jpg', 1, 89, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (360, N'Mating in Captivity', N'Paperback', 9780060753641, CAST(12.37 AS Decimal(10, 2)), N'~/book-covers/Medical/0000047.jpg', 1, 90, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (361, N'This is Going to Hurt', N'Hardback', 9781509858613, CAST(12.81 AS Decimal(10, 2)), N'~/book-covers/Medical/0000048.jpg', 1, 54, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (362, N'You Are the Placebo', N'Paperback', 9781781802571, CAST(14.40 AS Decimal(10, 2)), N'~/book-covers/Medical/0000049.jpg', 1, 91, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (363, N'The Man Who Mistook His Wife for a Hat', N'Paperback', 9780330523622, CAST(5.92 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000005.jpg', 2, 59, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (364, N'A Brief History Of Time', N'Paperback', 9780857501004, CAST(9.62 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000006.jpg', 2, 92, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (365, N'The Clever Guts Diet', N'Paperback', 9781780723044, CAST(8.92 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000007.jpg', 2, 60, 1.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (366, N'Being Mortal', N'Paperback', 9781846685828, CAST(9.03 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000008.jpg', 2, 62, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (367, N'The Power of Habit', N'Paperback', 9781847946249, CAST(10.41 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000009.jpg', 2, 93, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (368, N'Gut', N'Paperback', 9781925228601, CAST(10.49 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000010.jpg', 2, 63, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (369, N'The Brain That Changes Itself', N'Paperback', 9780141038872, CAST(11.03 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000011.jpg', 2, 64, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (370, N'Astrophysics for People in a Hurry', N'Hardback', 9780393609394, CAST(13.37 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000012.jpg', 2, 94, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (371, N'Prisoners of Geography', N'Paperback', 9781783962433, CAST(10.86 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000013.jpg', 2, 95, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (372, N'What If?', N'Paperback', 9781848549562, CAST(10.62 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000014.jpg', 2, 96, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (373, N'Guns, Germs And Steel', N'Paperback', 9780099302780, CAST(13.17 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000015.jpg', 2, 97, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (374, N'Yoga Anatomy', N'Paperback', 9781450400244, CAST(17.73 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000016.jpg', 2, 98, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (375, N'Where Did I Come From?', N'Paperback', 9780818402531, CAST(9.51 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000017.jpg', 2, 99, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (376, N'Lion', N'Paperback', 9781405930994, CAST(8.85 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000018.jpg', 2, 100, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (377, N'A Brief History Of Time', N'Paperback', 9780553176988, CAST(9.12 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000019.jpg', 2, 92, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (378, N'Into the Wild', N'Paperback', 9780330351690, CAST(7.07 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000020.jpg', 2, 101, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (379, N'A Short History of Nearly Everything', N'Paperback', 9780552151740, CAST(10.92 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000021.jpg', 2, 102, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (380, N'The Salt Path', N'Paperback', 9781405937184, CAST(9.53 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000022.jpg', 2, 103, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (381, N'The Immortal Life of Henrietta Lacks', N'Paperback', 9780330533447, CAST(8.48 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000023.jpg', 2, 77, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (382, N'Walden: Or, Life in the Woods', N'Paperback', 9780486284958, CAST(5.14 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000024.jpg', 2, 166, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (383, N'Key Muscles of Yoga: Your Guide to Functional Anatomy in Yoga', N'Paperback', 9781607432388, CAST(25.04 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000025.jpg', 2, 166, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (384, N'Bad Science', N'Paperback', 9780007284870, CAST(9.68 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000026.jpg', 2, 104, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (385, N'Thing Explainer', N'Hardback', 9781473620919, CAST(16.86 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000027.jpg', 2, 96, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (386, N'The Brain''s Way of Healing', N'Paperback', 9780141980805, CAST(10.26 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000028.jpg', 2, 64, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (387, N'The Anatomy Coloring Book', N'Paperback', 9780321832016, CAST(24.25 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000029.jpg', 2, 105, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (388, N'How to Change Your Mind', N'Paperback', 9780141985138, CAST(10.28 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000030.jpg', 2, 81, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (389, N'The Black Swan', N'Paperback', 9780141034591, CAST(10.72 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000031.jpg', 2, 106, 1.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (390, N'The Psychopath Test', N'Paperback', 9780330492270, CAST(8.23 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000032.jpg', 2, 107, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (391, N'Seven Brief Lessons on Physics', N'Paperback', 9780141981727, CAST(6.69 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000033.jpg', 2, 108, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (392, N'Women In Science', N'Hardback', 9781607749769, CAST(16.43 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000034.jpg', 2, 109, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (393, N'The Brain That Changes Itself', N'Paperback', 9780143113102, CAST(15.22 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000035.jpg', 2, 64, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (394, N'This Changes Everything', N'Paperback', 9780241956182, CAST(11.70 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000036.jpg', 2, 110, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (395, N'Lost Ocean', N'Paperback', 9780753557150, CAST(12.39 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000037.jpg', 2, 89, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (396, N'Buddha''s Brain', N'Paperback', 9781572246959, CAST(11.44 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000038.jpg', 2, 111, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (397, N'A Mind for Numbers', N'Paperback', 9780399165245, CAST(14.57 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000039.jpg', 2, 112, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (398, N'No One Is Too Small to Make a Difference', N'Paperback', 9780141991740, CAST(3.31 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000040.jpg', 2, 113, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (399, N'The Hidden Life of Trees', N'Hardback', 9781771642484, CAST(16.53 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000041.jpg', 2, 114, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (400, N'The Maze Runner', N'Paperback', 9781908435132, CAST(7.39 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000042.jpg', 2, 115, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (401, N'Godel, Escher, Bach', N'Paperback', 9780465026562, CAST(16.37 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000043.jpg', 2, 116, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (402, N'Superintelligence', N'Paperback', 9780198739838, CAST(9.93 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000044.jpg', 2, 117, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (403, N'How To', N'Hardback', 9781473680326, CAST(14.37 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000045.jpg', 2, 96, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (404, N'You Are the Placebo', N'Paperback', 9781781802571, CAST(14.40 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000046.jpg', 2, 91, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (405, N'Fooled by Randomness', N'Paperback', 9780141031484, CAST(9.96 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000047.jpg', 2, 106, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (406, N'A Brief History of Mathematical Thought', N'Paperback', 9781472117113, CAST(5.63 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000048.jpg', 2, 118, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 0, CAST(N'2023-12-08' AS Date), CAST(N'2024-02-01' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (407, N'So You''ve Been Publicly Shamed', N'Paperback', 9780330492294, CAST(4.96 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000049.jpg', 2, 107, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (408, N'The Selfish Gene', N'Paperback', 9780198788607, CAST(10.44 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000050.jpg', 2, 119, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (409, N'Flatland', N'Paperback', 9780486272634, CAST(2.81 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000051.jpg', 2, 120, 1.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (410, N'An Introductory Guide to Anatomy & Physiology', N'Paperback', 9781903348345, CAST(23.00 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000052.jpg', 2, 121, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (411, N'The Scorch Trials', N'Paperback', 9781906427795, CAST(5.13 AS Decimal(10, 2)), N'~/book-covers/Science-Geography/0000053.jpg', 2, 115, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (412, N'Music Theory in Practice, Grade 4', N'Sheet music', 9781860969454, CAST(8.23 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000050.jpg', 3, 122, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (413, N'Colour and Light', N'Paperback', 9780740797712, CAST(17.69 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000051.jpg', 3, 123, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (414, N'Save the Cat!', N'Paperback', 9781932907001, CAST(12.65 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000052.jpg', 3, 124, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
GO
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (415, N'It', N'Hardback', 9781846147548, CAST(19.72 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000053.jpg', 3, 125, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (416, N'Humans of New York', N'Hardback', 9781250058904, CAST(23.45 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000054.jpg', 3, 126, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (417, N'Daisy Jones and The Six', N'Paperback', 9781786331519, CAST(14.54 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000055.jpg', 3, 127, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (418, N'On Photography', N'Paperback', 9780141035789, CAST(9.32 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000056.jpg', 3, 128, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (419, N'How to Draw Almost Everything', N'Paperback', 9781631591402, CAST(11.91 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000057.jpg', 3, 129, 1.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (420, N'Art Matters', N'Hardback', 9781472260086, CAST(8.32 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000058.jpg', 3, 130, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (421, N'Interaction of Color', N'Paperback', 9780300179354, CAST(15.18 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000059.jpg', 3, 131, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (422, N'Tricks Of The Mind', N'Paperback', 9781905026357, CAST(10.52 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000060.jpg', 3, 132, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (423, N'Really RELAXING Colouring Book 6', N'Paperback', 9781908707499, CAST(8.28 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000061.jpg', 3, 133, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 7, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (424, N'Wabi Sabi', N'Hardback', 9780349421001, CAST(10.08 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000062.jpg', 3, 134, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (425, N'John Thompson''s Easiest Piano Course', N'Paperback', 9780877180135, CAST(6.80 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000063.jpg', 3, 135, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 3, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (426, N'The Secret Lives of Colour', N'Hardback', 9781473630819, CAST(17.75 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000064.jpg', 3, 136, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 7, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (427, N'Suzuki Piano School Volume 1 with CD', N'Mixed media product', 9780739051641, CAST(13.11 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000065.jpg', 3, 137, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (428, N'Alfred''s Basic Piano Library Lesson Book, Bk 2', N'Paperback', 9780882848129, CAST(6.90 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000066.jpg', 3, 166, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (429, N'Wall and Piece', N'Paperback', 9781844137879, CAST(18.69 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000067.jpg', 3, 166, 1.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (430, N'Piano Adventures - Lesson Book - Level 2A', N'Paperback', 9781616770815, CAST(7.43 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000068.jpg', 3, 166, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (431, N'Modern Romance', N'Paperback', 9780141981468, CAST(9.47 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000069.jpg', 3, 139, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (432, N'Drawing on the Right Side of the Brain', N'Paperback', 9780007116454, CAST(17.39 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000070.jpg', 3, 140, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (433, N'Beastie Boys Book', N'Hardback', 9780571308040, CAST(33.08 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000071.jpg', 3, 141, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (434, N'Harry Potter: A Pop-Up Book', N'Hardback', 9781608870080, CAST(17.43 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000072.jpg', 3, 142, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (435, N'Thinking with Type', N'Paperback', 9781568989693, CAST(17.73 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000073.jpg', 3, 143, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (436, N'Creative Lettering and Beyond', N'Paperback', 9781600583971, CAST(13.77 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000074.jpg', 3, 144, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (437, N'Useless Magic', N'Hardback', 9780241347935, CAST(21.07 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000075.jpg', 3, 145, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (438, N'The AB Guide to Music Theory, Part I', N'Sheet music', 9781854724465, CAST(7.24 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000076.jpg', 3, 122, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (439, N'Wes Anderson Collection, The', N'Hardback', 9780810997417, CAST(47.89 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000077.jpg', 3, 146, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (440, N'Wabi-Sabi for Artists, Designers, Poets & Philosophers', N'Paperback', 9780981484600, CAST(12.79 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000078.jpg', 3, 147, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (442, N'Secret Garden: 20 Postcards', N'Postcard book or pack', 9781856699464, CAST(7.12 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000080.jpg', 3, 89, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (443, N'Design as Art', N'Paperback', 9780141035819, CAST(9.32 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000081.jpg', 3, 149, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (444, N'Harry Potter - A Journey Through A History of Magic', N'Paperback', 9781408890776, CAST(15.19 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000082.jpg', 3, 150, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (445, N'Understanding Comics', N'Paperback', 9780060976255, CAST(16.35 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000083.jpg', 3, 151, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 7, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (446, N'Piano Scales & Broken Chords, Grade 1', N'Sheet music', 9781860969133, CAST(6.61 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000084.jpg', 3, 152, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (447, N'Bastien Piano Basics: Piano Level 1', N'Sheet music', 9780849752667, CAST(6.50 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000085.jpg', 3, 153, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (448, N'Parisian Chic', N'Paperback', 9782080200730, CAST(26.49 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000086.jpg', 3, 154, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (449, N'This Is Your Brain On Music', N'Paperback', 9781843547167, CAST(17.21 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000087.jpg', 3, 155, 0.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (450, N'Read This If You Want to Take Great Photographs', N'Paperback', 9781780673356, CAST(12.15 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000088.jpg', 3, 156, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (451, N'Alfred''s Basic Piano Prep Course Lesson Book, Bk B', N'Paperback', 9780882848228, CAST(7.14 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000089.jpg', 3, 166, 2.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (452, N'The Book of Symbols. Reflections on Archetypal Images', N'Hardback', 9783836514484, CAST(23.56 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000090.jpg', 3, 157, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (453, N'The China Study: Revised and Expanded Edition', N'Paperback', 9781941631560, CAST(15.58 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000091.jpg', 3, 158, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (454, N'Piano Adventures', N'Paperback', 9781616770754, CAST(7.56 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000092.jpg', 3, 166, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (455, N'Alfred''s Basic Piano Prep Course Lesson Book, Bk a', N'Paperback', 9780882848167, CAST(7.14 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000093.jpg', 3, 166, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 9, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (456, N'Story', N'Paperback', 9780413715609, CAST(24.10 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000094.jpg', 3, 159, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 2, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (457, N'Vader''s Little Princess', N'Hardback', 9781452118697, CAST(10.49 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000095.jpg', 3, 160, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (458, N'The Poetics of Space', N'Paperback', 9780143107521, CAST(10.14 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000096.jpg', 3, 161, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 6, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (459, N'Bossypants', N'Paperback', 9780751547832, CAST(8.29 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000097.jpg', 3, 162, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 10, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (460, N'Macbeth', N'Paperback', 9781107615496, CAST(11.55 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000098.jpg', 3, 163, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (461, N'Pattern Magic', N'Paperback', 9781856697057, CAST(14.32 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000099.jpg', 3, 164, 5.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 8, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (462, N'The Ladybird Book of the Shed', N'Hardback', 9780718183585, CAST(7.84 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000100.jpg', 3, 165, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 4, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (463, N'Piano Adventures', N'Paperback', 9781616776190, CAST(9.94 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000101.jpg', 3, 166, 4.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (464, N'Moleskine Pocket Sketchbook Black', N'Notebook / blank book', 9788883701054, CAST(9.79 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000102.jpg', 3, 166, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (466, N'Piano Exam Pieces 2019 & 2020, ABRSM Grade 1', N'Sheet music', 9781786010193, CAST(7.33 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000104.jpg', 3, 166, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 1, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (467, N'Piano Scales, Arpeggios & Broken Chords, Grade 2', N'Sheet music', 9781860969140, CAST(6.04 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000105.jpg', 3, 152, 3.5, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 7, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Books] ([Id], [Name], [Format], [ISBN], [Price], [img_path], [CategoryId], [AuthorId], [BookStar], [PublicationYear], [Description], [QuantityInStock], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (468, N'Musicophilia', N'Paperback', 9780330523592, CAST(9.43 AS Decimal(10, 2)), N'~/book-covers/Art-Photography/0000106.jpg', 3, 59, 2.1, CAST(N'2023-12-08' AS Date), N'No Description AVAILABLE', 5, 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
SET IDENTITY_INSERT [dbo].[Books] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (1, N'Medical', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Categories] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (2, N'Science-Geography', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
INSERT [dbo].[Categories] ([Id], [Name], [IsDeleted], [IsVisible], [CreatedDate], [UpdatedDate]) VALUES (3, N'Art-Photography', 0, 1, CAST(N'2023-12-08' AS Date), CAST(N'2023-12-08' AS Date))
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([OrderDetailID], [OrderID], [Quantity], [Price], [BookName]) VALUES (106, 38, 1, CAST(5.63 AS Decimal(10, 2)), N'A Brief History of Mathematical Thought')
INSERT [dbo].[OrderItems] ([OrderDetailID], [OrderID], [Quantity], [Price], [BookName]) VALUES (107, 38, 1, CAST(10.26 AS Decimal(10, 2)), N'12 Rules for Life')
INSERT [dbo].[OrderItems] ([OrderDetailID], [OrderID], [Quantity], [Price], [BookName]) VALUES (108, 38, 1, CAST(9.62 AS Decimal(10, 2)), N'A Brief History Of Time')
INSERT [dbo].[OrderItems] ([OrderDetailID], [OrderID], [Quantity], [Price], [BookName]) VALUES (109, 39, 1, CAST(5.63 AS Decimal(10, 2)), N'A Brief History of Mathematical Thought')
INSERT [dbo].[OrderItems] ([OrderDetailID], [OrderID], [Quantity], [Price], [BookName]) VALUES (110, 39, 1, CAST(10.26 AS Decimal(10, 2)), N'12 Rules for Life')
INSERT [dbo].[OrderItems] ([OrderDetailID], [OrderID], [Quantity], [Price], [BookName]) VALUES (111, 39, 1, CAST(9.62 AS Decimal(10, 2)), N'A Brief History Of Time')
INSERT [dbo].[OrderItems] ([OrderDetailID], [OrderID], [Quantity], [Price], [BookName]) VALUES (112, 41, 1, CAST(10.92 AS Decimal(10, 2)), N'A Short History of Nearly Everything')
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderTable] ON 

INSERT [dbo].[OrderTable] ([OrderID], [OrderDate], [TotalAmount], [UserId]) VALUES (38, CAST(N'2024-02-01T08:03:41.697' AS DateTime), CAST(25.51 AS Decimal(10, 2)), 3)
INSERT [dbo].[OrderTable] ([OrderID], [OrderDate], [TotalAmount], [UserId]) VALUES (39, CAST(N'2024-02-01T08:05:11.700' AS DateTime), CAST(25.51 AS Decimal(10, 2)), 3)
INSERT [dbo].[OrderTable] ([OrderID], [OrderDate], [TotalAmount], [UserId]) VALUES (40, CAST(N'2024-02-01T10:52:14.687' AS DateTime), CAST(0.00 AS Decimal(10, 2)), 2)
INSERT [dbo].[OrderTable] ([OrderID], [OrderDate], [TotalAmount], [UserId]) VALUES (41, CAST(N'2024-02-01T10:57:23.790' AS DateTime), CAST(10.92 AS Decimal(10, 2)), 2)
SET IDENTITY_INSERT [dbo].[OrderTable] OFF
GO
SET IDENTITY_INSERT [dbo].[RoleMaster] ON 

INSERT [dbo].[RoleMaster] ([ID], [RollName]) VALUES (1, N'Admin')
INSERT [dbo].[RoleMaster] ([ID], [RollName]) VALUES (2, N'User')
INSERT [dbo].[RoleMaster] ([ID], [RollName]) VALUES (3, N'Customer')
SET IDENTITY_INSERT [dbo].[RoleMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRolesMapping] ON 

INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (1, 5, 3)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (2, 1, 1)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (3, 2, 2)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (4, 3, 1)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (5, 4, 2)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (6, 1, 2)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (7, 10, 3)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (8, 12, 3)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (9, 14, 3)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (10, 15, 3)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (11, 23, 3)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (12, 25, 3)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (13, 29, 3)
INSERT [dbo].[UserRolesMapping] ([ID], [UserID], [RoleID]) VALUES (14, 32, 3)
SET IDENTITY_INSERT [dbo].[UserRolesMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Usertbl] ON 

INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'abdo', NULL, 1, N'123456')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'Customer', NULL, 2, N'customer')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'Admin', NULL, 3, N'admin')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'User', NULL, 4, N'user')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'New', NULL, 5, N'123456')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'test', NULL, 8, N'123456')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'cool', NULL, 10, N'123456')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'khalil', NULL, 12, N'123456')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'test1', NULL, 14, N'123456')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'Admin1', NULL, 15, N'123456')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'Ad', NULL, 23, N'123456')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'', NULL, 25, N'123456')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'd', NULL, 29, N'123456')
INSERT [dbo].[Usertbl] ([Name], [Lastlogin], [Id], [Password]) VALUES (N'22222', NULL, 32, N's')
SET IDENTITY_INSERT [dbo].[Usertbl] OFF
GO
/****** Object:  Index [IX_Books_AuthorId]    Script Date: 2/1/2024 12:01:06 ******/
CREATE NONCLUSTERED INDEX [IX_Books_AuthorId] ON [dbo].[Books]
(
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Books_CategoryId]    Script Date: 2/1/2024 12:01:06 ******/
CREATE NONCLUSTERED INDEX [IX_Books_CategoryId] ON [dbo].[Books]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Usertbl_Name]    Script Date: 2/1/2024 12:01:06 ******/
ALTER TABLE [dbo].[Usertbl] ADD  CONSTRAINT [UQ_Usertbl_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Books] ADD  CONSTRAINT [DF_Books_QuantityInStock]  DEFAULT ((0)) FOR [QuantityInStock]
GO
ALTER TABLE [dbo].[Books] ADD  CONSTRAINT [DF_ISDELETED_IsVisible]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Books] ADD  CONSTRAINT [DF_ISVisible_IsVisible]  DEFAULT ((1)) FOR [IsVisible]
GO
ALTER TABLE [dbo].[OrderTable] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[OrderTable] ADD  DEFAULT ((0.00)) FOR [TotalAmount]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_Books_Authors_AuthorId] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Authors] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_Books_Authors_AuthorId]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_Books_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_Books_Categories_CategoryId]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Usertbl] ([Id])
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [dbo].[Books] ([Id])
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD FOREIGN KEY([CartId])
REFERENCES [dbo].[Cart] ([CartId])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_OrderTable] FOREIGN KEY([OrderID])
REFERENCES [dbo].[OrderTable] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_OrderTable]
GO
ALTER TABLE [dbo].[OrderTable]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Usertbl] ([Id])
GO
ALTER TABLE [dbo].[UserRolesMapping]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[RoleMaster] ([ID])
GO
ALTER TABLE [dbo].[UserRolesMapping]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[RoleMaster] ([ID])
GO
ALTER TABLE [dbo].[UserRolesMapping]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Usertbl] ([Id])
GO
ALTER TABLE [dbo].[UserRolesMapping]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Usertbl] ([Id])
GO
USE [master]
GO
ALTER DATABASE [BookStore0] SET  READ_WRITE 
GO
