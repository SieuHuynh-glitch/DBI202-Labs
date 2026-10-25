-- =====================================================================================
-- HỌ VÀ TÊN: Huỳnh Hoàng Siêu
-- MSSV: QE210005
-- LỚP: SE20D
-- MÔN HỌC: DBI202 - DATABASE SYSTEMS
-- BÀI TẬP: LAB 5 - FUNCTION, PROCEDURE, TRIGGER, VIEW (ABCCompany)
-- =====================================================================================

-- =====================================================================================
-- PHẦN 1: KHỞI TẠO CƠ SỞ DỮ LIỆU VÀ DỮ LIỆU MẪU (ABCCompany)
-- =====================================================================================
USE master;
GO

IF DB_ID('ABCCompany') IS NOT NULL
BEGIN
    ALTER DATABASE ABCCompany SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ABCCompany;
END;
GO

CREATE DATABASE ABCCompany;
GO

USE ABCCompany;
GO

CREATE TABLE KHACHHANG (
    MaKH nvarchar(5) NOT NULL PRIMARY KEY,
    TenKH nvarchar(30) NOT NULL,
    DiaChi nvarchar(50),
    DT nvarchar(10),
    Email nvarchar(30)
);
GO

CREATE TABLE VATTU (
    MaVT nvarchar(5) PRIMARY KEY NOT NULL,
    TenVT nvarchar(30) NOT NULL,
    DVT nvarchar(20),
    GiaMua int CHECK (GiaMua > 0),
    SLTon int CHECK (SLTon >= 0)
);
GO

CREATE TABLE HOADON (
    MaHD nvarchar(10) PRIMARY KEY NOT NULL,
    Ngay datetime CHECK (Ngay < GETDATE()),
    MaKH nvarchar(5) FOREIGN KEY REFERENCES KHACHHANG(MaKH),
    TongTG int
);
GO

CREATE TABLE CHITIETHOADON (
    MaHD nvarchar(10) FOREIGN KEY REFERENCES HOADON(MaHD),
    MaVT nvarchar(5) FOREIGN KEY REFERENCES VATTU(MaVT),
    PRIMARY KEY (MaHD, MaVT),
    SL int,
    KhuyenMai int,
    GiaBan int
);
GO

-- Nạp dữ liệu mẫu từ giáo trình FPT
INSERT VATTU VALUES ('VT01', 'XI MANG', 'BAO', 50000, 5000);
INSERT VATTU VALUES ('VT02', 'CAT', 'KHOI', 45000, 50000);
INSERT VATTU VALUES ('VT03', 'GACH ONG', 'VIEN', 120, 800000);
INSERT VATTU VALUES ('VT04', 'GACH THE', 'VIEN', 110, 800000);
INSERT VATTU VALUES ('VT05', 'DA LON', 'KHOI', 25000, 100000);
INSERT VATTU VALUES ('VT06', 'DA NHO', 'KHOI', 33000, 100000);
GO

INSERT KHACHHANG VALUES ('KH01', 'NGUYEN THI BE', 'TAN BINH', 8457895, 'bnt@yahoo.com');
INSERT KHACHHANG VALUES ('KH02', 'LE HOANG NAM', 'BINH CHANH', 9878987, 'namlehoang@abc.com.vn');
INSERT KHACHHANG VALUES ('KH03', 'TRAN THI CHIEU', 'TAN BINH', 8457895, NULL);
INSERT KHACHHANG VALUES ('KH04', 'MAI THI QUE ANH', 'BINH CHANH ', NULL, NULL);
INSERT KHACHHANG VALUES ('KH05', 'LE VAN SANG', 'QUAN 10', NULL, 'sanglv@hcm.vnn.vn');
INSERT KHACHHANG VALUES ('KH06', 'TRAN HOANG KHAI', 'TAN BINH', 8457897, NULL);
GO

