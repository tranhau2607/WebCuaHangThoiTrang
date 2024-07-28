
create database QL_CuaHangVascara
go
use QL_CuaHangVascara
go
-- Bảng danh sách loại sản phẩm
CREATE TABLE LoaiSanPham (
    MaLoai VARCHAR(20),
    TenLoai NVARCHAR(50),
	CONSTRAINT PK_LoaiSanPham PRIMARY KEY (MaLoai)
)

-- Bảng danh sách nhà sản xuất
CREATE TABLE NhaSanXuat (
    MaNhaSanXuat VARCHAR(20),
    TenNhaSanXuat NVARCHAR(50),
	SoDienThoai VARCHAR(20),
    DiaChi NVARCHAR(255),
    Email NVARCHAR(50),
	CONSTRAINT PK_MaNhaSanXuat PRIMARY KEY (MaNhaSanXuat)
)
Select * from SanPham
-- Bảng danh sách sản phẩm
CREATE TABLE SanPham 
(
    MaSanPham VARCHAR(20),
    TenSanPham NVARCHAR(50),
    Gia float,
    MoTa NVARCHAR(255),
	Anh nvarchar(255),
	MaLoai VARCHAR(20),
	MaNhaSanXuat VARCHAR(20),
	SanPhamTon int,
	SanPhamDaBan int
	CONSTRAINT PK_SanPham  PRIMARY KEY (MaSanPham)
)

create table ChitietSP
(
	MaCT VARCHAR(20) primary key,
	ThuongHieu NVARCHAR(50),
	MaSanPham VARCHAR(20),
	TenSanPham NVARCHAR(50),
	Gia float,
	Anh1 nvarchar(255),
	Anh2 nvarchar(255),
	Anh3 nvarchar(255),
	MoTa1 nvarchar(255),
	MoTa2 nvarchar(255),
	MoTa3 NVARCHAR(250),
	MoTa4 nvarchar(255),	
	CONSTRAINT FK_Chitietsanpham FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
)

-- Bảng danh sách đơn hàng
CREATE TABLE DonHang 
(
    MaDonHang int IDENTITY(1,1),
    TenDN VARCHAR(20),
    NgayDat DATEtime,
	Email nvarchar(100),
	HoTen nvarchar(60),
	SoDienThoai varchar(11),
	ChiTietDiaChi NVARCHAR(255),
	TongGiaTri float,
	HinhThucThanhToan NVARCHAR(255),
	TrangThai NVARCHAR(20),
	CONSTRAINT PK_DonHang  PRIMARY KEY (MaDonHang)
)

-- Bảng chi tiết đơn hàng
CREATE TABLE ChiTietDonHang (
    MaDonHang int IDENTITY(1,1),
    MaSanPham VARCHAR(20),
    SoLuong INT,
	ThanhTien float,
    CONSTRAINT PK_ChiTietDonHang PRIMARY KEY (MaDonHang, MaSanPham)
)


CREATE TABLE TaiKhoan (
	
	VaiTro char(10),
    Email nvarchar(100) Unique,
	HoTen nvarchar(60),
	NgaySinh date,
	GioiTinh nchar(3),
	SoDienThoai varchar(11),
	TenDN varchar(20) Primary key,
	MatKhau varchar(100),
	AnhBiaUser nvarchar(255)
)

--Bảng Dịa chỉ
CREATE TABLE DiaChi
(
	MaDiaChi int IDENTITY(1,1) primary key,
	TenDN varchar(20),
	ChiTietDiaChi NVARCHAR(255),
	ChiTietDiaChi2 NVARCHAR(255),
	CONSTRAINT FK_DiaChi Foreign key (TenDN) references TaiKhoan(TenDN)
)

CREATE TABLE GioHang
(
	TenDN varchar(20),
	MaSanPham VARCHAR(20),
	TenSanPham NVARCHAR(50),
	Anh nvarchar(255),
	Gia float,
	SoLuong int,
	ThanhTien float,
	constraint PK_GioHang primary key(TenDN,MaSanPham),
	constraint FK_GioHang_TenDN foreign key (TenDN) references TaiKhoan(TenDN),
	constraint FK_GioHang_MaSanPham foreign key (MaSanPham) references SanPham(MaSanPham)
)

