-- Câu 1: Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS QL_BAN_HANG;
USE QL_BAN_HANG;

-- Câu 2: Tạo các bảng với ràng buộc
CREATE TABLE KHACH_HANG (
    MaKH        INT PRIMARY KEY AUTO_INCREMENT,
    TenKH       VARCHAR(100) NOT NULL,
    Email       VARCHAR(100) NOT NULL UNIQUE,
    SoDienThoai VARCHAR(15),
    DiaChi      VARCHAR(255)
);

CREATE TABLE SAN_PHAM (
    MaSP       INT PRIMARY KEY AUTO_INCREMENT,
    TenSP      VARCHAR(100) NOT NULL,
    Gia        DECIMAL(10,2) NOT NULL CHECK (Gia > 0),
    SoLuongTon INT NOT NULL CHECK (SoLuongTon >= 0)
);

CREATE TABLE DON_HANG (
    MaDH     INT PRIMARY KEY AUTO_INCREMENT,
    MaKH     INT NOT NULL,
    NgayDat  DATE NOT NULL,
    TongTien DECIMAL(12,2) NOT NULL CHECK (TongTien >= 0),
    FOREIGN KEY (MaKH) REFERENCES KHACH_HANG(MaKH) ON DELETE CASCADE
);

-- Câu 3: Thêm dữ liệu mẫu
INSERT INTO KHACH_HANG (MaKH, TenKH, Email, SoDienThoai, DiaChi) VALUES
(1, N'Nguyễn Văn A', 'a@gmail.com', '901111111', N'Hà Nội'),
(2, N'Trần Thị B',   'b@gmail.com', '902222222', N'Hải Phòng'),
(3, N'Lê Văn C',     'c@gmail.com', '903333333', N'Đà Nẵng');

INSERT INTO SAN_PHAM (MaSP, TenSP, Gia, SoLuongTon) VALUES
(1, 'Laptop',          15000000, 10),
(2, N'Điện thoại',      8000000, 20),
(3, 'Tai nghe',          500000, 50);

INSERT INTO DON_HANG (MaDH, MaKH, NgayDat, TongTien) VALUES
(1, 1, '2024-05-01', 15000000),
(2, 2, '2024-05-02',  8000000),
(3, 1, '2024-05-03',   500000);

-- Câu 4: Cập nhật địa chỉ khách hàng MaKH = 1
UPDATE KHACH_HANG
SET DiaChi = 'TP.HCM'
WHERE MaKH = 1;

-- Câu 5: Tăng giá tất cả sản phẩm lên 10%
UPDATE SAN_PHAM
SET Gia = Gia * 1.1;

-- Câu 6: Xóa khách hàng có MaKH = 3
DELETE FROM KHACH_HANG
WHERE MaKH = 3;

-- Câu 7: Hiển thị tất cả khách hàng
SELECT * FROM KHACH_HANG;

-- Câu 8: Sản phẩm có giá > 1.000.000
SELECT MaSP, TenSP, Gia
FROM SAN_PHAM
WHERE Gia > 1000000;

-- Câu 9: Hiển thị đơn hàng và tên khách hàng
SELECT dh.MaDH, kh.TenKH, dh.NgayDat, dh.TongTien
FROM DON_HANG dh
JOIN KHACH_HANG kh ON dh.MaKH = kh.MaKH;

-- Câu 10: Tổng tiền từng khách hàng
SELECT kh.MaKH, kh.TenKH, SUM(dh.TongTien) AS TongTien
FROM KHACH_HANG kh
JOIN DON_HANG dh ON kh.MaKH = dh.MaKH
GROUP BY kh.MaKH, kh.TenKH;

-- Câu 11: Khách hàng có tổng tiền > 10.000.000
SELECT kh.MaKH, kh.TenKH, SUM(dh.TongTien) AS TongTien
FROM KHACH_HANG kh
JOIN DON_HANG dh ON kh.MaKH = dh.MaKH
GROUP BY kh.MaKH, kh.TenKH
HAVING SUM(dh.TongTien) > 10000000;

-- Câu 12: Sắp xếp sản phẩm theo giá giảm dần
SELECT MaSP, TenSP, Gia
FROM SAN_PHAM
ORDER BY Gia DESC;