INSERT HOADON(MaHD, Ngay, MaKH) VALUES ('HD001', '2000-05-12', 'KH01');
INSERT HOADON(MaHD, Ngay, MaKH) VALUES ('HD002', '2000-05-25', 'KH02');
INSERT HOADON(MaHD, Ngay, MaKH) VALUES ('HD003', '2000-05-25', 'KH01');
INSERT HOADON(MaHD, Ngay, MaKH) VALUES ('HD004', '2000-05-25', 'KH04');
INSERT HOADON(MaHD, Ngay, MaKH) VALUES ('HD005', '2000-05-26', 'KH04');
INSERT HOADON(MaHD, Ngay, MaKH) VALUES ('HD006', '2000-05-02', 'KH03');
INSERT HOADON(MaHD, Ngay, MaKH) VALUES ('HD007', '2000-06-22', 'KH04');
INSERT HOADON(MaHD, Ngay, MaKH) VALUES ('HD008', '2000-06-25', 'KH03');
INSERT HOADON(MaHD, Ngay, MaKH) VALUES ('HD009', '2000-08-15', 'KH04');
INSERT HOADON(MaHD, Ngay, MaKH) VALUES ('HD010', '2000-08-30', 'KH01');
GO

INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD001', 'VT01', 5, 52000);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD001', 'VT05', 10, 30000);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD002', 'VT03', 10000, 150);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD003', 'VT02', 20, 55000);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD004', 'VT03', 50000, 150);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD004', 'VT04', 20000, 120);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD005', 'VT05', 10, 30000);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD006', 'VT04', 10000, 120);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD007', 'VT04', 20000, 125);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD008', 'VT01', 100, 55000);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD009', 'VT02', 25, 48000);
INSERT CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD010', 'VT01', 25, 57000);
GO


-- =====================================================================================
-- PHẦN 2: CÁC YÊU CẦU LẬP TRÌNH CSDL CHO SINH VIÊN: QE210005
-- =====================================================================================

-- -------------------------------------------------------------------------------------
-- Task 1: Write function name: StudenID_Func1 with parameter @mavt, 
--         return the sum of sl*giaban corresponding.
-- -------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.QE210005_Func1', 'FN') IS NOT NULL
    DROP FUNCTION dbo.QE210005_Func1;
GO

CREATE FUNCTION QE210005_Func1 (@mavt nvarchar(5))
RETURNS BIGINT
AS
BEGIN
    DECLARE @totalRevenue BIGINT;
    
    SELECT @totalRevenue = ISNULL(SUM(CAST(SL AS BIGINT) * CAST(GiaBan AS BIGINT)), 0)
    FROM CHITIETHOADON
    WHERE MaVT = @mavt;
    
    RETURN @totalRevenue;
END;
GO

-- Kiểm tra Function 1:
-- SELECT 'VT01' AS [Mã VT], dbo.QE210005_Func1('VT01') AS [Tổng doanh thu];
-- SELECT MaVT AS [Mã VT], TenVT AS [Tên VT], dbo.QE210005_Func1(MaVT) AS [Tổng doanh thu] FROM VATTU;
GO


-- -------------------------------------------------------------------------------------
-- Task 2: Write function to return a total of the HoaDon (@MahD is a parameter).
--         Function name: QE210005_Func2 (và QE210005_FuncTotalHoaDon)
-- -------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.QE210005_Func2', 'FN') IS NOT NULL
    DROP FUNCTION dbo.QE210005_Func2;
GO

CREATE FUNCTION QE210005_Func2 (@MaHD nvarchar(10))
RETURNS BIGINT
AS
BEGIN
    DECLARE @totalAmount BIGINT;
    
    SELECT @totalAmount = ISNULL(SUM(CAST(SL AS BIGINT) * CAST(GiaBan AS BIGINT)), 0)
    FROM CHITIETHOADON
    WHERE MaHD = @MaHD;
    
    RETURN @totalAmount;
END;
GO

-- Kiểm tra Function 2:
-- SELECT 'HD001' AS [Mã HĐ], dbo.QE210005_Func2('HD001') AS [Tổng tiền hóa đơn];
-- SELECT MaHD AS [Mã HĐ], Ngay AS [Ngày lập], MaKH AS [Mã KH], dbo.QE210005_Func2(MaHD) AS [Tổng tiền] FROM HOADON;
GO


