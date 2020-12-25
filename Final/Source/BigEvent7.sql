CREATE DATABASE [BigEvent]
ON 
	PRIMARY (NAME = BigEvent_DATA,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data\BigEvent.MDF' ,
	SIZE = 50MB , 
    MAXSIZE = 200MB , 
    FILEGROWTH = 10MB) 
LOG ON (NAME = BigEvent_LOG , 
		FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Data\BigEvent.LDF' ,
		SIZE = 10MB , 
		FILEGROWTH = 5MB) 
GO

--BACKUP DATABASE
BACKUP DATABASE [BigEvent]
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\BigEvent.BAK'

DROP TABLE [CoSo]
DROP TABLE [SuKien]
DROP TABLE [Admin]
DROP TABLE [BoPhan]
DROP TABLE [ToChuc]
DROP TABLE [DanhMucQuanHuyen]
DROP DATABASE [BigEvent]

USE [BigEvent]
GO

Create table [SuKien]
(
	[MaSuKien] Bigint Identity(1,1) NOT NULL,
	[AnhSuKien] Nvarchar(max) NULL,
	[TenSuKien] Nvarchar(max) NOT NULL,
	[LoaiSuKien] Nvarchar(20) NULL,
	[TenDiaDiem] Nvarchar(50) NULL,
	[DiaChi] Nvarchar(128) NULL,
	[MaQuanHuyen] Tinyint NULL,
	[MaCoSo] Tinyint NULL,
	[Phong] Nvarchar(20) NULL,
	[ThongTinSuKien] Nvarchar(max) NULL,
	[NgayBatDau] Date NULL,
	[NgayKetThuc] Date NULL,
	[ThoiGianBatDau] Time(0) NULL,
	[ThoiGianKetThuc] Time(0) NULL,
	[NgayTaoSuKien] Date NULL
Primary Key ([MaSuKien])
) 
go

Create table [CoSo]
(
	[MaCoSo] Tinyint Identity(1,1) NOT NULL,
	[TenCoSo] Nvarchar(20) NOT NULL,
	[DiaChiCoSo] Nvarchar(256) NULL,
Primary Key ([MaCoSo])
) 
go

Create table [BoPhan]
(
	[MaBoPhan] Tinyint Identity(1,1) NOT NULL,
	[TenBoPhan] Nvarchar(128) NOT NULL,
	[LogoBoPhan] Nvarchar(max) NULL,
Primary Key ([MaBoPhan])
) 
go

Create table [Admin]
(
	[TenDangNhap] Nvarchar(20) NOT NULL,
	[MatKhau] Nvarchar(50) NOT NULL,
Primary Key ([TenDangNhap])
) 
go

Create table [ToChuc]
(
	[MaSuKien] Bigint NOT NULL,
	[MaBoPhan] Tinyint NOT NULL,
Primary Key ([MaSuKien],[MaBoPhan])
) 
go

Create table [DanhMucQuanHuyen]
(
	[MaQuanHuyen] Tinyint Identity(1,1) NOT NULL,
	[TenQuanHuyen] Nvarchar(128) NOT NULL,
Primary Key ([MaQuanHuyen])
) 
go

--Tạo ràng buộc bảng sự kiện
ALTER TABLE [SuKien] ADD
DEFAULT (1) FOR [MaCoSo],
DEFAULT (1) FOR [MaQuanHuyen],
DEFAULT GETDATE() FOR [NgayTaoSuKien],
DEFAULT (N'~/Content/Images/default.jpg') FOR [AnhSuKien],
CONSTRAINT CK_NBD CHECK([NgayBatDau] >= GETDATE()),
CONSTRAINT CK_TG CHECK([ThoiGianKetThuc] > [ThoiGianBatDau]),
CONSTRAINT CK_N CHECK([NgayKetThuc] >= [NgayBatDau]),
CONSTRAINT CK_LSK CHECK([LoaiSuKien] IN (N'Trong trường',N'Ngoài trường'))
GO