--
CREATE TABLE VanChuyen (
    MaVanChuyen VARCHAR(20),
	MaDonHang int,
	NgayVanChuyen DATEtime,
	ChiPhiVanChuyen	FLOAT
    CONSTRAINT PK_VanChuyen_DonHang PRIMARY KEY (MaVanChuyen)
)
-- Tạo khóa ngoại cho bảng SanPham
ALTER TABLE SanPham
ADD CONSTRAINT FK_SanPham_MaLoai FOREIGN KEY (MaLoai) REFERENCES LoaiSanPham(MaLoai)
ALTER TABLE SanPham
ADD CONSTRAINT FK_SanPham_Nsx FOREIGN KEY (MaNhaSanXuat) REFERENCES NhaSanXuat(MaNhaSanXuat)


---- Tạo khóa ngoại cho bảng DonHang
ALTER TABLE DonHang
ADD CONSTRAINT FK_DonHang_TenDN FOREIGN KEY (TenDN) REFERENCES TaiKhoan(TenDN)


-- Tạo khóa ngoại cho bảng ChiTietDonHang
ALTER TABLE ChiTietDonHang
ADD CONSTRAINT FK_ChiTietDonHang_MaDonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang)
ALTER TABLE ChiTietDonHang
ADD CONSTRAINT FK_ChiTietDonHang_MaSanPham FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)

---- Tạo khóa ngoại cho bảng DonHang
ALTER TABLE VanChuyen
ADD CONSTRAINT FK_VanChuyen_DonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang)


set dateformat dmy
insert into TaiKhoan values	('Admin',N'admin@gmail.com',N'Nhóm 15','26/07/2003',N'Nam','0378857407','Admin','admin123','');
insert into TaiKhoan values	('User',N'khachhang1@gmail.com',N'Nhật Nga','06/01/2003',N'Nam','0902223337','nhatnga','123','');
insert into TaiKhoan values	('User',N'khachhang2@gmail.com',N'Thanh Ngân','03/07/2003',N'Nam','037654321','thanhngan','123','');
insert into TaiKhoan values	('User',N'khachhang3@gmail.com',N'Nhật Tú','16/12/2003',N'Nam','037886953','nhattu','123','');


------------------
INSERT INTO LoaiSanPham
VALUES	('LSP1',N'GIÀY'),
		('LSP2',N'TÚI XÁCH'),
		('LSP3',N'BALO'),
		('LSP4',N'VÍ'),
		('LSP5',N'MẮT KÍNH')
GO


INSERT INTO NhaSanXuat
VALUES	('NSX1',N'Hữu Đạt','0902256334',N'16 An Lạc, Hà Nội','hd09@gmail.com'),
		('NSX2',N'Bá Nghĩa','032323115',N'140 Lê Trọng Tấn, TP.HCM','bn03@gmail.com'),
		('NSX3',N'Huy Hoàng','0377297150',N'23 Nguyễn Văn An, Quảng Nam','hh99@gmail.com'),
		('NSX4',N'Kim Long','037956448',N'34 Âu Cơ, TP.HCM','kl882@gmail.com'),
		('NSX5',N'Thành Danh','0905774214',N'02 Tôn Đức Thắng, Hà Nội','td00@gmail.com')
GO