-- -------------------------------------------------------------------------------------
-- Task 3: Write procedure name: StudenId_Proc1, parameter @makh, @diachi. 
--         This procedure helps user update @diachi corresponding @makh.
-- -------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.QE210005_Proc1', 'P') IS NOT NULL
    DROP PROCEDURE dbo.QE210005_Proc1;
GO

CREATE PROCEDURE QE210005_Proc1
    @makh nvarchar(5),
    @diachi nvarchar(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF NOT EXISTS (SELECT 1 FROM KHACHHANG WHERE MaKH = @makh)
    BEGIN
        RAISERROR(N'Error: Mã khách hàng %s không tồn tại trong hệ thống!', 16, 1, @makh);
        RETURN -1;
    END;
    
    UPDATE KHACHHANG
    SET DiaChi = @diachi
    WHERE MaKH = @makh;
    
    PRINT N'Success: Đã cập nhật thành công địa chỉ cho khách hàng ' + @makh;
    RETURN 0;
END;
GO

-- Kiểm tra Procedure 1:
-- EXEC dbo.QE210005_Proc1 @makh = 'KH01', @diachi = N'123 Lê Lợi, Quận 1, TP. HCM';
-- SELECT * FROM KHACHHANG WHERE MaKH = 'KH01';
GO


-- -------------------------------------------------------------------------------------
-- Task 4: Write procedure to add an item into Hoadon.
--         Procedure name: QE210005_ProcAddItem (và alias QE210005_Proc_AddItem)
-- -------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.QE210005_ProcAddItem', 'P') IS NOT NULL
    DROP PROCEDURE dbo.QE210005_ProcAddItem;
GO

CREATE PROCEDURE QE210005_ProcAddItem
    @MaHD nvarchar(10),
    @MaVT nvarchar(5),
    @SL int,
    @KhuyenMai int = 0,
    @GiaBan int = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @CurrentStock int, @DefaultPrice int;

    -- 1. Validate dữ liệu đầu vào TRƯỚC TRANSACTION
    IF @SL IS NULL OR @SL <= 0
    BEGIN
        RAISERROR(N'Error: Số lượng phải lớn hơn 0!', 16, 1);
        RETURN -4;
    END;

    IF NOT EXISTS (SELECT 1 FROM HOADON WHERE MaHD = @MaHD)
    BEGIN
        RAISERROR(N'Error: Mã hóa đơn %s không tồn tại!', 16, 1, @MaHD);
        RETURN -1;
    END;

    SELECT @CurrentStock = SLTon, @DefaultPrice = GiaMua
    FROM VATTU WHERE MaVT = @MaVT;

    IF @CurrentStock IS NULL
    BEGIN
        RAISERROR(N'Error: Mã vật tư %s không tồn tại!', 16, 1, @MaVT);
        RETURN -2;
    END;

    IF @CurrentStock < @SL
    BEGIN
        RAISERROR(N'Error: Vật tư %s không đủ tồn kho! Còn lại: %d, Yêu cầu: %d', 16, 1, @MaVT, @CurrentStock, @SL);
        RETURN -3;
    END;

    -- Nếu không truyền giá bán, tự động tính giá bán mặc định từ giá mua (+15% markup)
    IF @GiaBan IS NULL
        SET @GiaBan = CAST(@DefaultPrice * 1.15 AS INT);

    -- 2. Thực thi cập nhật chi tiết hóa đơn và trừ kho trong một Transaction nguyên tử
    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM CHITIETHOADON WHERE MaHD = @MaHD AND MaVT = @MaVT)
            UPDATE CHITIETHOADON
            SET SL = SL + @SL, GiaBan = @GiaBan, KhuyenMai = @KhuyenMai
            WHERE MaHD = @MaHD AND MaVT = @MaVT;
        ELSE
            INSERT INTO CHITIETHOADON(MaHD, MaVT, SL, KhuyenMai, GiaBan)
            VALUES (@MaHD, @MaVT, @SL, @KhuyenMai, @GiaBan);

        UPDATE VATTU
        SET SLTon = SLTon - @SL
        WHERE MaVT = @MaVT;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH;

    PRINT N'Success: Đã thêm vật tư ' + @MaVT + N' vào hóa đơn ' + @MaHD;
    RETURN 0;
