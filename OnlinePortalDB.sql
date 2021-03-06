USE [master]
GO
/****** Object:  Database [OnlinePortal]    Script Date: 01-03-2020 10:42:41 ******/
CREATE DATABASE [OnlinePortal]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlinePortal', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\OnlinePortal.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlinePortal_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\OnlinePortal_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [OnlinePortal] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlinePortal].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlinePortal] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlinePortal] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlinePortal] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlinePortal] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlinePortal] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlinePortal] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlinePortal] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlinePortal] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlinePortal] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlinePortal] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlinePortal] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlinePortal] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlinePortal] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlinePortal] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlinePortal] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OnlinePortal] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlinePortal] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlinePortal] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlinePortal] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlinePortal] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlinePortal] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlinePortal] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlinePortal] SET RECOVERY FULL 
GO
ALTER DATABASE [OnlinePortal] SET  MULTI_USER 
GO
ALTER DATABASE [OnlinePortal] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlinePortal] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlinePortal] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlinePortal] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OnlinePortal] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'OnlinePortal', N'ON'
GO
ALTER DATABASE [OnlinePortal] SET QUERY_STORE = OFF
GO
USE [OnlinePortal]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 01-03-2020 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Description] [nvarchar](200) NULL,
	[PriceRange] [nvarchar](200) NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblCategory] UNIQUE NONCLUSTERED 
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 01-03-2020 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProduct](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](500) NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 4) NULL,
	[Discount] [decimal](18, 4) NULL,
	[ExpirationDate] [datetime] NULL,
 CONSTRAINT [PK_tblProduct] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblCategory] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[tblCategory] ([CategoryId])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblCategory]
GO
/****** Object:  StoredProcedure [dbo].[usp_getCategoryList]    Script Date: 01-03-2020 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasjeet Singh
-- Create date: 29 Feb 2020
-- Description:	To Get All category List
-- =============================================
CREATE PROCEDURE [dbo].[usp_getCategoryList] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  CategoryId,[Name], [Description], [PriceRange], [DisplayOrder] FROM tblCategory

END
GO
/****** Object:  StoredProcedure [dbo].[usp_getList]    Script Date: 01-03-2020 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasjeet Singh
-- Create date: 1 march 2020
-- Description:	To Insert Update Product Details
-- =============================================
CREATE PROCEDURE [dbo].[usp_getList]
AS
BEGIN

	SET NOCOUNT ON;

	select tblCategory.Name as CategoryName,tblProduct.Name as ProductName,tblCategory.Description as CategoryDescription
	,  tblProduct.Description as ProductDescription ,tblProduct.Quantity   as  ProductQuantity  from tblProduct 
	inner join tblCategory on tblProduct.CategoryId=tblCategory.CategoryId


END
GO
/****** Object:  StoredProcedure [dbo].[usp_getProductList]    Script Date: 01-03-2020 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasjeet Singh
-- Create date: 1 march 2020
-- Description:	To Get Product List
-- =============================================
CREATE PROCEDURE [dbo].[usp_getProductList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SELECT tblProduct.ProductId,tblProduct.[Name],tblProduct.CategoryId
		,tblProduct.[Description]
		,tblProduct.Discount
		,tblProduct.Price
		,tblProduct.ExpirationDate
		,tblProduct.Quantity
		,tblCategory.[Name] AS CategoryName
	FROM tblProduct
				JOIN tblCategory ON tblCategory.CategoryId= tblProduct.CategoryId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateCategory]    Script Date: 01-03-2020 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasjeet Singh
-- Create date: 29 Feb 2020
-- Description:	Inser/UPdate
-- =============================================
CREATE PROCEDURE [dbo].[usp_InsertUpdateCategory]
	-- Add the parameters for the stored procedure here
	(
	 @CategoryId INT
	,@Name Nvarchar(200)
	,@Description NVARCHAR(500)
	,@PriceRange NVARCHAR(100)
	,@DisplayOrder INT
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	IF(ISNULL(@CategoryId,0) > 0)
		BEGIN

			UPDATE tblCategory SET
				 [Name] = @Name
				,[Description] = @Description
				,PriceRange = @PriceRange
				,DisplayOrder = @DisplayOrder
			WHERE CategoryId = @CategoryId
				select 'Sucess'
		END
	ELSE
		BEGIN
			INSERT INTO tblCategory([Name], [Description], [PriceRange], [DisplayOrder]) VALUES (@Name,@Description,@PriceRange,@DisplayOrder)
			select 'Sucess'
		END
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateProduct]    Script Date: 01-03-2020 10:42:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jasjeet Singh
-- Create date: 1 march 2020
-- Description:	To Insert Update Product Details
-- =============================================
CREATE PROCEDURE [dbo].[usp_InsertUpdateProduct]
	-- Add the parameters for the stored procedure here
	(
	@ProductId INT
	,@CategoryId INT
	,@Name NVARCHAR(200)
	,@Description NVARCHAR(500)
	,@Quantity INT
	,@Price DECIMAL(18,4)
	,@Discount DECIMAL(18,4)
	,@ExpirationDate DATETIME

	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	IF(ISNULL(@ProductId,0)>0)
	BEGIN

		UPDATE tblProduct SET CategoryId = @CategoryId
				,[Name] = @Name
				,[Description] = @Description
				,Quantity = @Quantity
				,Price = @Price
				,Discount = @Discount 
				,ExpirationDate = @ExpirationDate
		WHERE ProductId = @ProductId
		select 'Sucess'

	END
ELSE
	BEGIN

		INSERT INTO tblProduct([CategoryId], [Name], [Description], [Quantity], [Price], [Discount], [ExpirationDate])
		VALUES (@CategoryId, @Name, @Description, @Quantity, @Price, @Discount, @ExpirationDate)
				select 'Sucess'

	END

END
GO
USE [master]
GO
ALTER DATABASE [OnlinePortal] SET  READ_WRITE 
GO
