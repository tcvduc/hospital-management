CREATE TABLE CHAMCONG (
    maNV int,
    thang date,
    soNgayCong int,
    PRIMARY KEY(maNV,thang)
);

CREATE TABLE BENHNHAN (
    maBN int,
    hoTen nchar(200),
    ngaySinh date,
    diaChi nchar(200),
    sdt nchar(200),
    PRIMARY KEY(maBN)
);

CREATE TABLE HOSOBENHNHAN (
    maKB int,
    ngayKB date,
    maNV int,
    maBN int,
    tinhTrangBanDau nchar(200),
    ketLuanCuaBacSi nchar(200),
    PRIMARY KEY(maKB)
);

CREATE TABLE HOSODICHVU (
    maKB int,
    maDV int,
    nguoiThucHien nchar(200),
    ngayGio date,
    ketLuan nchar(200),
    PRIMARY KEY(maKB,maDV)
);

CREATE TABLE HOADON (
    soHD int,
    maKB int,
    ngayGio date,
    nguoiPhuTrach nchar(200),
    tongTien nchar(200),
    PRIMARY KEY(soHD)
);

CREATE TABLE NHANVIEN (
    maNV int,
    hoTen nchar(200),
    luong nchar(200),
    ngaySinh date,
    diaChi nchar(200),
    vaiTro nchar(200),
    maDonVi int,
    PRIMARY KEY(maNV)
);

CREATE TABLE DONVI (
     maDonVi int,
     tenDonVi nchar(200),
    PRIMARY KEY(maDonVi)
);

CREATE TABLE DONTHUOC (
     maKB int,
     nhanVienPhuTrach nchar(200),
    PRIMARY KEY(maKB)
);

CREATE TABLE DICHVU (
     maDV int,
     tenDV nchar(200),
     donGia nchar(200),
    PRIMARY KEY(maDV)
);

CREATE TABLE CTHOADON (
     soHD int,
    maDV int,
    PRIMARY KEY(soHD,maDV)
);

CREATE TABLE CTDONTHUOC (
     maKB int,
    maThuoc int,
    soLuong nchar(200),
    lieuDung nchar(200),
    moTa nchar(200),
    PRIMARY KEY(maKB,maThuoc)
);

CREATE TABLE THUOC (
    maThuoc int,
    tenThuoc nchar(200),
    donViThuoc nchar(200),
    donGia nchar(200),
    luuY nchar(200),
    PRIMARY KEY(maThuoc)
);



-- FOREIGN KEY
ALTER TABLE CHAMCONG
ADD CONSTRAINT FK_CHAMCONG_NHANVIEN
FOREIGN KEY (maNV)
REFERENCES NHANVIEN(maNV);

ALTER TABLE HOSOBENHNHAN
ADD CONSTRAINT FK_HOSOBENHNHAN_NHANVIEN
FOREIGN KEY (maNV)
REFERENCES NHANVIEN(maNV);

ALTER TABLE HOSOBENHNHAN
ADD CONSTRAINT FK_HOSOBENHNHAN_BENHNHAN
FOREIGN KEY (maBN)
REFERENCES BENHNHAN(maBN);

ALTER TABLE HOSOBENHNHAN
ADD CONSTRAINT FK_HOSOBENHNHAN_BENHNHAN
FOREIGN KEY (maBN)
REFERENCES BENHNHAN(maBN);