END;
GO

-- Kiểm tra Procedure 4:
-- EXEC dbo.QE210005_ProcAddItem @MaHD = 'HD002', @MaVT = 'VT01', @SL = 10, @GiaBan = 55000;
-- SELECT * FROM CHITIETHOADON WHERE MaHD = 'HD002';
-- SELECT MaVT, TenVT, SLTon FROM VATTU WHERE MaVT = 'VT01';
GO


-- -------------------------------------------------------------------------------------
-- Task 5: Write trigger name: StudenId_Trig1 on table Chitiethoadon,
--         when user insert data into Chitiethoadon, the trigger will update the Tongtien in HoaDon
--         (student should add Tongtien column into Hoadon, tongtien=sum(sl*giaban)).
-- -------------------------------------------------------------------------------------

-- Bước 5.1: Thêm cột Tongtien vào bảng HOADON nếu chưa có
IF NOT EXISTS (
    SELECT 1 FROM sys.columns 
    WHERE object_id = OBJECT_ID('HOADON') AND name = 'Tongtien'
)
BEGIN
    ALTER TABLE HOADON ADD Tongtien BIGINT DEFAULT 0;
END;
GO

-- Cập nhật giá trị tổng tiền ban đầu cho các hóa đơn hiện hữu
UPDATE H
SET H.Tongtien = (
    SELECT ISNULL(SUM(CAST(SL AS BIGINT) * CAST(GiaBan AS BIGINT)), 0)
    FROM CHITIETHOADON C
    WHERE C.MaHD = H.MaHD
)
FROM HOADON H;
GO

-- Bước 5.2: Tạo trigger QE210005_Trig1
IF OBJECT_ID('dbo.QE210005_Trig1', 'TR') IS NOT NULL
    DROP TRIGGER dbo.QE210005_Trig1;
GO

CREATE TRIGGER QE210005_Trig1
ON CHITIETHOADON
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @AffectedInvoices TABLE (MaHD nvarchar(10) PRIMARY KEY);
    
    INSERT INTO @AffectedInvoices (MaHD)
    SELECT DISTINCT MaHD FROM inserted
    UNION
    SELECT DISTINCT MaHD FROM deleted;
    
    UPDATE H
    SET H.Tongtien = (
        SELECT ISNULL(SUM(CAST(C.SL AS BIGINT) * CAST(C.GiaBan AS BIGINT)), 0)
        FROM CHITIETHOADON C
        WHERE C.MaHD = H.MaHD
    )
    FROM HOADON H
    INNER JOIN @AffectedInvoices A ON H.MaHD = A.MaHD;
END;
GO

-- Kiểm tra Trigger 5:
-- SELECT MaHD, Ngay, MaKH, Tongtien FROM HOADON WHERE MaHD = 'HD001';
-- INSERT INTO CHITIETHOADON(MaHD, MaVT, SL, GiaBan) VALUES ('HD001', 'VT02', 2, 60000);
-- SELECT MaHD, Ngay, MaKH, Tongtien FROM HOADON WHERE MaHD = 'HD001';
GO


-- -------------------------------------------------------------------------------------
-- Task 6: Write view name: StudentID_View1 to extract list of customers who bought ‘Gach Ong’
-- -------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.QE210005_View1', 'V') IS NOT NULL
    DROP VIEW dbo.QE210005_View1;
GO

CREATE VIEW QE210005_View1
AS
SELECT DISTINCT 
    K.MaKH AS [Mã khách hàng],
    K.TenKH AS [Tên khách hàng],
    K.DiaChi AS [Địa chỉ],
    K.DT AS [Điện thoại],
    K.Email AS [Email]
FROM KHACHHANG K
INNER JOIN HOADON H ON K.MaKH = H.MaKH
INNER JOIN CHITIETHOADON C ON H.MaHD = C.MaHD
INNER JOIN VATTU V ON C.MaVT = V.MaVT
WHERE UPPER(LTRIM(RTRIM(V.TenVT))) = N'GACH ONG';
GO

-- Kiểm tra View 6:
-- SELECT * FROM dbo.QE210005_View1;
GO
