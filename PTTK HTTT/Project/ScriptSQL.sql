CREATE DATABASE [FastFoodAndDrink]
GO

USE [FastFoodAndDrink]
GO
/****** Object:  Table [dbo].[CaLamViec]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaLamViec](
	[MaCa] [nchar](13) NOT NULL,
	[TenCa] [nvarchar](30) NOT NULL,
	[thoiGian] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_CaLamViec] PRIMARY KEY CLUSTERED 
(
	[MaCa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CheBien]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheBien](
	[MaMA] [nchar](13) NOT NULL,
	[MANL] [nchar](13) NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK_CheBien] PRIMARY KEY CLUSTERED 
(
	[MaMA] ASC,
	[MANL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[MaCV] [nchar](13) NOT NULL,
	[TenCV] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_ChucVU] PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTHD]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTHD](
	[MaHD] [nchar](13) NOT NULL,
	[MaMA] [nchar](13) NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK_CTHD] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaMA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTPN]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTPN](
	[MaPhieuNhap] [nchar](13) NOT NULL,
	[MaNL] [nchar](13) NOT NULL,
	[SL_Nhap] [int] NULL,
 CONSTRAINT [PK_CTPN] PRIMARY KEY CLUSTERED 
(
	[MaPhieuNhap] ASC,
	[MaNL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHD] [nchar](13) NOT NULL,
	[MaNV] [nchar](13) NOT NULL,
	[MaKH] [nchar](13) NOT NULL,
	[MaGiamGia] [nchar](13) NOT NULL,
	[NgayBan] [datetime] NOT NULL,
	[TongHoaDon] [float] NOT NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [nchar](13) NOT NULL,
	[TenKH] [nvarchar](30) NOT NULL,
	[SDT] [nchar](10) NOT NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MonAn]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonAn](
	[MaMA] [nchar](13) NOT NULL,
	[TenMA] [nvarchar](30) NOT NULL,
	[DonGia] [float] NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK__MonAn__2725DFC0CFCE9361] PRIMARY KEY CLUSTERED 
(
	[MaMA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NguyenLieu]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguyenLieu](
	[MaNL] [nchar](13) NOT NULL,
	[TenNL] [nvarchar](30) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[Gia] [float] NOT NULL,
	[PhanLoai] [nvarchar](30) NOT NULL,
	[DonVi] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK__NguyenLi__2725D73C76FAECCB] PRIMARY KEY CLUSTERED 
(
	[MaNL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNCC] [nchar](13) NOT NULL,
	[TenNCC] [nvarchar](30) NOT NULL,
	[SDT] [nchar](10) NOT NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__NhaCungC__3A185DEBDED9B5CE] PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [nchar](13) NOT NULL,
	[MaCa] [nchar](13) NOT NULL,
	[MaCV] [nchar](13) NOT NULL,
	[TenNV] [nvarchar](30) NOT NULL,
	[CMND] [nchar](12) NOT NULL,
	[SDT] [nchar](10) NOT NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuGiamGia]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuGiamGia](
	[MaGiamGia] [nchar](13) NOT NULL,
	[NoiDung] [nvarchar](30) NOT NULL,
	[TileGiam] [float] NOT NULL,
 CONSTRAINT [PK_PhieuGiamGia] PRIMARY KEY CLUSTERED 
(
	[MaGiamGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuNhap]    Script Date: 5/20/2022 12:53:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuNhap](
	[MaPhieuNhap] [nchar](13) NOT NULL,
	[MaNCC] [nchar](13) NOT NULL,
	[NgayNhap] [date] NOT NULL,
 CONSTRAINT [PK__PhieuNha__1470EF3BE0071BAA] PRIMARY KEY CLUSTERED 
(
	[MaPhieuNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[CaLamViec] ([MaCa], [TenCa], [thoiGian]) VALUES (N'FU1          ', N'Fulltime sáng', N'6:00 - 14:00')
INSERT [dbo].[CaLamViec] ([MaCa], [TenCa], [thoiGian]) VALUES (N'FU2          ', N'Fulltime chiều', N'14:00 - 22:00')
INSERT [dbo].[CaLamViec] ([MaCa], [TenCa], [thoiGian]) VALUES (N'PA1          ', N'Parttime sáng', N'8:00 - 14:00')
INSERT [dbo].[CaLamViec] ([MaCa], [TenCa], [thoiGian]) VALUES (N'PA2          ', N'Parttime', N'16:00 - 22:00')
GO
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'AD           ', N'Chủ nhà hàng')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'BP           ', N'Bếp phó')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'BT           ', N'Bếp trưởng')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'KTT          ', N'Kế toán trưởng')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'NVBH         ', N'Nhân viên bán hàng')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'NVBV         ', N'Nhân viên bảo vệ')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'NVGH         ', N'Nhân viên giao hàng')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'NVPV         ', N'Nhân viên phục vụ')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'PB           ', N'Phụ bếp')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'QLGS         ', N'Quản lí giám sát')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'QLK          ', N'Quản lí kho')
GO
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SDT]) VALUES (N'KH001        ', N'Trần Quang Long', N'0909029548')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SDT]) VALUES (N'KH002        ', N'Hồ Sĩ Minh', N'0202054922')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SDT]) VALUES (N'KH003        ', N'Quang Triệu', N'0202949882')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SDT]) VALUES (N'KH004        ', N'Nguyễn Quốc Siêu', N'0101092884')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SDT]) VALUES (N'KH005        ', N'Lâm Triệu Khánh', N'0202021938')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SDT]) VALUES (N'KH006        ', N'Quốc Triệu Phong', N'0902932149')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SDT]) VALUES (N'KH007        ', N'Nguyễn Lâm Chung', N'0021231234')
GO
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV001        ', N'FU1          ', N'AD           ', N'Trần Nguyên Lộc', N'079202034888', N'0707029548')
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV002        ', N'FU2          ', N'BP           ', N'Quang Ngọc Trinh', N'079202034889', N'0909029548')
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV003        ', N'FU1          ', N'BT           ', N'Nguyên Quân', N'079202034222', N'0101029488')
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV004        ', N'PA1          ', N'KTT          ', N'Quốc Ân', N'079202022222', N'0202054988')
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV005        ', N'PA2          ', N'NVBH         ', N'Quốc An', N'079202039999', N'0909029549')
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV006        ', N'FU1          ', N'NVBV         ', N'Hải Dương', N'079202034666', N'0909029542')
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV007        ', N'PA1          ', N'NVGH         ', N'Long An', N'079202034111', N'0909299542')
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV008        ', N'PA2          ', N'NVPV         ', N'Nguyễn Quang Triệu', N'079202034001', N'0909099284')
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV009        ', N'FU2          ', N'QLGS         ', N'Nguyên Tam Hoàng', N'079202022202', N'0101052988')
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV010        ', N'FU1          ', N'PB           ', N'Trần Thanh Long', N'079202078222', N'0606029548')
INSERT [dbo].[NhanVien] ([MaNV], [MaCa], [MaCV], [TenNV], [CMND], [SDT]) VALUES (N'NV011        ', N'FU2          ', N'QLK          ', N'Trần Quốc An Khánh', N'079202054888', N'0404029548')
GO
ALTER TABLE [dbo].[CheBien]  WITH CHECK ADD  CONSTRAINT [FK_CheBien_MonAn] FOREIGN KEY([MaMA])
REFERENCES [dbo].[MonAn] ([MaMA])
GO
ALTER TABLE [dbo].[CheBien] CHECK CONSTRAINT [FK_CheBien_MonAn]
GO
ALTER TABLE [dbo].[CheBien]  WITH CHECK ADD  CONSTRAINT [FK_CheBien_NguyenLieu] FOREIGN KEY([MANL])
REFERENCES [dbo].[NguyenLieu] ([MaNL])
GO
ALTER TABLE [dbo].[CheBien] CHECK CONSTRAINT [FK_CheBien_NguyenLieu]
GO
ALTER TABLE [dbo].[CTHD]  WITH CHECK ADD  CONSTRAINT [FK_CTHD_HoaDon] FOREIGN KEY([MaHD])
REFERENCES [dbo].[HoaDon] ([MaHD])
GO
ALTER TABLE [dbo].[CTHD] CHECK CONSTRAINT [FK_CTHD_HoaDon]
GO
ALTER TABLE [dbo].[CTHD]  WITH CHECK ADD  CONSTRAINT [FK_CTHD_MonAn] FOREIGN KEY([MaMA])
REFERENCES [dbo].[MonAn] ([MaMA])
GO
ALTER TABLE [dbo].[CTHD] CHECK CONSTRAINT [FK_CTHD_MonAn]
GO
ALTER TABLE [dbo].[CTPN]  WITH CHECK ADD  CONSTRAINT [FK_CTPN_NguyenLieu] FOREIGN KEY([MaNL])
REFERENCES [dbo].[NguyenLieu] ([MaNL])
GO
ALTER TABLE [dbo].[CTPN] CHECK CONSTRAINT [FK_CTPN_NguyenLieu]
GO
ALTER TABLE [dbo].[CTPN]  WITH CHECK ADD  CONSTRAINT [FK_CTPN_PN] FOREIGN KEY([MaPhieuNhap])
REFERENCES [dbo].[PhieuNhap] ([MaPhieuNhap])
GO
ALTER TABLE [dbo].[CTPN] CHECK CONSTRAINT [FK_CTPN_PN]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_KhachHang]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_NhanVien]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_PhieuGiamGia] FOREIGN KEY([MaGiamGia])
REFERENCES [dbo].[PhieuGiamGia] ([MaGiamGia])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_PhieuGiamGia]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_CaLamViec] FOREIGN KEY([MaCa])
REFERENCES [dbo].[CaLamViec] ([MaCa])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_CaLamViec]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_ChucVU] FOREIGN KEY([MaCV])
REFERENCES [dbo].[ChucVu] ([MaCV])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_ChucVU]
GO
ALTER TABLE [dbo].[PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_PhieuNhap_NhaCungCap] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[PhieuNhap] CHECK CONSTRAINT [FK_PhieuNhap_NhaCungCap]
GO
