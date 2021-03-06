USE [master]
GO
DROP DATABASE [WarehouseDB]
GO
CREATE DATABASE [WarehouseDB] 
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
CREATE TABLE [dbo].[Delivery](
	[DeliveryID] [int] IDENTITY(1,1) NOT NULL,
	[DeliveryDate] [date] NULL,
	[DeliveryTime] [time](0) NULL,
	[Exporter] [varchar](50) NULL,
	[Recipient] [nvarchar](150) NULL,
	[Comment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Export] PRIMARY KEY CLUSTERED 
(
	[DeliveryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliveryDetail](
	[DeliveryID] [int] NOT NULL,
	[ProductID] [varchar](15) NOT NULL,
	[Quantity] [real] NULL,
	[Comment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ExportDetail] PRIMARY KEY CLUSTERED 
(
	[DeliveryID] ASC,
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
	[featureName] [nvarchar](150) NOT NULL,
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
CREATE TABLE [dbo].[Receipt](
	[ReceiptID] [int] IDENTITY(1,1) NOT NULL,
	[ReceiptDate] [date] NULL,
	[ReceiptTime] [time](0) NULL,
	[Importer] [varchar](50) NULL,
	[SupplierID] [int] NULL,
	[Shipper] [nvarchar](150) NULL,
	[Comment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Import] PRIMARY KEY CLUSTERED 
(
	[ReceiptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiptDetail](
	[ReceiptID] [int] NOT NULL,
	[ProductID] [varchar](15) NOT NULL,
	[unitPrice] [decimal](15, 5) NULL,
	[Quantity] [real] NULL,
	[inStock] [real] NULL,
	[ExpDate] [date] NULL,
	[MfgDate] [date] NULL,
	[Comment] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ImportDetail] PRIMARY KEY CLUSTERED 
(
	[ReceiptID] ASC,
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
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 101)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 102)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 103)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 104)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 111)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 112)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 113)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 114)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 121)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 122)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 123)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 124)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 201)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 202)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 203)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 211)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 212)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 213)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 300)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 301)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 302)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 303)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 304)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 305)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 401)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 402)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 403)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 404)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 405)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 406)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'admin', 407)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 101)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 111)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 121)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 201)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 202)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 211)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 212)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 300)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 301)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 302)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 303)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 304)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 305)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 405)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'quynm', 407)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'test', 405)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'test', 407)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'test1', 405)
INSERT [dbo].[Account_Feature] ([Username], [FeatureID]) VALUES (N'test1', 407)
GO
INSERT [dbo].[Accounts] ([Username], [Password], [FullName], [Dob], [Address], [Phone], [Email], [isActive]) VALUES (N'admin', N'admin', N'Administrator', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Accounts] ([Username], [Password], [FullName], [Dob], [Address], [Phone], [Email], [isActive]) VALUES (N'quynm', N'12345', N'Nguyễn Mạnh Quý', CAST(N'2001-04-06' AS Date), N'Đại học FPT Hà Nội', N'0987123456', N'quynmhe153283@fpt.edu.vn', 1)
INSERT [dbo].[Accounts] ([Username], [Password], [FullName], [Dob], [Address], [Phone], [Email], [isActive]) VALUES (N'test', N'123456', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Accounts] ([Username], [Password], [FullName], [Dob], [Address], [Phone], [Email], [isActive]) VALUES (N'test1', N'123456', NULL, NULL, NULL, NULL, NULL, 1)
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
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [isActive]) VALUES (19, N'test', N'test', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [isActive]) VALUES (27, N'test cái nữa', N'Data để test', 0)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Delivery] ON 