INSERT INTO SanPham 
VALUES	('SP001', N'Giày sandal metallic quai mảnh',			1000000, N'Thiết kế sang trọng','sandalmetallic.jpg',			'LSP1', 'NSX1',150,100),
		('SP002', N'Giày slingback quai khoét cách điệu',		950000,  N'Điệu đà',			'slingback.jpg',				'LSP1',	'NSX1',130,200),
		('SP003', N'Giày sandal ankle strap vân da kỳ đà',		950000,  N'Da sáng',			'sandalanklestrap.jpg',			'LSP1', 'NSX1',160,300),
		('SP004', N'Giày búp bê mũi vuông nhấn nơ',				584000,  N'Búp bê điệu đà',		'bet_bupbemuivuong.jpg',		'LSP1', 'NSX1',120,100),
		('SP005', N'Giày sandal quai mảnh',						614000,  N'Nhỏ gọn tinh tế',	'bet_sandal.jpg',				'LSP1',	'NSX1',110,200),
		('SP006', N'Giày sandal quai đôi phối xích kim loại',	614000,  N'Thiết kế mới',		'bet_sandal_quai_doi.jpg',		'LSP1', 'NSX1',170,300),
		('SP007', N'All-day comfort chelsea boot gót trụ',		331000,  N'Sang trọng',			'All-daycomfortchelseaboot.jpg','LSP1', 'NSX1',130,400),
		('SP008', N'All-day comfort combat boot cổ cao',		442000,  N'Sang trọng',			'All-daycomfortcombatboot.jpg',	'LSP1', 'NSX1',160,500),
		('SP009', N'Sandal boots vas x tao limited edition',	500000,  N'Sang trọng',			'Sandalbootslimitededition.jpg','LSP1', 'NSX1',120,100),
		('SP010', N'Sneaker đế chunky nhấn da suede',			1200000, N'Sang trọng',			'Sneaker_chunky.jpg',			'LSP1', 'NSX1',150,200),
		('SP011', N'Giày sneaker vải trang trí viền tua rua',	800000,  N'Thiết kế mới',		'Sneaker_tuarua.jpg',			'LSP1', 'NSX1',130,300),
		('SP012', N'Giày sneaker cổ điển',						700000,  N'Cổ điển',			'Sneaker_classic.jpg',			'LSP1', 'NSX1',160,400),
		('SP013', N'Túi layer họa tiết ngựa vằn',				990000,  N'Thiết kế độc lạ',	'SAT0312.jpg',					'LSP2',	'NSX2',180,500),
		('SP014', N'Túi xách leather quai cài khóa viền vàng',	1300000, N'Khóa chắc chắn',		'SAT0295.jpg',					'LSP2', 'NSX2',190,600),
		('SP015', N'Túi xách leather nhiều ngăn ',				1400000, N'Có nhiều ngăn',		'SAT0291.jpg',					'LSP2', 'NSX2',100,300),
		('SP016', N'Ví Dự Tiệc Envelope Da Thật',				1200000, N'Thiết kế sang trọng','CLU0123.jpg',					'LSP4', 'NSX4',123,100),
		('SP017', N'Ví cầm tay nhấn ngăn phụ',					500000,  N'Nhỏ gọn cầm tay',	'WAL0271.jpg',					'LSP4', 'NSX4',123,100),
		('SP018', N'Clutch da thật nhấn khóa gài',				1800000, N'Da thật sang trọng', 'CLU0112.jpg',					'LSP4', 'NSX4',123,100),
		('SP019', N'Kính mát gọng nhựa wayfarer',				600000,  N'Kính mát đi chơi',	'WAY0040.jpg',					'LSP5', 'NSX5',111,100),
		('SP020', N'Kính gọng nhựa trong suốt wayfarer',		50000,   N'Kính sáng',			'WAY0033.jpg',					'LSP5', 'NSX5',111,100),
		('SP021', N'Kính mắt hình đa giác gọng nhỏ',			530000,  N'Nhỏ gọn',			'SPE0008.jpg',					'LSP5', 'NSX5',111,100)
GO