--Tạo ràng buộc bảng tổ chức
ALTER TABLE [ToChuc] ADD
DEFAULT (1) FOR [MaBoPhan]
GO

--Tạo khóa ngoại
Alter table [ToChuc] add  foreign key([MaSuKien]) references [SuKien] ([MaSuKien])  on update cascade on delete cascade
go
Alter table [SuKien] add  foreign key([MaCoSo]) references [CoSo] ([MaCoSo])  on update cascade on delete set default
go
Alter table [ToChuc] add  foreign key([MaBoPhan]) references [BoPhan] ([MaBoPhan])  on update cascade on delete set default
go
Alter table [SuKien] add  foreign key([MaQuanHuyen]) references [DanhMucQuanHuyen] ([MaQuanHuyen])  on update cascade on delete set default 
go

--Nhập dữ liệu bảng cơ sở
INSERT INTO CoSo(TenCoSo,DiaChiCoSo)
VALUES(N'', N'')
INSERT INTO CoSo(TenCoSo,DiaChiCoSo)
VALUES(N'Cơ sở A', N'475A Điện Biên Phủ, P25, Q.Bình Thạnh, TP.HCM')
INSERT INTO CoSo(TenCoSo,DiaChiCoSo)
VALUES(N'Cơ sở B', N'475A Điện Biên Phủ, P25, Q.Bình Thạnh, TP.HCM')
INSERT INTO CoSo(TenCoSo,DiaChiCoSo)
VALUES(N'Cơ sở U', N'31/36 Ưng Văn Khiêm, P.25, Q.Bình Thạnh, TP.HCM')
INSERT INTO CoSo(TenCoSo,DiaChiCoSo)
VALUES(N'Cơ sở E', N'Lô E1, Phân khu đào tạo E1, Khu Công Nghệ Cao TP.HCM, Phường Hiệp Phú, Quận 9, TP.HCM')
INSERT INTO CoSo(TenCoSo,DiaChiCoSo)
VALUES(N'Cơ sở R', N'Viện Công nghệ Cao Hutech, Lô E2B4, đường D1, Phường Long Thạnh Mỹ, khu Công Nghệ Cao, Quận 9, TP.HCM')
INSERT INTO CoSo(TenCoSo,DiaChiCoSo)
VALUES(N'Cơ sở D', N'276 Điện Biên Phủ, Q.Bình Thạnh, TP.HCM')
GO

--Nhập dữ liệu bảng bộ phận
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Đào tạo - Khảo thí',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Văn phòng trường',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Tài chính',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Quản trị',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Tư vấn Tuyển sinh - Truyền thông',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Công tác Sinh viên',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Khoa học Công nghệ',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Ban Thanh tra',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Đảng bộ',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Công đoàn',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Phòng - Ban Đoàn Thanh niên - Hội Sinh viên',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Dược',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa QT Du lịch - Nhà hàng - Khách sạn',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Quản trị kinh doanh',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Tiếng Anh',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Kế toán - Tài chính - Ngân hàng',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Luật',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Kiến trúc - Mỹ thuật',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa KHXH và Nhân văn',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Công nghệ thông tin',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Xây dựng',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Hệ thống thông tin quản lý',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Nhật Bản học',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Khoa Truyền thông và Thiết kế',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Viện Đào Tạo Quốc Tế',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Viện Công Nghệ Việt-Nhật',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Viện Kỹ Thuật Hutech',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Viện Khoa Học Ứng Dụng HUTECH',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Viện Đào Tạo Sau Đại Học',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Viện Đào Tạo Nghề Nghiệp HUTECH',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Viện Quản Trị - Tài Chính - Kế Toán',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Viện Công Nghệ CIRTECH',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Trung tâm Đào tạo từ xa',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Trung tâm Chính trị quốc phòng',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Trung tâm hợp tác Doanh nghiệp',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Trung tâm Văn hóa nghệ thuật',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Trung tâm Đảm bảo chất lượng',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Trung tâm quản lý CNTT',N'~/Content/Images/BoPhan/Logo.png')
INSERT INTO BoPhan(TenBoPhan,LogoBoPhan)
VALUES(N'Trung tâm Anh ngữ Quốc tế ELC',N'~/Content/Images/BoPhan/Logo.png')
GO

