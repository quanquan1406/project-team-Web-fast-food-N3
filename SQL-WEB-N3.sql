create database Web_nhom3;
use Web_nhom3;

CREATE TABLE `KHACH_HANG` (
  `ID_KH` varchar(255) NOT NULL,
  `HO_TEN` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `SDT` varchar(15) DEFAULT NULL,
  `DIA_CHI` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `TAI_KHOAN` varchar(50) DEFAULT NULL,
  `MAT_KHAU` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_KH`),
  UNIQUE KEY `TAI_KHOAN` (`TAI_KHOAN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `TIN_TUC` (
  `ID_TINTUC` varchar(255) NOT NULL,
  `NOI_DUNG` text,
  `ANH` varchar(255) DEFAULT NULL,
  `TIEU_DE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `NGAY_DANG` date DEFAULT NULL,
  PRIMARY KEY (`ID_TINTUC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ADMIN` (
  `ID_ADMIN` varchar(255) NOT NULL,
  `ID_TINTUC` varchar(255) DEFAULT NULL,
  `ID_KH` varchar(255) DEFAULT NULL,
  `HO_TEN` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `DIA_CHI` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `SDT` varchar(15) DEFAULT NULL,
  `TAI_KHOAN` varchar(50) DEFAULT NULL,
  `MAT_KHAU` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_ADMIN`),
  UNIQUE KEY `TAI_KHOAN` (`TAI_KHOAN`),
  KEY `ID_TINTUC` (`ID_TINTUC`),
  KEY `ID_KH` (`ID_KH`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`ID_TINTUC`) REFERENCES `TIN_TUC` (`ID_TINTUC`),
  CONSTRAINT `admin_ibfk_2` FOREIGN KEY (`ID_KH`) REFERENCES `KHACH_HANG` (`ID_KH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `NHANVIEN_GIAOHANG` (
  `ID_NVGH` varchar(255) NOT NULL,
  `HO_TEN` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `SDT_NV` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ID_NVGH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `HOA_DON` (
  `ID_HOADON` varchar(255) NOT NULL,
  `ID_NVGH` varchar(255) DEFAULT NULL,
  `SOLUONG_SP` int DEFAULT NULL,
  `SOTIEN_PHAITRA` float DEFAULT NULL,
  `TRANG_THAI` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID_HOADON`),
  KEY `ID_NVGH` (`ID_NVGH`),
  CONSTRAINT `hoa_don_ibfk_1` FOREIGN KEY (`ID_NVGH`) REFERENCES `NHANVIEN_GIAOHANG` (`ID_NVGH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `SAN_PHAM` (
  `ID_SP` varchar(255) NOT NULL,
  `TEN_SP` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `GIA_TIEN` float DEFAULT NULL,
  
`MO_TA` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ANH` varchar(225) DEFAULT NULL,
  `LOAI_SP` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_SP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `DAT_HANG` (
  `ID_DH` varchar(255) NOT NULL,
  `ID_KH` varchar(255) DEFAULT NULL,
  `ID_HOADON` varchar(255) DEFAULT NULL,
  `ID_SP` varchar(255) DEFAULT NULL,
  `THANH_TOAN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `THOIGIAN_DAT` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_DH`),
  KEY `ID_KH` (`ID_KH`),
  KEY `ID_HOADON` (`ID_HOADON`),
  KEY `ID_SP` (`ID_SP`),
  CONSTRAINT `dat_hang_ibfk_1` FOREIGN KEY (`ID_KH`) REFERENCES `KHACH_HANG` (`ID_KH`),
  CONSTRAINT `dat_hang_ibfk_2` FOREIGN KEY (`ID_HOADON`) REFERENCES `HOA_DON` (`ID_HOADON`),
  CONSTRAINT `dat_hang_ibfk_3` FOREIGN KEY (`ID_SP`) REFERENCES `SAN_PHAM` (`ID_SP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `KHACH_HANG` (`ID_KH`, `HO_TEN`, `SDT`, `DIA_CHI`, `TAI_KHOAN`, `MAT_KHAU`) VALUES
('KH001', 'Nguyen Van A', '0909123456', '123 Le Loi, Q1, TP.HCM', 'KH', '1'),
('KH002', 'Tran Thi B', '0911222333', '456 Hai Ba Trung, Q3, TP.HCM', 'tranthib', 'password2'),
('KH003', 'Le Hoang C', '0922233444', '789 Nguyen Hue, Q1, TP.HCM', 'lehoangc', 'password3'),
('KH004', 'Pham Van D', '0933344555', '321 Tran Hung Dao, Q5, TP.HCM', 'phamvand', 'password4'),
('KH005', 'Hoang Thi E', '0944455666', '654 Phan Xich Long, Q.PN, TP.HCM', 'hoangthie', 'password5');

INSERT INTO `TIN_TUC` (`ID_TINTUC`, `NOI_DUNG`, `ANH`, `TIEU_DE`, `NGAY_DANG`) VALUES
('TT001', 'Chương trình khuyến mãi Tết 2024 với nhiều ưu đãi hấp dẫn. Các sản phẩm trong menu sẽ được giảm giá đến 10%, kèm theo quà tặng độc đáo khi mua combo.', './assets/img/menu/garan1.jpg', 'Ưu đãi lớn mừng Tết 2024', '2024-12-01'),
('TT002', 'Hân hoan chào đón món mới! Các tín đồ ẩm thực đừng bỏ lỡ cơ hội thử ngay sản phẩm đặc biệt với hương vị mới lạ và ưu đãi hấp dẫn.', './assets/img/menu/my_tuong_den.jpg', 'Ra mắt sản phẩm mới kèm ưu đãi', '2024-12-05'),
('TT003', 'Đón Giáng Sinh ấm áp với chương trình "Mua 2 tặng 1". Đặc biệt áp dụng cho các dòng sản phẩm gà rán và burger trong thời gian có hạn.', './assets/img/menu/garan2.jpg', 'Khuyến mãi đặc biệt mùa Giáng Sinh', '2024-12-10'),
('TT004', 'Mừng năm mới 2024, giảm ngay 15% cho tất cả các combo nhóm. Hãy cùng bạn bè và gia đình thưởng thức bữa tiệc ấm cúng với giá cực ưu đãi.', './assets/img/menu/garan3.jpg', 'Ưu đãi đầu năm mới', '2024-12-20');



INSERT INTO `ADMIN` (`ID_ADMIN`, `ID_TINTUC`, `ID_KH`, `HO_TEN`, `DIA_CHI`, `SDT`, `TAI_KHOAN`, `MAT_KHAU`) VALUES
('AD001', NULL, NULL, 'Admin A', '456 Dien Bien Phu, Q10, TP.HCM', '0901112222', 'admin', '1');


-- Thêm dữ liệu cho NHANVIEN_GIAOHANG
INSERT INTO `NHANVIEN_GIAOHANG` (`ID_NVGH`, `HO_TEN`, `SDT_NV`) VALUES
('NVGH001', 'Nguyễn Thành P', '0901122334'),
('NVGH002', 'Trần Hoàng Q', '0988776655'),
('NVGH003', 'Phạm Minh R', '0977665544');

-- Thêm dữ liệu cho HOA_DON
INSERT INTO `HOA_DON` (`ID_HOADON`, `ID_NVGH`, `SOLUONG_SP`, `SOTIEN_PHAITRA`, `TRANG_THAI`) VALUES
('HD001', 'NVGH001', 3, 750000, 'Đã giao'),
('HD002', 'NVGH001', 2, 500000, 'Đã giao'),
('HD003', 'NVGH001', 5, 1250000, 'Đã giao'),
('HD004', 'NVGH001', 1, 250000, 'Đã giao'),
('HD005', 'NVGH001', 4, 1000000, 'Đã giao'),
('HD006', 'NVGH001', 1, 250000, 'Đã giao'),
('HD007', 'NVGH001', 6, 1500000, 'Đã giao'),
('HD008', 'NVGH001', 2, 500000, 'Đã giao'),
('HD009', 'NVGH001', 3, 750000, 'Đã giao'),
('HD010', 'NVGH001', 2, 500000, 'Đã giao'),
('HD011', 'NVGH001', 5, 1250000, 'Đã giao'),
('HD012', 'NVGH001', 1, 250000, 'Đã giao'),
('HD013', 'NVGH001', 4, 1000000, 'Đã giao'),
('HD014', 'NVGH001', 1, 250000, 'Đã giao'),
('HD015', 'NVGH001', 6, 1500000, 'Đã giao'),
('HD016', 'NVGH001', 2, 500000, 'Đã giao'),
('HD017', 'NVGH001', 3, 750000, 'Đã giao'),
('HD018', 'NVGH001', 2, 500000, 'Đã giao'),
('HD019', 'NVGH001', 5, 1250000, 'Đã giao'),
('HD020', 'NVGH001', 1, 250000, 'Đã giao'),
('HD021', 'NVGH001', 4, 1000000, 'Đã giao'),
('HD022', 'NVGH001', 1, 250000, 'Đã giao'),
('HD023', 'NVGH001', 3, 750000, 'Đã giao'),
('HD024', 'NVGH001', 2, 500000, 'Đã giao'),
('HD025', 'NVGH001', 5, 1250000, 'Đã giao'),
('HD026', 'NVGH001', 1, 250000, 'Đã giao'),
('HD027', 'NVGH001', 6, 1500000, 'Đã giao'),
('HD028', 'NVGH001', 2, 500000, 'Đã giao'),
('HD029', 'NVGH001', 4, 1000000, 'Đã giao'),
('HD030', 'NVGH001', 3, 750000, 'Đã giao'),
('HD031', 'NVGH001', 5, 1250000, 'Đã giao'),
('HD032', 'NVGH001', 1, 250000, 'Đã giao'),
('HD033', 'NVGH001', 2, 500000, 'Đã giao'),
('HD034', 'NVGH001', 3, 750000, 'Đã giao'),
('HD035', 'NVGH001', 4, 1000000, 'Đã giao'),
('HD036', 'NVGH001', 2, 500000, 'Đã giao'),
('HD037', 'NVGH001', 1, 250000, 'Đã giao'),
('HD038', 'NVGH001', 6, 1500000, 'Đã giao'),
('HD039', 'NVGH001', 2, 500000, 'Đã giao'),
('HD040', 'NVGH001', 5, 1250000, 'Đã giao'),
('HD041', 'NVGH001', 3, 750000, 'Đã giao'),
('HD042', 'NVGH001', 4, 1000000, 'Đã giao'),
('HD043', 'NVGH001', 1, 250000, 'Đã giao'),
('HD044', 'NVGH001', 2, 500000, 'Đã giao'),
('HD045', 'NVGH001', 6, 1500000, 'Đã giao'),
('HD046', 'NVGH001', 3, 750000, 'Đã giao'),
('HD047', 'NVGH001', 4, 1000000, 'Đã giao'),
('HD048', 'NVGH001', 1, 250000, 'Đã giao'),
('HD049', 'NVGH001', 5, 1250000, 'Đã giao'),
('HD050', 'NVGH001', 2, 500000, 'Đã giao');


INSERT INTO `SAN_PHAM` (`ID_SP`, `TEN_SP`, `GIA_TIEN`, `MO_TA`, `ANH`, `LOAI_SP`) VALUES
('SP001', 'Gà rán thường', 59000, 'Gà rán vàng giòn, đậm đà hương vị truyền thống', './assets/img/menu/garan0.jpg', 'Gà Rán'),
('SP002', 'Gà cay phô mai', 150000, 'Thịt gà mềm, cay nồng hòa quyện phô mai béo ngậy', './assets/img/menu/ga_cay_pho_mai.jpg', 'Gà Rán'),
('SP003', 'Gà sốt me', 99000, 'Gà sốt chua ngọt, thơm lừng vị me tự nhiên', './assets/img/menu/ga_sot_me.jpg', 'Gà Rán'),
('SP004', 'Gà sốt tiêu', 139000, 'Gà sốt cay nhẹ, thơm lừng hạt tiêu', './assets/img/menu/ga_sot_tieu.jpg', 'Gà Rán'),
('SP005', 'Gà viên chiên', 30000, 'Gà viên giòn rụm, nhỏ gọn dễ thưởng thức', './assets/img/menu/ga_vien_chien.jpg', 'Gà Rán'),
('SP006', 'Burger Bò', 39000, 'Bánh burger bò mềm thơm, vị đậm đà', './assets/img/menu/burger_bo.jpg', 'Burger'),
('SP007', 'Burger Gà', 49000, 'Burger gà giòn rụm, sốt hấp dẫn', './assets/img/menu/burger_ga.jpg', 'Burger'),
('SP008', 'Burger Tôm', 59000, 'Burger tôm dai ngon, sốt đậm vị', './assets/img/menu/burger_tom.jpg', 'Burger'),
('SP009', 'Mỳ cay', 50000, 'Mỳ cay nồng, hương vị cuốn hút', './assets/img/menu/my_cay.jpg', 'Mỳ'),
('SP010', 'Mỳ trộn', 39000, 'Mỳ trộn đậm đà, nguyên liệu tươi ngon', './assets/img/menu/my_tron.jpg', 'Mỳ'),
('SP011', 'Mỳ tương đen', 50000, 'Mỳ tương đen đậm chất Hàn Quốc', './assets/img/menu/my_tuong_den.jpg', 'Mỳ'),
('SP012', 'Combo Nhóm cho 2 người', 200000, 'Bữa ăn ngon miệng dành cho 2 người', './assets/img/menu/R.jpg', 'Combo Nhóm'),
('SP013', 'Combo Nhóm cho 3 người', 300000, 'Set ăn đa dạng, lý tưởng cho 3 người', './assets/img/menu/3nguoi.jpg', 'Combo Nhóm'),
('SP014', 'Combo Nhóm cho 4 người', 400000, 'Bữa ăn thịnh soạn, lý tưởng cho 4 người', './assets/img/menu/4nguoi.jpg', 'Combo Nhóm'),
('SP015', 'Combo Nhóm cho 5 người', 500000, 'Set ăn đủ đầy dành cho nhóm 5 người', './assets/img/menu/5nguoi.jpg', 'Combo Nhóm'),
('SP016', 'Combo Nhóm cho 6 người', 600000, 'Bữa tiệc hấp dẫn cho 6 người', './assets/img/menu/6nguoi.jpg', 'Combo Nhóm'),
('SP017', 'Kem Vani', 25000, 'Kem vani mát lạnh, hương vị truyền thống', './assets/img/menu/kem_vani.jpg', 'Tráng Miệng'),
('SP018', 'Sữa chua hoa quả', 25000, 'Sữa chua ngọt dịu, hòa quyện vị hoa quả', './assets/img/menu/sua_chua_hoa_qua.jpg', 'Tráng Miệng'),
('SP019', 'Bánh Kếp', 35000, 'Bánh kẹp mềm mịn, thơm lừng, ngọt ngào', './assets/img/menu/trangmieng2.jpg', 'Tráng Miệng'),
('SP020', 'Trà hoa quả', 20000, 'Trà tươi mát, vị hoa quả tự nhiên', './assets/img/menu/tra_hoa_qua.jpg', 'Tráng Miệng');



INSERT INTO `DAT_HANG` (`ID_DH`, `ID_KH`, `ID_HOADON`, `ID_SP`, `THANH_TOAN`, `THOIGIAN_DAT`) VALUES
('DH032', 'KH001', 'HD032', 'SP020', 'Tiền Mặt', '2024-09-01 10:00:00'),
('DH033', 'KH002', 'HD033', 'SP006', 'Tiền mặt', '2024-09-02 11:00:00'),
('DH034', 'KH003', 'HD034', 'SP004', 'Chuyển khoản', '2024-09-03 12:00:00'),
('DH035', 'KH004', 'HD035', 'SP009', 'Tiền mặt', '2024-09-04 13:00:00'),
('DH036', 'KH001', 'HD036', 'SP009', 'Tiền Mặt', '2024-09-05 14:00:00'),
('DH037', 'KH002', 'HD037', 'SP001', 'Tiền mặt', '2024-09-06 15:00:00'),
('DH038', 'KH003', 'HD038', 'SP001', 'Chuyển khoản', '2024-09-07 16:00:00'),
('DH039', 'KH004', 'HD039', 'SP001', 'Tiền mặt', '2024-09-08 17:00:00'),
('DH040', 'KH001', 'HD040', 'SP002', 'Tiền Mặt', '2024-09-09 18:00:00'),
('DH041', 'KH002', 'HD041', 'SP002', 'Chuyển khoản', '2024-09-10 10:00:00'),
('DH042', 'KH003', 'HD042', 'SP002', 'Tiền mặt', '2024-09-11 11:00:00'),
('DH043', 'KH004', 'HD043', 'SP004', 'Tiền mặt', '2024-09-12 12:00:00'),
('DH044', 'KH001', 'HD044', 'SP003', 'Tiền Mặt', '2024-09-13 13:00:00'),
('DH045', 'KH002', 'HD045', 'SP003', 'Tiền mặt', '2024-09-14 14:00:00'),
('DH046', 'KH003', 'HD046', 'SP009', 'Chuyển khoản', '2024-09-15 15:00:00'),
('DH047', 'KH004', 'HD047', 'SP007', 'Tiền mặt', '2024-09-16 16:00:00'),
('DH048', 'KH001', 'HD048', 'SP007', 'Tiền Mặt', '2024-09-17 17:00:00'),
('DH049', 'KH002', 'HD049', 'SP007', 'Chuyển khoản', '2024-09-18 18:00:00'),
('DH050', 'KH003', 'HD050', 'SP007', 'Tiền mặt', '2024-09-19 10:00:00'),
('DH031', 'KH004', 'HD031', 'SP008', 'Tiền mặt', '2024-09-20 11:00:00'),
('DH024', 'KH001', 'HD024', 'SP020', 'Tiền Mặt', '2024-09-24 12:00:00'),
('DH025', 'KH002', 'HD025', 'SP019', 'Tiền mặt', '2024-09-25 13:00:00'),
('DH026', 'KH003', 'HD026', 'SP019', 'Chuyển khoản', '2024-09-26 14:00:00'),
('DH027', 'KH004', 'HD027', 'SP019', 'Tiền mặt', '2024-09-27 15:00:00'),
('DH028', 'KH001', 'HD028', 'SP019', 'Tiền Mặt', '2024-09-28 16:00:00'),
('DH029', 'KH002', 'HD029', 'SP018', 'Tiền mặt', '2024-09-29 17:00:00'),
('DH030', 'KH003', 'HD030', 'SP008', 'Chuyển khoản', '2024-09-30 18:00:00'),
('DH014', 'KH003', 'HD014', 'SP014', 'Tiền Mặt', '2024-10-14 10:00:00'),
('DH015', 'KH004', 'HD015', 'SP015', 'Tiền Mặt', '2024-10-15 11:00:00'),
('DH016', 'KH001', 'HD016', 'SP016', 'Tiền Mặt', '2024-10-16 12:00:00'),
('DH017', 'KH002', 'HD017', 'SP017', 'Tiền mặt', '2024-10-17 13:00:00'),
('DH018', 'KH003', 'HD018', 'SP018', 'Tiền Mặt', '2024-10-18 14:00:00'),
('DH019', 'KH004', 'HD019', 'SP019', 'Tiền Mặt', '2024-10-19 15:00:00'),
('DH020', 'KH001', 'HD020', 'SP020', 'Chuyển khoản', '2024-10-20 16:00:00'),
('DH021', 'KH002', 'HD021', 'SP001', 'Tiền mặt', '2024-10-21 17:00:00'),
('DH022', 'KH003', 'HD022', 'SP020', 'Tiền Mặt', '2024-10-22 18:00:00'),
('DH023', 'KH004', 'HD023', 'SP001', 'Chuyển khoản', '2024-10-23 10:00:00'),
('DH001', 'KH001', 'HD001', 'SP001', 'Tiền Mặt', '2024-11-01 12:00:00'),
('DH002', 'KH002', 'HD002', 'SP001', 'Chuyển Khoản', '2024-11-02 13:00:00'),
('DH003', 'KH003', 'HD003', 'SP004', 'Tiền Mặt', '2024-11-03 14:00:00'),
('DH004', 'KH004', 'HD004', 'SP001', 'Tiền Mặt', '2024-11-04 15:00:00'),
('DH005', 'KH002', 'HD005', 'SP005', 'Tiền mặt', '2024-11-05 16:00:00'),
('DH006', 'KH003', 'HD006', 'SP001', 'Tiền Mặt', '2024-11-06 17:00:00'),
('DH007', 'KH004', 'HD007', 'SP007', 'Tiền Mặt', '2024-11-07 18:00:00'),
('DH008', 'KH001', 'HD008', 'SP008', 'Tiền Mặt', '2024-11-08 10:00:00'),
('DH009', 'KH002', 'HD009', 'SP009', 'Tiền mặt', '2024-12-09 11:00:00'),
('DH010', 'KH003', 'HD010', 'SP010', 'Tiền Mặt', '2024-12-10 12:00:00'),
('DH011', 'KH004', 'HD011', 'SP011', 'Tiền Mặt', '2024-12-11 13:00:00'),
('DH012', 'KH001', 'HD012', 'SP012', 'Chuyển khoản', '2024-12-12 14:00:00'),
('DH013', 'KH002', 'HD013', 'SP013', 'Tiền mặt', '2024-12-13 15:00:00');