INSERT [dbo].[Delivery] ([DeliveryID], [DeliveryDate], [DeliveryTime], [Exporter], [Recipient], [Comment]) VALUES (1, CAST(N'2021-11-01' AS Date), CAST(N'23:00:00' AS Time), N'quynm', NULL, NULL)
INSERT [dbo].[Delivery] ([DeliveryID], [DeliveryDate], [DeliveryTime], [Exporter], [Recipient], [Comment]) VALUES (2, CAST(N'2021-11-01' AS Date), CAST(N'23:08:00' AS Time), N'quynm', NULL, NULL)
INSERT [dbo].[Delivery] ([DeliveryID], [DeliveryDate], [DeliveryTime], [Exporter], [Recipient], [Comment]) VALUES (3, CAST(N'2021-11-01' AS Date), CAST(N'23:00:00' AS Time), N'quynm', NULL, NULL)
INSERT [dbo].[Delivery] ([DeliveryID], [DeliveryDate], [DeliveryTime], [Exporter], [Recipient], [Comment]) VALUES (4, CAST(N'2021-11-01' AS Date), CAST(N'23:17:00' AS Time), N'quynm', NULL, NULL)
INSERT [dbo].[Delivery] ([DeliveryID], [DeliveryDate], [DeliveryTime], [Exporter], [Recipient], [Comment]) VALUES (11, CAST(N'2021-11-02' AS Date), CAST(N'08:20:00' AS Time), N'quynm', NULL, NULL)
INSERT [dbo].[Delivery] ([DeliveryID], [DeliveryDate], [DeliveryTime], [Exporter], [Recipient], [Comment]) VALUES (13, CAST(N'2021-11-02' AS Date), CAST(N'08:27:00' AS Time), N'quynm', NULL, NULL)
INSERT [dbo].[Delivery] ([DeliveryID], [DeliveryDate], [DeliveryTime], [Exporter], [Recipient], [Comment]) VALUES (14, CAST(N'2021-11-02' AS Date), CAST(N'08:29:00' AS Time), N'quynm', NULL, NULL)
INSERT [dbo].[Delivery] ([DeliveryID], [DeliveryDate], [DeliveryTime], [Exporter], [Recipient], [Comment]) VALUES (15, CAST(N'2021-11-02' AS Date), CAST(N'09:02:00' AS Time), N'admin', NULL, NULL)
INSERT [dbo].[Delivery] ([DeliveryID], [DeliveryDate], [DeliveryTime], [Exporter], [Recipient], [Comment]) VALUES (16, CAST(N'2021-11-02' AS Date), CAST(N'09:31:00' AS Time), N'admin', NULL, NULL)
INSERT [dbo].[Delivery] ([DeliveryID], [DeliveryDate], [DeliveryTime], [Exporter], [Recipient], [Comment]) VALUES (20, CAST(N'2021-11-05' AS Date), CAST(N'17:24:00' AS Time), N'admin', N'Nguyễn Văn A', NULL)
SET IDENTITY_INSERT [dbo].[Delivery] OFF
GO
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (1, N'Z1', 5, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (2, N'Z1', 3, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (3, N'Z1', 5, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (4, N'Z1', 3, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (4, N'Z2', 1, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (11, N'Z1', 5, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (11, N'Z2', 3, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (13, N'Z1', 2, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (14, N'Z1', 4, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (15, N'Z1', 3, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (16, N'Z2', 2, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (20, N'B0001', 2, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (20, N'B0004', 3.5, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (20, N'C0001', 472, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (20, N'C0002', 1, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (20, N'C0006', 58, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (20, N'C0008', 46, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (20, N'G0001', 10, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (20, N'G0010', 20, NULL)
INSERT [dbo].[DeliveryDetail] ([DeliveryID], [ProductID], [Quantity], [Comment]) VALUES (20, N'U0002', 48, NULL)
GO
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (101, N'/product/list', N'View inventory')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (102, N'/product/update', N'Edit & delete product')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (103, N'/product/inactive', N'Inactive product')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (104, N'/product/create', N'Create product')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (111, N'/category/list', N'View category')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (112, N'/category/update', N'Edit & delete category')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (113, N'/category/inactive', N'Inactive category')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (114, N'/category/create', N'Create category')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (121, N'/supplier/list', N'View Supplier')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (122, N'/supplier/update', N'Update & delete supplier')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (123, N'/supplier/inactive', N'Inactive supplier')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (124, N'/supplier/add', N'Add supplier')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (201, N'/delivery/create', N'Delivery')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (202, N'/delivery/detail', N'View Delivery Note')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (203, N'/delivery/delete', N'Delete deliery note')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (211, N'/receipt/create', N'Receipt')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (212, N'/receipt/detail', N'View Receipt Note')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (213, N'/receipt/delete', N'Delete received note')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (300, N'/report', N'Create report')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (301, N'/report/receipt-list', N'View all received notes')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (302, N'/report/delivery-list', N'View all delivery notes')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (303, N'/report/inout', N'View input - output - inventory report')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (304, N'/report/expiration', N'View expiration report')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (305, N'/report/outstock', N'View out stock report')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (401, N'/account/list', N'List Accounts')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (402, N'/account/detail', N'View All Account Detail')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (403, N'/account/update', N'Edit & Delete All Accounts')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (404, N'/account/create', N'Create Account')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (405, N'/my-account', N'View and Update Account Detail')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (406, N'/account/reset-pass', N'Reset Password')
INSERT [dbo].[Feature] ([featureID], [url], [featureName]) VALUES (407, N'/change-password', N'Change Password')
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0001', N'Trà đào Cozy', 11, 1, N'hộp', 9, CAST(48000.00000 AS Decimal(15, 5)), 1, N'hộp 20 túi lọc')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0002', N'Hồng trà', 11, 1, N'túi', 3, CAST(57000.00000 AS Decimal(15, 5)), 1, N'500g')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0003', N'Trà nhài', 11, 1, N'túi', 2, CAST(61000.00000 AS Decimal(15, 5)), 1, N'500g')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0004', N'Trân châu đen Wing', 11, 1, N'túi', 6, CAST(105000.00000 AS Decimal(15, 5)), 1, N'3kg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0005', N'Trân châu trắng 3Q', 11, 1, N'túi', 15, CAST(92000.00000 AS Decimal(15, 5)), 1, N'2kg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0006', N'Bột cacao', 11, 2, N'túi', 4, CAST(50000.00000 AS Decimal(15, 5)), 1, N'1kg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0007', N'Đào ngâm', 11, 9, N'lon', 5, CAST(52000.00000 AS Decimal(15, 5)), 1, N'1kg - 16 miếng')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0008', N'Sữa đặc NSPN', 11, 9, N'hộp', 48, CAST(49500.00000 AS Decimal(15, 5)), 1, N'1kg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0009', N'Bột coffee', 11, 2, N'túi', 4, CAST(96000.00000 AS Decimal(15, 5)), 1, N'1kg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'B0010', N'Siro dâu', 11, 2, N'chai', 3, CAST(32500.00000 AS Decimal(15, 5)), 1, N'560ml')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0001', N'Trứng gà', 12, 6, N'quả', 2028, CAST(1800.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0002', N'Dầu ăn', 12, 9, N'lít', 9, CAST(15000.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0003', N'Giò lụa', 12, 7, N'kg', 2, CAST(62000.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0004', N'Chả cá', 12, 7, N'kg', 81, CAST(59200.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0005', N'Gà góc tư', 12, 7, N'kg', 107, CAST(42300.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0006', N'Nạc vai', 12, 7, N'kg', 135, CAST(57000.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0007', N'Cánh gà', 12, 7, N'kg', 45, CAST(35000.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0008', N'Ba chỉ', 12, 7, N'kg', 50, CAST(61500.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0009', N'Tỏi gà', 12, 7, N'kg', 30, CAST(40000.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'C0010', N'Xúc xích', 12, 8, N'kg', 23, CAST(45000.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0001', N'Dấm trắng', 10, 9, N'chai', 74, CAST(3200.00000 AS Decimal(15, 5)), 1, N'chai 500ml')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0002', N'Dầu ăn', 10, 9, N'can', 9, CAST(130000.00000 AS Decimal(15, 5)), 1, N'can 19.8L')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0003', N'Đường trắng', 10, 9, N'kg', 4, CAST(17000.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0004', N'Đường vàng', 10, 9, N'kg', 11, CAST(16000.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0005', N'Mì chính Vedan', 10, 9, N'kg', 5, CAST(25000.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0006', N'Lạp xưởng', 10, 9, N'gói', 0, CAST(53000.00000 AS Decimal(15, 5)), 1, N'gói 500g')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0007', N'Mắm 168', 10, 10, N'chai', 16, CAST(49800.00000 AS Decimal(15, 5)), 1, N'chai 860ml')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0008', N'Mắm STK', 10, 7, N'can', 15, CAST(107000.00000 AS Decimal(15, 5)), 1, N'can 4.8L')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0009', N'Sate Tôm', 10, 7, N'lọ', 60, CAST(17500.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'G0010', N'Bột canh', 10, 7, N'gói', 285, CAST(3000.00000 AS Decimal(15, 5)), 1, N'gói 190g')
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0001', N'7-up', 15, 9, N'chai', 72, CAST(6500.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0002', N'Aquafina
', 15, 9, N'chai', 152, CAST(3300.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0003', N'Good mood
', 15, 9, N'chai', 0, CAST(5900.00000 AS Decimal(15, 5)), 0, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0004', N'Lipton
', 15, 9, N'chai', 96, CAST(5900.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0005', N'Mountain Dew
', 15, 9, N'chai', 30, CAST(5600.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0006', N'Pepsi thường
', 15, 9, N'chai', 72, CAST(6900.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0007', N'Pepsi chanh
', 15, 8, N'lon', 96, CAST(6600.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0008', N'Sting vàng', 15, 8, N'chai', 72, CAST(3400.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0009', N'Sting đỏ', 15, 8, N'chai', 144, CAST(3500.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'U0010', N'Olong tea', 15, 8, N'chai', 0, CAST(7200.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'Z1', N'test', 27, 1, NULL, 27, CAST(1.00000 AS Decimal(15, 5)), 1, NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SupplierID], [unit], [Quantity], [unitPrice], [isActive], [Comment]) VALUES (N'Z2', N'Test2', 10, 1, NULL, 39, CAST(3.00000 AS Decimal(15, 5)), 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Receipt] ON 

INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (1, CAST(N'2021-09-01' AS Date), CAST(N'00:00:00' AS Time), N'quynm', 1, N'Nguyễn Văn Quang', NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (2, CAST(N'2021-10-15' AS Date), CAST(N'00:00:00' AS Time), N'quynm', 1, N'Nguyễn Văn Quang', NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (3, CAST(N'2021-10-20' AS Date), CAST(N'00:00:00' AS Time), N'quynm', 2, N'Lê Thị Ngọc', NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (4, CAST(N'2021-10-20' AS Date), CAST(N'00:00:00' AS Time), N'quynm', 6, N'Hoàng Thu Thủy', NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (5, CAST(N'2021-10-10' AS Date), CAST(N'00:00:00' AS Time), N'quynm', 7, N'Ngọc Hương', NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (6, CAST(N'2021-09-12' AS Date), CAST(N'00:00:00' AS Time), N'quynm', 8, N'Hà Hoàng', NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (7, CAST(N'2021-09-18' AS Date), CAST(N'00:00:00' AS Time), N'quynm', 9, N'Nguyễn Văn Quang', NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (8, CAST(N'2021-09-30' AS Date), CAST(N'00:00:00' AS Time), N'quynm', 10, N'Ngọc Hòa', NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (31, CAST(N'2021-11-01' AS Date), CAST(N'16:39:00' AS Time), N'quynm', 1, NULL, NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (32, CAST(N'2021-11-01' AS Date), CAST(N'16:50:00' AS Time), N'quynm', 1, NULL, NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (33, CAST(N'2021-11-01' AS Date), CAST(N'16:50:00' AS Time), N'quynm', 1, NULL, NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (34, CAST(N'2021-11-01' AS Date), CAST(N'16:51:00' AS Time), N'quynm', 1, NULL, NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (35, CAST(N'2021-11-01' AS Date), CAST(N'16:52:00' AS Time), N'quynm', 1, NULL, NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (36, CAST(N'2021-11-01' AS Date), CAST(N'16:53:00' AS Time), N'quynm', 1, NULL, NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (37, CAST(N'2021-11-02' AS Date), CAST(N'08:26:00' AS Time), N'quynm', 1, NULL, NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (38, CAST(N'2021-11-02' AS Date), CAST(N'08:26:00' AS Time), N'quynm', 1, NULL, NULL)
INSERT [dbo].[Receipt] ([ReceiptID], [ReceiptDate], [ReceiptTime], [Importer], [SupplierID], [Shipper], [Comment]) VALUES (39, CAST(N'2021-11-02' AS Date), CAST(N'08:26:00' AS Time), N'quynm', 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Receipt] OFF
GO
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (1, N'B0001', CAST(45000.00000 AS Decimal(15, 5)), 11, 9, CAST(N'2021-11-15' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (1, N'B0002', CAST(57000.00000 AS Decimal(15, 5)), 3, 3, CAST(N'2021-11-19' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (1, N'B0003', CAST(61000.00000 AS Decimal(15, 5)), 2, 2, CAST(N'2022-09-30' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (1, N'B0004', CAST(105000.00000 AS Decimal(15, 5)), 6, 2.5, CAST(N'2021-10-09' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (1, N'B0005', CAST(92000.00000 AS Decimal(15, 5)), 5, 5, CAST(N'2021-12-25' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (2, N'B0004', CAST(105000.00000 AS Decimal(15, 5)), 3.5, 3.5, CAST(N'2021-12-31' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (2, N'B0005', CAST(92000.00000 AS Decimal(15, 5)), 10, 10, CAST(N'2021-10-31' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (3, N'B0006', CAST(50000.00000 AS Decimal(15, 5)), 4, 4, CAST(N'2021-12-17' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (3, N'B0009', CAST(96000.00000 AS Decimal(15, 5)), 4, 4, CAST(N'2021-11-10' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (3, N'B0010', CAST(32500.00000 AS Decimal(15, 5)), 3, 3, CAST(N'2021-11-20' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (4, N'C0001', CAST(1800.00000 AS Decimal(15, 5)), 2500, 2028, CAST(N'2021-11-05' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (5, N'C0003', CAST(62000.00000 AS Decimal(15, 5)), 2, 2, CAST(N'2021-11-20' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (5, N'C0004', CAST(59200.00000 AS Decimal(15, 5)), 81, 81, CAST(N'2021-12-10' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (5, N'C0005', CAST(42300.00000 AS Decimal(15, 5)), 107, 107, CAST(N'2021-12-12' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (5, N'C0006', CAST(57000.00000 AS Decimal(15, 5)), 193, 135, CAST(N'2021-10-28' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (5, N'C0007', CAST(35000.00000 AS Decimal(15, 5)), 45, 45, CAST(N'2021-11-09' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (5, N'C0008', CAST(61500.00000 AS Decimal(15, 5)), 96, 50, CAST(N'2021-11-07' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (5, N'C0009', CAST(40000.00000 AS Decimal(15, 5)), 30, 30, CAST(N'2021-12-20' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (5, N'G0008', CAST(107000.00000 AS Decimal(15, 5)), 15, 15, CAST(N'2021-12-15' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (5, N'G0009', CAST(17500.00000 AS Decimal(15, 5)), 60, 60, CAST(N'2021-11-30' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (5, N'G0010', CAST(3000.00000 AS Decimal(15, 5)), 305, 285, CAST(N'2021-12-01' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (6, N'C0010', CAST(45000.00000 AS Decimal(15, 5)), 23, 23, CAST(N'2021-11-15' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (6, N'U0007', CAST(6600.00000 AS Decimal(15, 5)), 96, 96, CAST(N'2022-01-15' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (6, N'U0008', CAST(3400.00000 AS Decimal(15, 5)), 72, 72, CAST(N'2022-01-15' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (6, N'U0009', CAST(3500.00000 AS Decimal(15, 5)), 144, 144, CAST(N'2022-01-15' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'B0007', CAST(52000.00000 AS Decimal(15, 5)), 5, 5, CAST(N'2021-12-01' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'B0008', CAST(49500.00000 AS Decimal(15, 5)), 48, 48, CAST(N'2021-12-01' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'C0002', CAST(15000.00000 AS Decimal(15, 5)), 10, 9, CAST(N'2021-11-05' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'G0001', CAST(3200.00000 AS Decimal(15, 5)), 84, 74, CAST(N'2021-11-16' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'G0002', CAST(130000.00000 AS Decimal(15, 5)), 9, 9, CAST(N'2021-11-19' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'G0003', CAST(17000.00000 AS Decimal(15, 5)), 4, 4, CAST(N'2021-11-25' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'G0004', CAST(16000.00000 AS Decimal(15, 5)), 11, 11, CAST(N'2021-11-17' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'G0005', CAST(25000.00000 AS Decimal(15, 5)), 5, 5, CAST(N'2021-12-05' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'U0001', CAST(6500.00000 AS Decimal(15, 5)), 72, 72, CAST(N'2021-12-16' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'U0002', CAST(3300.00000 AS Decimal(15, 5)), 200, 152, CAST(N'2022-05-20' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'U0004', CAST(5900.00000 AS Decimal(15, 5)), 96, 96, CAST(N'2022-08-20' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'U0005', CAST(5600.00000 AS Decimal(15, 5)), 24, 24, CAST(N'2022-01-19' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (7, N'U0006', CAST(6900.00000 AS Decimal(15, 5)), 72, 72, CAST(N'2022-06-15' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (8, N'G0007', CAST(49800.00000 AS Decimal(15, 5)), 16, 16, CAST(N'2021-12-31' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (31, N'U0005', CAST(2.00000 AS Decimal(15, 5)), 6, 6, CAST(N'2022-10-01' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (32, N'Z1', CAST(1.00000 AS Decimal(15, 5)), 1, 0, CAST(N'2021-12-06' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (33, N'Z1', CAST(1.00000 AS Decimal(15, 5)), 1, 0, CAST(N'2021-12-06' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (34, N'Z1', CAST(1.00000 AS Decimal(15, 5)), 1, 0, CAST(N'2021-12-30' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (34, N'Z2', CAST(3.00000 AS Decimal(15, 5)), 3, 0, CAST(N'2021-12-30' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (35, N'Z1', CAST(1.00000 AS Decimal(15, 5)), 6, 0, CAST(N'2021-12-30' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (35, N'Z2', CAST(3.00000 AS Decimal(15, 5)), 5, 0, NULL, NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (36, N'Z1', CAST(1.00000 AS Decimal(15, 5)), 2, 0, NULL, NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (37, N'Z1', CAST(1.00000 AS Decimal(15, 5)), 20, 20, CAST(N'2021-10-05' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (37, N'Z2', CAST(3.00000 AS Decimal(15, 5)), 5, 5, CAST(N'2021-11-05' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (38, N'Z1', CAST(1.00000 AS Decimal(15, 5)), 5, 0, CAST(N'2021-11-09' AS Date), NULL, NULL)
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (38, N'Z2', CAST(3.00000 AS Decimal(15, 5)), 23, 22, CAST(N'2021-11-02' AS Date), NULL, N'-')
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (39, N'Z1', CAST(1.00000 AS Decimal(15, 5)), 10, 7, NULL, NULL, N'-')
INSERT [dbo].[ReceiptDetail] ([ReceiptID], [ProductID], [unitPrice], [Quantity], [inStock], [ExpDate], [MfgDate], [Comment]) VALUES (39, N'Z2', CAST(3.00000 AS Decimal(15, 5)), 12, 12, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (1, N'Công ty TNHH MTV Hùng Đạt', N'Mr. Nguyễn Văn Đạt', N'0912345678', NULL, N'Thôn 3, Thạch Hòa', N'Hà Nội', N'Thạch Thất', 1, NULL)
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (2, N'Công ty Cổ phần Thống Nhất', N'Ms. Lê Thị Ngọc', NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (3, N'Công ty cổ phần XNK Trọng Hùng', N'Mr Đào Trọng Hùng', NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (4, N'Cửa hàng tạp hóa Hùng Lan', N'Ms. Nguyễn Thu Lan', NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (5, N'Công ty TNHH XNK Hoàng Hải Phong', N'Mr. Hoàng Hải Phong', NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (6, N'Hợp Tác Xã Bình Tiến', N'Ms. Hoàng Thu Thủy', NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (7, N'Hộ kinh doanh Ngọc Hương', N'Ms. Lê Thị Ngọc Hương', NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (8, N'Hộ kinh doanh Hà Hoàng', N'Ms. Hà Hoàng', NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (9, N'Siêu thị BigC Thăng Long', N'Mr. Đại diện', NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (10, N'Siêu thị VinMart Lục quân', N'Mr. Vinmart', NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [Phone], [Email], [Address], [Province], [District], [isActive], [Comment]) VALUES (11, N'test', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL)
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
ALTER TABLE [dbo].[Delivery]  WITH CHECK ADD  CONSTRAINT [FK_Export_Accounts] FOREIGN KEY([Exporter])
REFERENCES [dbo].[Accounts] ([Username])
GO
ALTER TABLE [dbo].[Delivery] CHECK CONSTRAINT [FK_Export_Accounts]
GO
ALTER TABLE [dbo].[DeliveryDetail]  WITH CHECK ADD  CONSTRAINT [FK_ExportDetail_Export] FOREIGN KEY([DeliveryID])
REFERENCES [dbo].[Delivery] ([DeliveryID])
GO
ALTER TABLE [dbo].[DeliveryDetail] CHECK CONSTRAINT [FK_ExportDetail_Export]
GO
ALTER TABLE [dbo].[DeliveryDetail]  WITH CHECK ADD  CONSTRAINT [FK_ExportDetail_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[DeliveryDetail] CHECK CONSTRAINT [FK_ExportDetail_Products]
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
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Import_Accounts] FOREIGN KEY([Importer])
REFERENCES [dbo].[Accounts] ([Username])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Import_Accounts]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receipt_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receipt_Suppliers]
GO
ALTER TABLE [dbo].[ReceiptDetail]  WITH CHECK ADD  CONSTRAINT [FK_ImportDetail_Import] FOREIGN KEY([ReceiptID])
REFERENCES [dbo].[Receipt] ([ReceiptID])
GO
ALTER TABLE [dbo].[ReceiptDetail] CHECK CONSTRAINT [FK_ImportDetail_Import]
GO
ALTER TABLE [dbo].[ReceiptDetail]  WITH CHECK ADD  CONSTRAINT [FK_ImportDetail_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ReceiptDetail] CHECK CONSTRAINT [FK_ImportDetail_Products]
GO
USE [master]
GO
ALTER DATABASE [WarehouseDB] SET  READ_WRITE 
GO