--Nhập dữ liệu bảng danh mục quận huyện
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 1')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 2')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 3')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 4')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 5')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 6')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 7')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 8')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 9')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 10')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 11')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận 12')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận Bình Tân')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận Bình Thạnh')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận Gò Vấp')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận Phú Nhuận')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận Thủ Đức')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận Tân Bình')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Quận Tân Phú')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Huyện Bình Chánh')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Huyện Củ Chi')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Huyện Hóc Môn')
INSERT INTO DanhMucQuanHuyen(TenQuanHuyen)
VALUES(N'Huyện Nhà Bè')
GO

--Nhập dữ liệu bảng admin
INSERT INTO Admin(TenDangNhap,MatKhau)
VALUES('lekhoide','123456')
GO



--Reset mã sự kiện về 1
DBCC CHECKIDENT ('[SuKien]', RESEED, 0)
GO
--Reset mã bộ phận về 1
DBCC CHECKIDENT ('[BoPhan]', RESEED, 0)
GO

--//Nhập dữ liệu bảng sự kiện

--Nhập đầy đủ các thuộc tính trừ NgayTaoSuKien
INSERT INTO SuKien(AnhSuKien,TenSuKien,LoaiSuKien,TenDiaDiem,DiaChi,MaQuanHuyen,MaCoSo,Phong,ThongTinSuKien,NgayBatDau,NgayKetThuc,ThoiGianBatDau,ThoiGianKetThuc,TenDangNhap)
SELECT BulkColumn,N'Hutech Code War 2019',N'Trong trường',N'Công ty A',N'62B Lê Đại Hành',(2),(2),N'Phòng B.02-08',N'abcd...',CONVERT(DATE,'10/11/2019',103),CONVERT(DATE,'11/11/2019',103),FORMAT(CONVERT(DATETIME,'10:00:00'),'hh:mm tt'),FORMAT(CONVERT(DATETIME,'11:00:00'),'hh:mm tt'),N'lekhoide'
FROM OPENROWSET( BULK 'C:\Users\lekho\source\repos\Special Project\BigEvent v.12\BigEvent\BigEvent\Content\image\1.jpg', SINGLE_BLOB) AS [AnhSuKien]
--Không nhập 2 thuộc tính MaBoPhan va MaQuanHuyen thì có trả về default
INSERT INTO SuKien(AnhSuKien,TenSuKien,LoaiSuKien,TenDiaDiem,DiaChi,Phong,ThongTinSuKien,NgayBatDau,NgayKetThuc,ThoiGianBatDau,ThoiGianKetThuc,TenDangNhap)
SELECT BulkColumn,N'Hutech Got Talent 2019',N'Trong trường',N'Công ty A',N'62B Lê Đại Hành',N'Phòng B.02-08',N'abcd...',CONVERT(DATE,'10/11/2019',103),CONVERT(DATE,'11/11/2019',103),FORMAT(CONVERT(DATETIME,'10:00:00'),'hh:mm tt'),FORMAT(CONVERT(DATETIME,'11:00:00'),'hh:mm tt'),N'lekhoide'
FROM OPENROWSET( BULK 'C:\Users\lekho\source\repos\Special Project\BigEvent v.12\BigEvent\BigEvent\Content\image\2.jpg', SINGLE_BLOB) AS [AnhSuKien]