insert into ChitietSP values
('CTSP01',N'VASCARA','SP001',null,null,'sandalmetallic.jpg','sandalmetallic2.jpg','sandalmetallic3.jpg',N'Gót nhọn','9 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo phủ ánh kim'),
('CTSP02',N'VASCARA','SP002',null,null,'slingback.jpg','slingback2.jpg','slingback3.jpg',N'Gót dạng khối','5.5 cm',N'Bít mũi quả hạnh',N'Da nhân tạo'),
('CTSP03',N'VASCARA','SP003',null,null,'sandalanklestrap.jpg','sandalanklestrap2.jpg','sandalanklestrap3.jpg',N'Gót nhọn','8 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo'),
('CTSP04',N'VASCARA','SP004',null,null,'bet_bupbemuivuong.jpg','bet_bupbemuivuong.jpg','bet_bupbemuivuong.jpg',N'Gót nhọn','8 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo'),
('CTSP05',N'VASCARA','SP005',null,null,'bet_sandal.jpg','bet_sandal2.jpg','bet_sandal2.jpg',N'Gót nhọn','8 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo'),
('CTSP06',N'VASCARA','SP006',null,null,'bet_sandal_quai_doi.jpg','bet_sandal_quai_doi2.jpg','bet_sandal_quai_doi3.jpg',N'Gót nhọn','8 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo'),
('CTSP07',N'VASCARA','SP007',null,null,'All-daycomfortchelseaboot.jpg','All-daycomfortchelseaboot2.jpg','All-daycomfortchelseaboot3.jpg',N'Gót nhọn','8 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo'),
('CTSP08',N'VASCARA','SP008',null,null,'All-daycomfortcombatboot.jpg','All-daycomfortcombatboot2.jpg','All-daycomfortcombatboot3.jpg',N'Gót nhọn','8 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo'),
('CTSP09',N'VASCARA','SP009',null,null,'Sandalbootslimitededition.jpg','Sandalbootslimitededition2.jpg','Sandalbootslimitededition3.jpg',N'Gót nhọn','8 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo'),
('CTSP10',N'VASCARA','SP010',null,null,'Sneaker_chunky.jpg','Sneaker_chunky2.jpg','Sneaker_chunky3.jpg',N'Gót nhọn','8 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo'),
('CTSP11',N'VASCARA','SP011',null,null,'Sneaker_tuarua.jpg','Sneaker_tuarua2.jpg','Sneaker_tuarua3.jpg',N'Gót nhọn','8 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo'),
('CTSP12',N'VASCARA','SP012',null,null,'Sneaker_classic.jpg','Sneaker_classic2.jpg','Sneaker_classic3.jpg',N'Gót nhọn','8 cm',N'Hở mũi (mũi vuông)',N'Da nhân tạo'),
('CTSP13',N'VASCARA','SP013',null,null,'SAT0312.jpg','SAT03122.jpg','SAT03123.jpg',N'25.5 x 12 x 22 cm',N'Da thật (họa tiết Ngựa vằn) & Da nhân tạo',N'Khóa kéo',N'2 ngăn lớn, 3 ngăn nhỏ'),
('CTSP14',N'VASCARA','SP014',null,null,'SAT0295.jpg','SAT02952.jpg','SAT02953.jpg',N'26.9*5.8*16 cm',N'Da thật ',N'Khóa nam châm',N'1 ngăn lớn, 2 ngăn nhỏ'),
('CTSP15',N'VASCARA','SP015',null,null,'SAT0291.jpg','SAT02912.jpg','SAT02913.jpg',N'23 x 6.6 x 13.2 cm',N'Da thật ',N'Khóa nam châm',N'2 ngăn lớn, 3 ngăn nhỏ'),
('CTSP16',N'VASCARA','SP016',null,null,'CLU0123.jpg','CLU01232.jpg','CLU01233.jpg',N'23 x 6.6 x 13.2 cm',N'Da thật ',N'Khóa nam châm',N'2 ngăn lớn, 3 ngăn nhỏ'),
('CTSP17',N'VASCARA','SP015',null,null,'WAL0271.jpg','WAL02712.jpg','WAL02713.jpg',N'23 x 6.6 x 13.2 cm',N'Da thật ',N'Khóa nam châm',N'2 ngăn lớn, 3 ngăn nhỏ'),
('CTSP18',N'VASCARA','SP015',null,null,'CLU0112.jpg','CLU01122.jpg','CLU01123.jpg',N'23 x 6.6 x 13.2 cm',N'Da thật ',N'Khóa nam châm',N'2 ngăn lớn, 3 ngăn nhỏ'),
('CTSP19',N'VASCARA','SP019',null,null,'WAY0040.jpg','WAY00402.jpg','WAY00403.jpg',N'Plastic & Kim loại',N'Công nghệ Polarized chống chói',N'Kính gọng vuông / Kính gọng hình thang',N'Mặt trái xoan, mặt tròn, mặt trái tim'),
('CTSP20',N'VASCARA','SP020',null,null,'WAY0033.jpg','WAY00332.jpg','WAY00333.jpg',N'Plastic & Kim loại',N'Chống tia UV',N'Kính gọng vuông / Kính gọng hình thang',N'Mặt trái xoan, mặt tròn, mặt trái tim'),
('CTSP21',N'VASCARA','SP021',null,null,'SPE0008.jpg','SPE00082.jpg','SPE00083.jpg',N'Plastic & Kim loại',N'Công nghệ Polarized chống chói',N'Kính có kiểu dáng đặc biệt',N'Mặt trái xoan, mặt tròn, mặt trái tim')
go

