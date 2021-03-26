USE [master]
GO
/****** Object:  Database [E-COMMERCE] ******/
CREATE DATABASE [E-COMMERCE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'E-commerce', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\E-COMMERCE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'E-commerce_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\E-COMMERCE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [E-COMMERCE] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [E-COMMERCE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [E-COMMERCE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [E-COMMERCE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [E-COMMERCE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [E-COMMERCE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [E-COMMERCE] SET ARITHABORT OFF 
GO
ALTER DATABASE [E-COMMERCE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [E-COMMERCE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [E-COMMERCE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [E-COMMERCE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [E-COMMERCE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [E-COMMERCE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [E-COMMERCE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [E-COMMERCE] SET QUOTED_IdENTIFIER OFF 
GO
ALTER DATABASE [E-COMMERCE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [E-COMMERCE] SET DISABLE_BROKER 
GO
ALTER DATABASE [E-COMMERCE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [E-COMMERCE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [E-COMMERCE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [E-COMMERCE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [E-COMMERCE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [E-COMMERCE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [E-COMMERCE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [E-COMMERCE] SET RECOVERY FULL 
GO
ALTER DATABASE [E-COMMERCE] SET  MULTI_USER 
GO
ALTER DATABASE [E-COMMERCE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [E-COMMERCE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [E-COMMERCE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [E-COMMERCE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [E-COMMERCE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [E-COMMERCE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'E-COMMERCE', N'ON'
GO
ALTER DATABASE [E-COMMERCE] SET QUERY_STORE = OFF
GO
USE [E-COMMERCE]
GO
/****** Object:  UserDefinedFunction [dbo].[FilterItem_NumCost] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
CREATE FUNCTION  [dbo].[FilterItem_NumCost]
(
    @min int,
	@max int
)
RETURNS INT
AS
BEGIN
 return (select count(*) from product where Price between @min and @max)
END
GO
/****** Object:  Table [dbo].[CartFun]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
CREATE TABLE [dbo].[CartFun](
	[Id] [int] NOT NULL,
	[Cart_No] [int] NOT NULL,
	[Customer_Id] [int] NOT NULL,
	[Product_Name] [varchar](20) NULL,
	[Product_Id] [varchar](20) NULL,
	[Sku] [varchar](20) NULL,
	[Price] [smallmoney] NULL,
	[Quantity] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryFun] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryFun](
	[Catergory_Id] [int] NOT NULL,
	[category_name] [varchar](20) NULL,
	[description] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Catergory_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerFun] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerFun](
	[Customer_Id] [int] IdENTITY(1,1) NOT NULL,
	[Email] [varchar](40) NOT NULL,
	[Name] [varchar](40) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[Billing_Address] [varchar](40) NOT NULL,
	[Default_address] [varchar](40) NULL,
	[Country] [varchar](20) NOT NULL,
	[password_user] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Customer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderConfirmation] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
CREATE TABLE [dbo].[OrderConfirmation](
	[Order_Id] [int] NOT NULL,
	[Customer_Id] [int] NOT NULL,
	[Product_Id] [int] NOT NULL,
	[Order_Date_Time] [datetime] NOT NULL,
	[Ship_Date] [date] NOT NULL,
	[Ship_Address] [varchar](20) NOT NULL,
	[Billing_Address] [varchar](20) NOT NULL,
	[Total_Bill] [smallmoney] NULL,
	[Transaction_Number] [int] NULL,
	[Payment_Mode] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[Order_Id] [int] IdENTITY(100000,1) NOT NULL,
	[order_number] [int] NOT NULL,
	[Customer_Id] [int] NOT NULL,
	[Product_Id] [int] NOT NULL,
	[Price] [smallmoney] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Sku] [varchar](20) NOT NULL,
	[Cart_Id] [int] NOT NULL,
	[Total] [smallmoney] NULL,
PRIMARY KEY CLUSTERED 
(
	[Order_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductFun] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
CREATE TABLE [dbo].[ProductFun](
	[Product_Id] [int] NOT NULL,
	[Sku] [varchar](20) NOT NULL,
	[Product_Name] [varchar](20) NOT NULL,
	[Price] [smallmoney] NULL,
	[Description] [varchar](20) NULL,
	[Image] [varchar](20) NULL,
	[Stock] [int] NOT NULL,
	[Catergory_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CartFun]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Id] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[CustomerFun] ([Customer_Id])
GO
ALTER TABLE [dbo].[CartFun] CHECK CONSTRAINT [FK_Customer_Id]
GO
ALTER TABLE [dbo].[OrderConfirmation]  WITH CHECK ADD  CONSTRAINT [Fk_Customer_Id_Oc] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[CustomerFun] ([Customer_Id])
GO
ALTER TABLE [dbo].[OrderConfirmation] CHECK CONSTRAINT [Fk_Customer_Id_Oc]
GO
ALTER TABLE [dbo].[OrderConfirmation]  WITH CHECK ADD  CONSTRAINT [Fk_Order_Id_Od] FOREIGN KEY([Order_Id])
REFERENCES [dbo].[OrderDetail] ([Order_Id])
GO
ALTER TABLE [dbo].[OrderConfirmation] CHECK CONSTRAINT [Fk_Order_Id_Od]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [Fk_Cart_No_Od] FOREIGN KEY([Cart_Id])
REFERENCES [dbo].[CartFun] ([Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [Fk_Cart_No_Od]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [Fk_Customer_Id_Od] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[CustomerFun] ([Customer_Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [Fk_Customer_Id_Od]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [Fk_Product_Id_Od] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[ProductFun] ([Product_Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [Fk_Product_Id_Od]
GO
ALTER TABLE [dbo].[ProductFun]  WITH CHECK ADD  CONSTRAINT [Fk_Catergory_Id] FOREIGN KEY([Catergory_Id])
REFERENCES [dbo].[CategoryFun] ([Catergory_Id])
GO
ALTER TABLE [dbo].[ProductFun] CHECK CONSTRAINT [Fk_Catergory_Id]
GO
/****** Object:  StoredProcedure [dbo].[DeleteCartItem] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
create procedure [dbo].[DeleteCartItem](@user_Id int, @Product_Id int) as
begin
  delete  from cart where (Product_Id=@Product_Id and Customer_Id= @user_Id);
end
GO
/****** Object:  StoredProcedure [dbo].[DiscountItemFun] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
create proc [dbo].[DiscountItemFun] (@Product_Id int , @discount int) as
begin 
if exists (select * from cart where Product_Id = @Product_Id )
begin 
 Update cart
 Set Price = Price - Price * @discount /100 
 where Product_Id = @Product_Id
 end 
 else 
 begin 
  select * from Cart
  end
end
GO
/****** Object:  StoredProcedure [dbo].[FilterItemCost] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO

create procedure [dbo].[FilterItemCost](@min int, @max int) as
begin
	 select product_name, Price,Description_p,[Image] from product where Price between @min and @max;
end
GO
/****** Object:  StoredProcedure [dbo].[FindCustomer] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
create proc [dbo].[FindCustomer](@Customer_Id int) as
begin
   select * from customer where Customer_Id=@Customer_Id;
end
GO
/****** Object:  StoredProcedure [dbo].[FindOrderFun] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
create proc [dbo].[FindOrderFun] (@Order_Id int) as
begin
if exists (select * from Order_Confirmation where Order_Id = @Order_Id )
begin
	 select * from Order_Confirmation where Order_Id = @Order_Id
end
else
	begin
		print('No order');
	end
end
GO
/****** Object:  StoredProcedure [dbo].[ShowItemFun] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
create proc [dbo].[ShowItemFun] (@Id int ) as
begin 
	select * from cart where Product_Id = @Id
end 
GO
/****** Object:  StoredProcedure [dbo].[ViewCartItems] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IdENTIFIER ON
GO
create procedure [dbo].[ViewCartItems](@user_Id int) as  
begin 
	select cart.Product_Name, cart.Product_Id, cart.Price,cart.Quantity 
	from cart join
	product on cart.Product_Id=Product.Product_Id
	where  cart.Customer_Id=@User_Id
end 
GO
USE [master]
GO
ALTER DATABASE [E-COMMERCE] SET  READ_WRITE 
GO

USE [master] 
GO  
SELECT *  
FROM sys.databases  
GO