--Kiểm tra khi nhập loại sự kiện nếu không trùng Trong trường và Ngoài trường có báo lỗi. Không phân biệt được chữ hoa và chữ thường
INSERT INTO SuKien(AnhSuKien,TenSuKien,LoaiSuKien,TenDiaDiem,DiaChi,Phong,ThongTinSuKien,NgayBatDau,NgayKetThuc,ThoiGianBatDau,ThoiGianKetThuc,TenDangNhap)
SELECT BulkColumn,N'Hutech Model 2019',N'Trong Trường',N'Công ty A',N'62B Lê Đại Hành',N'Phòng B.02-08',N'abcd...',CONVERT(DATE,'10/11/2019',103),CONVERT(DATE,'11/11/2019',103),FORMAT(CONVERT(DATETIME,'10:00:00'),'hh:mm tt'),FORMAT(CONVERT(DATETIME,'11:00:00'),'hh:mm tt'),N'lekhoide'
FROM OPENROWSET( BULK 'C:\Users\lekho\Pictures\BigEvent\1.jpg', SINGLE_BLOB) AS [AnhSuKien]
INSERT INTO SuKien(AnhSuKien,TenSuKien,LoaiSuKien,TenDiaDiem,DiaChi,Phong,ThongTinSuKien,NgayBatDau,NgayKetThuc,ThoiGianBatDau,ThoiGianKetThuc,TenDangNhap)
SELECT BulkColumn,N'Hutech Startup 2019',N'ngoài trường',N'Công ty A',N'62B Lê Đại Hành',N'Phòng B.02-08',N'abcd...',CONVERT(DATE,'10/11/2019',103),CONVERT(DATE,'11/11/2019',103),FORMAT(CONVERT(DATETIME,'10:00:00'),'hh:mm tt'),FORMAT(CONVERT(DATETIME,'11:00:00'),'hh:mm tt'),N'lekhoide'
FROM OPENROWSET( BULK 'C:\Users\lekho\Pictures\BigEvent\1.jpg', SINGLE_BLOB) AS [AnhSuKien]
GO

--Thiếu thuộc tính ngày tạo sự kiện
INSERT INTO SuKien(AnhSuKien,TenSuKien,LoaiSuKien,TenDiaDiem,DiaChi,MaQuanHuyen,MaCoSo,Phong,ThongTinSuKien,NgayBatDau,NgayKetThuc,ThoiGianBatDau,ThoiGianKetThuc)
VALUES (N'~/Content/Images/SuKien/Cuối thu.jpg',N'Cuối thu',N'Trong trường',N'',N'',(1),(2),N'Phòng B.02-08',N'abcd...',CONVERT(DATE,'10/11/2019',103),CONVERT(DATE,'11/11/2019',103),'18:00:00','19:00:00')
GO
INSERT INTO SuKien(AnhSuKien,TenSuKien,LoaiSuKien,TenDiaDiem,DiaChi,MaQuanHuyen,MaCoSo,Phong,ThongTinSuKien,NgayBatDau,NgayKetThuc,ThoiGianBatDau,ThoiGianKetThuc)
VALUES (N'~/Content/Images/SuKien/Chớm thu 3.jpg',N'Chớm thu',N'Ngoài trường',N'Công ty A',N'62B Lê Đại Hành',(2),(1),N'Phòng A-02',N'abcd...',CONVERT(DATE,'10/11/2019',103),CONVERT(DATE,'11/11/2019',103),'18:00:00','19:00:00')
GO
INSERT INTO SuKien(AnhSuKien,TenSuKien,LoaiSuKien,TenDiaDiem,DiaChi,MaQuanHuyen,MaCoSo,Phong,ThongTinSuKien,NgayBatDau,NgayKetThuc,ThoiGianBatDau,ThoiGianKetThuc)
VALUES (N'~/Content/Images/SuKien/Ngõ nắng.jpg',N'Ngõ nắng',N'Ngoài trường',N'Công ty A',N'62B Lê Đại Hành',(2),(1),N'Phòng A-02',N'abcd...',CONVERT(DATE,'30/12/2019',103),CONVERT(DATE,'31/12/2019',103),'18:00:00','19:00:00')
GO
INSERT INTO SuKien(TenSuKien)
VALUES (N'Hello World')
GO