---------
select * from LoaiSanPham
select * from NhaSanXuat
select * from SanPham
select * from DonHang
select * from ChiTietDonHang
select * from VanChuyen


------ràng buộc------------

set dateformat dmy
--Ràng buộc Giá nhập>0
alter table SanPham
add constraint CHK_Gia check (Gia>0)

--Ràng buộc Số lượng  >0
alter table ChiTietDonHang
add constraint CHK_SoLuong check (SoLuong>0)


alter table SanPham
add constraint CHK_SanPhamDaBan check (SanPhamDaBan>=0)

alter table SanPham
add constraint CHK_SanPhamTon check (SanPhamTon>0)



create proc UpdateTatCaDonHang 
as
	begin
		update DonHang 
		set Email = (select Email from TaiKhoan where DonHang.TenDN=TaiKhoan.TenDN),
		HoTen =  (select HoTen from TaiKhoan where DonHang.TenDN=TaiKhoan.TenDN),
		SoDienThoai= (select SoDienThoai from TaiKhoan where DonHang.TenDN=TaiKhoan.TenDN),
		TongGiaTri = (select sum(SoLuong*ThanhTien) from ChiTietDonHang where ChiTietDonHang.MaDonHang=DonHang.MaDonHang)
	end;
go
create proc Update1DonHang @MaDonHang int
as
	begin
		update DonHang 
		set Email = (select Email from TaiKhoan where DonHang.TenDN=TaiKhoan.TenDN),
		HoTen =  (select HoTen from TaiKhoan where DonHang.TenDN=TaiKhoan.TenDN),
		SoDienThoai= (select SoDienThoai from TaiKhoan where DonHang.TenDN=TaiKhoan.TenDN),
		TongGiaTri = (select sum(SoLuong*ThanhTien) from ChiTietDonHang where ChiTietDonHang.MaDonHang=DonHang.MaDonHang)
		where MaDonHang = @MaDonHang
	end;
go

create proc updateThanhTien_CTDH @MaSanPham varchar(20)
as
	begin
		update ChiTietDonHang
		set ThanhTien=(select SoLuong*Gia from SanPham where ChiTietDonHang.MaSanPham=SanPham.MaSanPham)
		where MaSanPham=@MaSanPham
	end;
go

alter table DonHang
add constraint DF_TrangThai default N'Đang xử lý' for TrangThai;


create procedure UpdateGioHang @Masp VARCHAR(20),@TenDN VARCHAR(20)
as
	begin
		update GioHang 
		set Gia=(select Gia from SanPham where SanPham.MaSanPham=GioHang.MaSanPham),
		Anh=(select Anh from SanPham where SanPham.MaSanPham=GioHang.MaSanPham),
		TenSanPham=(select TenSanPham from SanPham where SanPham.MaSanPham=GioHang.MaSanPham),
		ThanhTien=(select Gia*SoLuong from SanPham where SanPham.MaSanPham=GioHang.MaSanPham )
		where TenDN=@TenDN and MaSanPham=@Masp
	end;
go

create procedure TangSoLuong @Masp VARCHAR(20),@TenDN VARCHAR(20)
as
	begin
		update GioHang 
		set SoLuong =SoLuong+1
		where TenDN=@TenDN and MaSanPham=@Masp
	end;
go

