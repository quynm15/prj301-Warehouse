USE [master]
GO
CREATE DATABASE [WarehouseDB] ON  PRIMARY 
( NAME = N'WarehouseDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\WarehouseDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WarehouseDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\WarehouseDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WarehouseDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WarehouseDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WarehouseDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WarehouseDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WarehouseDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WarehouseDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [WarehouseDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WarehouseDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WarehouseDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WarehouseDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WarehouseDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WarehouseDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WarehouseDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WarehouseDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WarehouseDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WarehouseDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WarehouseDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WarehouseDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WarehouseDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WarehouseDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WarehouseDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WarehouseDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WarehouseDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WarehouseDB] SET RECOVERY FULL 
GO
ALTER DATABASE [WarehouseDB] SET  MULTI_USER 
GO
ALTER DATABASE [WarehouseDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WarehouseDB] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'WarehouseDB', N'ON'
GO
USE [WarehouseDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account_Feature](
	[Username] [varchar](50) NOT NULL,
	[FeatureID] [int] NOT NULL,
 CONSTRAINT [PK_Account_Feature] PRIMARY KEY CLUSTERED 
(
	[Username] ASC,
	[FeatureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[FullName] [nvarchar](150) NULL,
	[Dob] [date] NULL,
	[Address] [nvarchar](150) NULL,
	[Phone] [varchar](10) NULL,
	[Email] [varchar](50) NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](150) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Export](
	[ExportID] [int] NOT NULL,
	[ExportDate] [date] NULL,
	[Exporter] [varchar](50) NULL,
	[Recipient] [nvarchar](150) NULL,
	[Comment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Export] PRIMARY KEY CLUSTERED 
(
	[ExportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExportDetail](
	[ExportID] [int] NOT NULL,
	[ProductID] [varchar](15) NOT NULL,
	[Quantity] [real] NULL,
	[ExpDate] [date] NULL,
	[MfgDate] [date] NULL,
	[Comment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ExportDetail] PRIMARY KEY CLUSTERED 
(
	[ExportID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feature](
	[featureID] [int] NOT NULL,
	[url] [varchar](500) NOT NULL,
 CONSTRAINT [PK_Feature] PRIMARY KEY CLUSTERED 
(
	[featureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import](
	[ImportID] [int] NOT NULL,
	[ImportDate] [date] NULL,
	[Importer] [varchar](50) NULL,
	[Shipper] [nvarchar](150) NULL,
	[Comment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Import] PRIMARY KEY CLUSTERED 
(
	[ImportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportDetail](
	[ImportID] [int] NOT NULL,
	[ProductID] [varchar](15) NOT NULL,
	[Quantity] [real] NULL,
	[ExpDate] [date] NULL,
	[MfgDate] [date] NULL,
	[Comment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ImportDetail] PRIMARY KEY CLUSTERED 
(
	[ImportID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [varchar](15) NOT NULL,
	[ProductName] [nvarchar](150) NOT NULL,
	[CategoryID] [int] NULL,
	[SupplierID] [int] NULL,
	[unit] [nvarchar](50) NULL,
	[Quantity] [real] NULL,
	[unitPrice] [decimal](15, 5) NULL,
	[isActive] [bit] NULL,
	[Comment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](150) NOT NULL,
	[ContactName] [nvarchar](150) NULL,
	[Phone] [varchar](10) NULL,
	[Email] [varchar](50) NULL,
	[Address] [nvarchar](150) NULL,
	[Province] [nvarchar](50) NULL,
	[District] [nvarchar](50) NULL,
	[isActive] [bit] NULL,
	[Comment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Accounts] ([Username], [Password], [FullName], [Dob], [Address], [Phone], [Email], [isActive]) VALUES (N'admin', N'admin', N'Administrator', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Accounts] ([Username], [Password], [FullName], [Dob], [Address], [Phone], [Email], [isActive]) VALUES (N'mra', N'mra', N'mr.A', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Accounts] ([Username], [Password], [FullName], [Dob], [Address], [Phone], [Email], [isActive]) VALUES (N'quynm', N'12345', N'Nguyen Manh Quy', CAST(N'2001-04-06' AS Date), N'DH FPT', N'0123456789', N'quynmhe153283@fpt.edu.vn', 1)
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [isActive]) VALUES (10, N'Chung', N'Đồ dùng chung các bộ phận', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [isActive]) VALUES (11, N'Bar', N'Đồ quầy bar pha chế', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [isActive]) VALUES (12, N'Bếp cơm', N'Nguyên liệu bếp cơm', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [isActive]) VALUES (13, N'Bếp lẩu', N'Nguyên liệu bộ phận lẩu', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [isActive]) VALUES (14, N'Bếp phở', N'Nguyên liệu bếp phở', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [isActive]) VALUES (15, N'Đồ uống đóng chai', N'Các loại nước đóng chai', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [isActive]) VALUES (16, N'Quầy ăn vặt', N'Nguyên liệu quầy đồ ăn vặt', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [isActive]) VALUES (17, N'CCDC', N'Công cụ dụng cụ và các vật liệu khác', 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0001', N'Trà đào cozy', 11, NULL, N'hộp', 11, NULL, 1, N'hộp 20 túi lọc')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0002', N'Hồng trà
', 11, NULL, N'túi', 3, NULL, 1, N'500g')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0003', N'Trà nhài
', 11, NULL, N'túi', 2, NULL, 1, N'500g')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0004', N'Trân châu
 đen Wing', 11, NULL, N'túi', 9.5, NULL, 1, N'3kg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0005', N'Trân châu
 trắng 3Q', 11, NULL, N'túi', 15, NULL, 1, N'2kg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0006', N'Bột cacao', 11, NULL, N'túi', 4, NULL, 1, N'1kg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0007', N'Đào ngâm', 11, NULL, N'lon', 5, NULL, 1, N'1kg - 16 miếng')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0008', N'Sữa đặc NSPN', 11, NULL, N'hộp', 48, NULL, 1, N'1kg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0009', N'Bột cafe', 11, NULL, N'túi', 4, NULL, 1, N'1kg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0010', N'Siro dâu wonderfarm', 11, NULL, N'chai', 3, NULL, 1, N'560ml')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0001', N'Trứng gà', 12, NULL, N'quả', 2500, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0002', N'Dầu ăn', 12, NULL, N'lít', 10, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0003', N'Giò lụa', 12, NULL, N'kg', 2, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0004', N'Chả cá', 12, NULL, N'kg', 81, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0005', N'Gà góc tư', 12, NULL, N'kg', 107, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0006', N'Nạc vai', 12, NULL, N'kg', 193, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0007', N'Cánh gà', 12, NULL, N'kg', 45, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0008', N'Ba chỉ', 12, NULL, N'kg', 96, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0009', N'Tỏi gà', 12, NULL, N'kg', 30, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0010', N'Xúc xích', 12, NULL, N'kg', 23, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0001', N'Dấm trắng
', 10, NULL, N'chai', 84, NULL, 1, N'chai 500ml')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0002', N'Dầu ăn
', 10, NULL, N'can', 9, NULL, 1, N'can 19.8L')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0003', N'Đường trắng
', 10, NULL, N'kg', 4, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0004', N'Đường vàng
', 10, NULL, N'kg', 11, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0005', N'Mì chính Vedan
', 10, NULL, N'kg', 5, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0006', N'Lạp xưởng 
', 10, NULL, N'gói', 0, NULL, 1, N'gói 500g')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0007', N'Mắm 168
', 10, NULL, N'chai', 16, NULL, 1, N'chai 860ml')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0008', N'Mắm STK
', 10, NULL, N'can', 15, NULL, 1, N'can 4.8L')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0009', N'Sate tôm
', 10, NULL, N'lọ', 60, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0010', N'Bột canh
', 10, NULL, N'gói', 305, NULL, 1, N'gói 190g')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0001', N'7-up', 15, NULL, N'chai', 72, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0002', N'Aquafina
', 15, NULL, N'chai', 200, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0003', N'Good mood
', 15, NULL, N'chai', 0, NULL, 0, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0004', N'Lipton
', 15, NULL, N'chai', 96, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0005', N'Mountain Dew
', 15, NULL, N'chai', 24, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0006', N'Pepsi thường
', 15, NULL, N'chai', 72, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0007', N'Pepsi chanh
', 15, NULL, N'lon', 96, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0008', N'Sting vàng', 15, NULL, N'chai', 72, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0009', N'Sting đỏ', 15, NULL, N'chai', 144, NULL, 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0010', N'Olong tea', 15, NULL, N'chai', 0, NULL, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (1, N'Công ty A', N'Mr. Đạt', N'0912345678', NULL, N'Thôn 3, Thạch Hòa', N'Hà Nội', N'Thạch Thất', 1, NULL)
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO
ALTER TABLE [dbo].[Account_Feature]  WITH CHECK ADD  CONSTRAINT [FK_Account_Feature_Accounts] FOREIGN KEY([Username])
REFERENCES [dbo].[Accounts] ([Username])
GO
ALTER TABLE [dbo].[Account_Feature] CHECK CONSTRAINT [FK_Account_Feature_Accounts]
GO
ALTER TABLE [dbo].[Account_Feature]  WITH CHECK ADD  CONSTRAINT [FK_Account_Feature_Feature] FOREIGN KEY([FeatureID])
REFERENCES [dbo].[Feature] ([featureID])
GO
ALTER TABLE [dbo].[Account_Feature] CHECK CONSTRAINT [FK_Account_Feature_Feature]
GO
ALTER TABLE [dbo].[Export]  WITH CHECK ADD  CONSTRAINT [FK_Export_Accounts] FOREIGN KEY([Exporter])
REFERENCES [dbo].[Accounts] ([Username])
GO
ALTER TABLE [dbo].[Export] CHECK CONSTRAINT [FK_Export_Accounts]
GO
ALTER TABLE [dbo].[ExportDetail]  WITH CHECK ADD  CONSTRAINT [FK_ExportDetail_Export] FOREIGN KEY([ExportID])
REFERENCES [dbo].[Export] ([ExportID])
GO
ALTER TABLE [dbo].[ExportDetail] CHECK CONSTRAINT [FK_ExportDetail_Export]
GO
ALTER TABLE [dbo].[ExportDetail]  WITH CHECK ADD  CONSTRAINT [FK_ExportDetail_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ExportDetail] CHECK CONSTRAINT [FK_ExportDetail_Products]
GO
ALTER TABLE [dbo].[Import]  WITH CHECK ADD  CONSTRAINT [FK_Import_Accounts] FOREIGN KEY([Importer])
REFERENCES [dbo].[Accounts] ([Username])
GO
ALTER TABLE [dbo].[Import] CHECK CONSTRAINT [FK_Import_Accounts]
GO
ALTER TABLE [dbo].[ImportDetail]  WITH CHECK ADD  CONSTRAINT [FK_ImportDetail_Import] FOREIGN KEY([ImportID])
REFERENCES [dbo].[Import] ([ImportID])
GO
ALTER TABLE [dbo].[ImportDetail] CHECK CONSTRAINT [FK_ImportDetail_Import]
GO
ALTER TABLE [dbo].[ImportDetail]  WITH CHECK ADD  CONSTRAINT [FK_ImportDetail_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ImportDetail] CHECK CONSTRAINT [FK_ImportDetail_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
USE [master]
GO
ALTER DATABASE [WarehouseDB] SET  READ_WRITE 
GO