--Nhập dữ liệu bảng tổ chức
INSERT INTO ToChuc(MaSuKien,MaBoPhan)
VALUES(1,2)
GO
INSERT INTO ToChuc(MaSuKien,MaBoPhan)
VALUES(1,3)
GO
INSERT INTO ToChuc(MaSuKien,MaBoPhan)
VALUES(2,2)
GO
INSERT INTO ToChuc(MaSuKien,MaBoPhan)
VALUES(2,3)
GO

--Nạp dữ liệu JSON lên hệ thống
--C1 Lấy dữ liệu Json và Format
DECLARE @json Nvarchar(max) = N'[{"TenSuKien":"\n                            Để phòng dịch bệnh Covid-19 an toàn, sinh viên HUTECH nghỉ học đến hết 15/3                         ","AnhSuKien":"https://file1.hutech.edu.vn/file/editor/homepage1/620-413%281%29.png","ThongTinSuKien":"\n                            Nhằm đảm bảo an toàn sức khỏe cho sinh viên - học viên trước tình hình diễn biến phức tạp của dịch bệnh Covid-19, trường Đại học Công nghệ TP.HCM (HUTECH) thông báo cho sinh viên - học viên tiếp tục nghỉ học đến hết...                          "},{"TenSuKien":"\n                            HUTECH trang trọng tổ chức Lễ kỷ niệm 70 năm ngày truyền thống Sinh viên, Học sinh                         ","AnhSuKien":"https://file1.hutech.edu.vn/file/editor/homepage1/3N7A9439%281%29.jpg","ThongTinSuKien":"\n                            Chiều 09/01/2020, đúng vào dịp kỷ niệm 70 năm ngày truyền thống Sinh viên, Học sinh (09/01/1950 - 09/01/2020), trường Đại học Công nghệ TP.HCM (HUTECH) đã long trọng tổ chức Lễ kết nạp Đảng viên, Kỷ niệm 70 năm ngày...                          "},{"TenSuKien":"\n                            HUTECH tổ chức lấy ý kiến phản hồi của sinh viên về hoạt động giảng dạy Học kỳ 1B năm học 2019 - 2020                         ","AnhSuKien":"https://file1.hutech.edu.vn/file/editor/homepage1/_C1A9552.jpg","ThongTinSuKien":"\n                            Từ ngày 6/1/2020, trường Đại học Công nghệ TP.HCM (HUTECH) sẽ tổ chức khảo sát lấy ý kiến phản hồi của sinh viên về hoạt động giảng dạy của giảng viên nhằm nâng cao chất lượng dạy và học của Nhà trường.\r\n&nbsp;...                          "},{"TenSuKien":"\n                            HUTECH dẫn đầu cả nước về số lượng cá nhân, tập thể “Sinh viên 5 tốt” cấp Trung ương                         ","AnhSuKien":"https://file1.hutech.edu.vn/file/editor/homepage1/620%20%284%29.png","ThongTinSuKien":"\n                            Vừa qua, Trung ương Hội Sinh viên Việt Nam đã công bố kết quả bình xét các cá nhân và tập thể tiên tiến được tuyên dương “Sinh viên 5 tốt” cấp trung ương năm học 2018 -&nbsp;2019. Với 90/269 cá nhân (chiếm 33,5%) và...                          "},{"TenSuKien":"\n                            Đề án tuyển sinh Đại học chính quy năm 2020 dự kiến của HUTECH                         ","AnhSuKien":"https://file1.hutech.edu.vn/file/editor/homepage/stories/hinh212-sea/IMG_5211.jpg","ThongTinSuKien":"\n                            Năm 2020,&nbsp;Trường Đại học Công nghệ TP.HCM (HUTECH) dự kiến tuyển sinh 5.950 chỉ tiêu với&nbsp;47&nbsp;ngành đào tạo&nbsp;trình độ Đại học chính quy theo 04&nbsp;phương thức xét tuyển độc lập:\r\n\r\n1. Phương thức...                          "},{"TenSuKien":"\n                            Sinh viên Dược HUTECH đón đợi Lễ tốt nghiệp đợt Tháng 12/2019                         ","AnhSuKien":"https://file1.hutech.edu.vn/file/editor/homepage1/ky-620.png","ThongTinSuKien":"\n                            Là đợt tốt nghiệp cuối cùng trong năm 2019, từ ngày 07 đến ngày 15/12/2019 tới đây, trường Đại học Công nghệ TP.HCM (HUTECH) sẽ tổ chức Lễ trao bằng tốt nghiệp cho các Tân cử nhân, Tân kỹ sư thuộc 14 Khoa/Viện...                          "},{"TenSuKien":"\n                            TB Tập huấn ban cán sự lớp học kỳ 2 năm học 2018-2019                         ","AnhSuKien":"/imgnews/homepage/stories/hinh213-hea/ban-can-su620.png","ThongTinSuKien":"\n                            Nhằm rà soát Ban cán sự lớp trong toàn trường, triển khai hướng dẫn tổ chức Sinh hoạt lớp, Lớp học tiên tiến, công tác Đánh giá rèn luyện, đăng ký ngoại trú và các hoạt động, phong trào Sinh viên của Đoàn Thanh niên -...                          "},{"TenSuKien":"\n                            Chương trình hỗ trợ vui sống khỏe - “TẨY GIUN ĐẦU NĂM – SỐNG KHỎE QUANH NĂM”                         ","AnhSuKien":"https://file1.hutech.edu.vn/file/news/untitled-1546959233.jpg","ThongTinSuKien":"\n                            Việt Nam là một trong những quốc gia có điều kiện khí hậu thuận lợi cho bệnh giun tồn tại và phát triển. Theo điều tra của các Viện sốt rét - Ký sinh trùng - Côn Trùng và các tỉnh thành từ năm 2013-2017, tỷ lệ nhiễm...                          "},{"TenSuKien":"\n                            Khoa Dược trao áo Blouse cho Dược sĩ tương lai trong chương trình chào đón tân sinh viên                         ","AnhSuKien":"/imgnews/homepage/stories/hinh212-sea/HUTE5060.jpg","ThongTinSuKien":"\n                            Chiều qua 19/09, hơn 400 Tân sinh viên khoa Dược, trường Đại học Công nghệ TP.HCM (HUTECH) đã có buổi giao lưu, gặp gỡ chính thức với Ban chủ nhiệm khoa tại Trụ sở chính của trường trong không khí vui tươi, cởi mở...                          "},{"TenSuKien":"\n                            Điều kiện mở nhà thuốc tư nhân: Dược sĩ Đại học chỉ cần 18 tháng kinh nghiệm                         ","AnhSuKien":"https://file1.hutech.edu.vn/file/news/img_0689_1-1492045057.jpg","ThongTinSuKien":"\n                             Tại cổng tư vấn trực tuyến của trường Đại học Công nghệ, cùng với việc tìm hiểu về thông tin tuyển sinh, chương trình đào tạo, cơ hội việc làm của...                          "}]'



INSERT INTO [SuKien] (AnhSuKien, TenSuKien)
SELECT AnhSuKien, TenSuKien
FROM OPENJSON(@json)
WITH([AnhSuKien] Nvarchar(max), [TenSuKien] Nvarchar(256))

--C2: Nạp file từ máy và đẩy lên hệ thống. Lỗi định dạng
DECLARE @json1 Nvarchar(max)
--Bôi đen đoạn nạp file json
SELECT @json1 = BulkColumn FROM OPENROWSET(BULK 'D:\json2.json' ,SINGLE_CLOB) as j;

SELECT * FROM OPENJSON(@json1)
WITH([AnhSuKien] Nvarchar(max), [TenSuKien] Nvarchar(256))

INSERT INTO [SuKien] (AnhSuKien, TenSuKien)
SELECT AnhSuKien, TenSuKien
FROM OPENJSON(@json1)
WITH([AnhSuKien] Nvarchar(max), [TenSuKien] Nvarchar(256))

SELECT * FROM SuKien
SELECT * FROM CoSo
SELECT * FROM DanhMucQuanHuyen
SELECT * FROM BoPhan
SELECT * FROM Admin
SELECT * FROM ToChuc