create procedure ThemGioHang @Masp VARCHAR(20),@TenDN VARCHAR(20)
as
	begin
		if EXISTS (select * from GioHang where MaSanPham=@Masp and TenDN=@TenDN)
			begin
				exec TangSoLuong @Masp,@TenDN;
				exec UpdateGioHang @Masp,@TenDN
			end;
		else
			begin
				insert into GioHang(TenDN,MaSanPham,SoLuong) values(@TenDN,@Masp,1);
				exec UpdateGioHang @Masp,@TenDN
			end;
	end;
go

create procedure ThemGioHang2 @Masp VARCHAR(20),@TenDN VARCHAR(20), @SoLuong int
as
	begin
		if EXISTS (select * from GioHang where MaSanPham=@Masp and TenDN=@TenDN)
			begin
				update GioHang 
				set SoLuong =SoLuong+@SoLuong
					where TenDN=@TenDN and MaSanPham=@Masp
				exec UpdateGioHang @Masp,@TenDN
			end;
		else
			begin
				insert into GioHang(TenDN,MaSanPham,SoLuong) values(@TenDN,@Masp,@SoLuong);
				exec UpdateGioHang @Masp,@TenDN
			end;
	end;
go

create proc UpdateSoLuong @Masp VARCHAR(20),@TenDN VARCHAR(20),@SoLuong int
as
	begin
		if @SoLuong <= 0
			delete from GioHang where TenDN=@TenDN and MaSanPham=@Masp
		else
			begin 
				update GioHang 
				set SoLuong =@SoLuong
				where TenDN=@TenDN and MaSanPham=@Masp
				exec UpdateGioHang @Masp,@TenDN
			end;
	end;
go

update ChitietSP 
set TenSanPham = (select TenSanPham from SanPham where ChitietSP.MaSanPham=SanPham.MaSanPham)
update ChitietSP 
set Gia = (select Gia from SanPham where ChitietSP.MaSanPham=SanPham.MaSanPham)


update ChiTietDonHang
set ThanhTien=(select SoLuong*Gia from SanPham where ChiTietDonHang.MaSanPham=SanPham.MaSanPham)
go
exec UpdateTatCaDonHang
go

create proc UpdateMK @TenDN varchar(20),@MK nvarchar(100)
as
	begin
		update TaiKhoan
		set MatKhau=@MK where TenDN=@TenDN 
	end
go
exec UpdateMK 'kh1','1233'
select * from TaiKhoan


-- Tạo trigger sau khi chèn dữ liệu vào bảng ChiTietDonHang
CREATE TRIGGER AfterInsertChiTietDonHang
ON ChiTietDonHang
AFTER INSERT
AS
BEGIN
    UPDATE SanPham
    SET SanPhamTon = SanPhamTon - inserted.SoLuong,
        SanPhamDaBan = SanPhamDaBan + inserted.SoLuong
    FROM SanPham
    INNER JOIN inserted ON SanPham.MaSanPham = inserted.MaSanPham;
END;

-- Tạo trigger sau khi xóa dữ liệu từ bảng ChiTietDonHang
CREATE TRIGGER AfterDeleteChiTietDonHang
ON ChiTietDonHang
AFTER DELETE
AS
BEGIN
    UPDATE SanPham
    SET SanPhamTon = SanPhamTon + deleted.SoLuong,
        SanPhamDaBan = SanPhamDaBan - deleted.SoLuong
    FROM SanPham
    INNER JOIN deleted ON SanPham.MaSanPham = deleted.MaSanPham;
END;

-- Tạo trigger sau khi cập nhật dữ liệu trong bảng ChiTietDonHang
CREATE TRIGGER AfterUpdateChiTietDonHang
ON ChiTietDonHang
AFTER UPDATE
AS
BEGIN
    UPDATE SanPham
    SET SanPhamTon = SanPhamTon + deleted.SoLuong - inserted.SoLuong,
        SanPhamDaBan = SanPhamDaBan + inserted.SoLuong - deleted.SoLuong
    FROM SanPham
    INNER JOIN inserted ON SanPham.MaSanPham = inserted.MaSanPham
    INNER JOIN deleted ON SanPham.MaSanPham = deleted.MaSanPham;
END;
use QL_CuaHangVascara
select * from TaiKhoan