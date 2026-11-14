-- ============================================================
--  JEWELLERY DESIGN — Complete Database Setup Script
--  Run this in SQL Server Management Studio (SSMS)
--  OR execute against (localdb)\MSSQLLocalDB
-- ============================================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'JewelleryDB')
BEGIN
    CREATE DATABASE JewelleryDB;
END
GO

USE JewelleryDB;
GO

-- ── 1. Emp_tbl : Registered Members & Admin ───────────────────
IF OBJECT_ID('dbo.Emp_tbl', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Emp_tbl
    (
        Id       INT           IDENTITY(1,1) PRIMARY KEY,
        Name     NVARCHAR(100) NOT NULL,
        Gender   NVARCHAR(10)  NOT NULL,
        Email    NVARCHAR(150) NOT NULL,
        City     NVARCHAR(80)  NOT NULL,
        Address  NVARCHAR(300) NOT NULL,
        Mobile   NVARCHAR(15)  NOT NULL,
        Image    NVARCHAR(300) NULL,
        Role     NVARCHAR(20)  NOT NULL CONSTRAINT DF_Emp_tbl_Role DEFAULT 'User',
        [Password] NVARCHAR(100) NULL,
        RegDate  DATETIME      NOT NULL DEFAULT GETDATE()
    );
END
GO

-- ── 2. Add_Company_Tbl : Jewellery Brands / Companies ─────────
IF OBJECT_ID('dbo.Add_Company_Tbl', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Add_Company_Tbl
    (
        Comp_id         INT           IDENTITY(1,1) PRIMARY KEY,
        Comp_Name       NVARCHAR(100) NOT NULL,
        Comp_Owner_Name NVARCHAR(100) NULL,
        Comp_Email      NVARCHAR(150) NULL,
        Comp_Address    NVARCHAR(300) NULL,
        Comp_Cover_Img  NVARCHAR(300) NULL
    );
END
GO

-- ── 3. Add_Products_Tbl : Jewellery Products ─────────────────
IF OBJECT_ID('dbo.Add_Products_Tbl', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Add_Products_Tbl
    (
        Prod_Id         INT            IDENTITY(1,1) PRIMARY KEY,
        Prod_Comp_Id    INT            NOT NULL REFERENCES dbo.Add_Company_Tbl(Comp_id) ON DELETE CASCADE,
        Prod_Name       NVARCHAR(150)  NOT NULL,
        Prod_Model      NVARCHAR(100)  NULL,
        Prod_Desc       NVARCHAR(500)  NULL,
        Prod_Weight     NVARCHAR(50)   NULL,
        Prod_Config     NVARCHAR(100)  NULL,
        Prod_Img        NVARCHAR(300)  NULL,
        Prod_Price      DECIMAL(12,2)  NOT NULL DEFAULT 0,
        Prod_Category   NVARCHAR(50)   NULL,
        Prod_Collection NVARCHAR(50)   NULL
    );
END
GO

-- ── 4. Cart_Tbl : User Shopping Cart ──────────────────────────
IF OBJECT_ID('dbo.Cart_Tbl', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Cart_Tbl
    (
        Cart_Id  INT      IDENTITY(1,1) PRIMARY KEY,
        User_Id  INT      NOT NULL REFERENCES dbo.Emp_tbl(Id) ON DELETE CASCADE,
        Prod_Id  INT      NOT NULL REFERENCES dbo.Add_Products_Tbl(Prod_Id) ON DELETE CASCADE,
        Qty      INT      NOT NULL DEFAULT 1,
        Added_On DATETIME NOT NULL DEFAULT GETDATE(),
        CONSTRAINT UQ_Cart_User_Prod UNIQUE (User_Id, Prod_Id)
    );
END
GO

-- ── 5. Orders_Tbl : Customer Orders ───────────────────────────
IF OBJECT_ID('dbo.Orders_Tbl', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Orders_Tbl
    (
        Order_Id     INT           IDENTITY(1,1) PRIMARY KEY,
        User_Id      INT           NOT NULL REFERENCES dbo.Emp_tbl(Id) ON DELETE CASCADE,
        Ship_Name    NVARCHAR(100) NOT NULL,
        Ship_Mobile  NVARCHAR(15)  NOT NULL,
        Ship_Address NVARCHAR(300) NOT NULL,
        Ship_City    NVARCHAR(80)  NOT NULL,
        Payment      NVARCHAR(40)  NOT NULL,
        Total        DECIMAL(14,2) NOT NULL,
        Status       NVARCHAR(20)  NOT NULL DEFAULT 'Pending',
        Order_Date   DATETIME      NOT NULL DEFAULT GETDATE()
    );
END
GO

-- ── 6. Order_Items_Tbl : Items within Orders ──────────────────
IF OBJECT_ID('dbo.Order_Items_Tbl', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Order_Items_Tbl
    (
        Item_Id   INT           IDENTITY(1,1) PRIMARY KEY,
        Order_Id  INT           NOT NULL REFERENCES dbo.Orders_Tbl(Order_Id) ON DELETE CASCADE,
        Prod_Name NVARCHAR(150) NOT NULL,
        Prod_Img  NVARCHAR(300) NULL,
        Price     DECIMAL(12,2) NOT NULL,
        Qty       INT           NOT NULL
    );
END
GO

-- ── 7. Seed Admin Account ─────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Emp_tbl WHERE Role='Admin' OR Email='admin@gmail.com')
BEGIN
    INSERT INTO dbo.Emp_tbl (Name, Gender, Email, City, Address, Mobile, Image, Role, [Password])
    VALUES ('admin', 'Male', 'admin@gmail.com', 'Rajkot', 'Admin Office', '9999999999', NULL, 'Admin', 'admin123');
END
ELSE
BEGIN
    UPDATE dbo.Emp_tbl SET [Password]='admin123', Role='Admin' WHERE Email='admin@gmail.com';
END
GO

-- ── 8. Seed Demo Company & Products (if empty) ────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Add_Company_Tbl)
BEGIN
    INSERT INTO dbo.Add_Company_Tbl (Comp_Name, Comp_Owner_Name, Comp_Email, Comp_Address, Comp_Cover_Img)
    VALUES ('Tanishq Jewellers', 'Titan Company Ltd', 'support@tanishq.co.in', 'Bangalore, India', 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?q=80&w=800');

    DECLARE @CompId INT = SCOPE_IDENTITY();

    INSERT INTO dbo.Add_Products_Tbl (Prod_Comp_Id, Prod_Name, Prod_Model, Prod_Desc, Prod_Weight, Prod_Config, Prod_Img, Prod_Price, Prod_Category, Prod_Collection)
    VALUES
    (@CompId, 'Royal Aurelia Diamond Ring', 'RNG-001', 'Solitaire diamond set in 18K yellow gold band with exquisite prong setting.', '4.8 g', '18K Yellow Gold / VVS1 Diamond', 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=800', 84999.00, 'Rings', 'Diamond'),
    (@CompId, 'Heritage Temple Gold Necklace', 'NCK-102', 'Traditional 22K gold necklace featuring intricate filigree handcrafted by master artisans.', '32.5 g', '22K Hallmarked Gold', 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?q=80&w=800', 245000.00, 'Necklaces', 'Gold'),
    (@CompId, 'Celestial Bloom Drop Earrings', 'ERG-204', 'Dazzling floral diamond drop earrings designed for gala evenings and weddings.', '8.2 g', '14K Rose Gold / Round Brilliant Diamonds', 'https://images.unsplash.com/photo-1630019852942-f89202989a59?q=80&w=800', 67500.00, 'Earrings', 'Diamond'),
    (@CompId, 'Regal Kundan Bridal Choker', 'NCK-305', 'Exquisite bridal choker set with uncut polki diamonds, cultured pearls and ruby beads.', '54.0 g', '22K Gold Foil / Kundan & Pearls', 'https://i.pinimg.com/736x/59/a6/0d/59a60dc249619f48ee06100fe853bb68.jpg', 389000.00, 'Necklaces', 'Bridal');
END
GO
