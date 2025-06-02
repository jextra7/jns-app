-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for db_ekspedisi
CREATE DATABASE IF NOT EXISTS `db_ekspedisi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_ekspedisi`;

-- Dumping structure for table db_ekspedisi.admin
CREATE TABLE IF NOT EXISTS `admin` (
  `id_admin` varchar(10) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `level` enum('Admin','Operator','Staff') NOT NULL,
  `aktif` enum('Ya','Tidak') DEFAULT 'Ya',
  PRIMARY KEY (`id_admin`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_ekspedisi.admin: ~4 rows (approximately)
REPLACE INTO `admin` (`id_admin`, `username`, `password`, `nama`, `level`, `aktif`) VALUES
	('ADM001', 'admin', '0192023a7bbd73250516f069df18b500', 'Administrator', 'Admin', 'Ya'),
	('ADM002', 'admin2', 'admin111', 'Administrator2', 'Admin', 'Ya'),
	('OPR001', 'operator', '2407bd807d6ca01d1bcd766c730cec9a', 'Operator', 'Operator', 'Ya'),
	('STF001', 'staff', 'de9bf5643eabf80f4a56fda3bbb84483', 'Staff', 'Staff', 'Ya');

-- Dumping structure for table db_ekspedisi.gudang
CREATE TABLE IF NOT EXISTS `gudang` (
  `id_gudang` varchar(20) NOT NULL,
  `nama_gudang` varchar(100) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `kapasitas` int NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id_gudang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_ekspedisi.gudang: ~1 rows (approximately)
REPLACE INTO `gudang` (`id_gudang`, `nama_gudang`, `alamat`, `kapasitas`, `status`) VALUES
	('100', 'cabang banjarmasin tengah', 'banjarmasin tengah', 200, 'Aktif');

-- Dumping structure for table db_ekspedisi.kurir
CREATE TABLE IF NOT EXISTS `kurir` (
  `id_kurir` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_telp` varchar(20) NOT NULL,
  `jenis_kelamin` varchar(15) NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id_kurir`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_ekspedisi.kurir: ~1 rows (approximately)
REPLACE INTO `kurir` (`id_kurir`, `nama`, `alamat`, `no_telp`, `jenis_kelamin`, `status`) VALUES
	('100', 'Nazmi', 'Jl Kelayan b', '089999', 'Laki-laki', 'Aktif');

-- Dumping structure for table db_ekspedisi.paket
CREATE TABLE IF NOT EXISTS `paket` (
  `no_paket` varchar(16) NOT NULL,
  `nama_pengirim` varchar(100) NOT NULL,
  `alamat_pengirim` varchar(255) NOT NULL,
  `nama_penerima` varchar(100) NOT NULL,
  `alamat_penerima` varchar(255) NOT NULL,
  `jenis_paket` varchar(20) NOT NULL,
  `berat` float NOT NULL,
  `tanggal_kirim` date NOT NULL,
  `biaya` decimal(10,2) NOT NULL,
  `id_pelanggan` varchar(20) DEFAULT NULL,
  `id_kurir` varchar(20) DEFAULT NULL,
  `id_gudang` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_paket`),
  KEY `fk_paket_pelanggan` (`id_pelanggan`),
  KEY `fk_paket_kurir` (`id_kurir`),
  KEY `fk_paket_gudang` (`id_gudang`),
  CONSTRAINT `fk_paket_gudang` FOREIGN KEY (`id_gudang`) REFERENCES `gudang` (`id_gudang`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_paket_kurir` FOREIGN KEY (`id_kurir`) REFERENCES `kurir` (`id_kurir`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_paket_pelanggan` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_ekspedisi.paket: ~2 rows (approximately)
REPLACE INTO `paket` (`no_paket`, `nama_pengirim`, `alamat_pengirim`, `nama_penerima`, `alamat_penerima`, `jenis_paket`, `berat`, `tanggal_kirim`, `biaya`, `id_pelanggan`, `id_kurir`, `id_gudang`) VALUES
	('202505300001', 'Fathur', 'Gambut', 'Jumberi', 'kelayan', 'Reguler', 1, '2025-05-30', 30000.00, '100', '100', '100'),
	('202506020001', 'Salim', 'Banjarbaru', 'Nazmi', 'Kelayan Z', 'Express', 0, '2025-06-02', 20000.00, '100', '100', '100');

-- Dumping structure for table db_ekspedisi.pelanggan
CREATE TABLE IF NOT EXISTS `pelanggan` (
  `id_pelanggan` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_telp` varchar(20) DEFAULT NULL,
  `jenis_kelamin` varchar(15) NOT NULL,
  PRIMARY KEY (`id_pelanggan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_ekspedisi.pelanggan: ~1 rows (approximately)
REPLACE INTO `pelanggan` (`id_pelanggan`, `nama`, `alamat`, `no_telp`, `jenis_kelamin`) VALUES
	('100', 'Fathur', 'Gambut', '0897', 'Laki-laki');

-- Dumping structure for table db_ekspedisi.pembayaran
CREATE TABLE IF NOT EXISTS `pembayaran` (
  `id_pembayaran` varchar(20) NOT NULL,
  `no_paket` varchar(16) NOT NULL,
  `metode_pembayaran` varchar(20) NOT NULL,
  `tanggal_pembayaran` date NOT NULL,
  `jumlah_bayar` decimal(10,2) NOT NULL,
  `status_pembayaran` varchar(20) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_pembayaran`),
  KEY `fk_pembayaran_paket` (`no_paket`),
  CONSTRAINT `fk_pembayaran_paket` FOREIGN KEY (`no_paket`) REFERENCES `paket` (`no_paket`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_ekspedisi.pembayaran: ~1 rows (approximately)
REPLACE INTO `pembayaran` (`id_pembayaran`, `no_paket`, `metode_pembayaran`, `tanggal_pembayaran`, `jumlah_bayar`, `status_pembayaran`, `keterangan`) VALUES
	('1000', '202505300001', 'Tunai', '2025-05-30', 30000.00, 'Lunas', '');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
