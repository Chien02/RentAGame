-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 14, 2026 lúc 06:00 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `rentagame`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `games`
--

CREATE TABLE `games` (
  `game_id` char(36) NOT NULL,
  `game_title` varchar(255) NOT NULL,
  `game_imageUrl` varchar(500) DEFAULT NULL,
  `game_genre` varchar(100) DEFAULT NULL,
  `game_developer` varchar(255) DEFAULT NULL,
  `game_releaseDate` date DEFAULT NULL,
  `game_description` text DEFAULT NULL,
  `game_hourlyRate` decimal(10,2) NOT NULL DEFAULT 0.00,
  `game_browserUrl` varchar(500) DEFAULT NULL,
  `game_status` enum('available','maintenance','unavailable') DEFAULT 'available',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `games`
--

INSERT INTO `games` (`game_id`, `game_title`, `game_imageUrl`, `game_genre`, `game_developer`, `game_releaseDate`, `game_description`, `game_hourlyRate`, `game_browserUrl`, `game_status`, `created_at`, `updated_at`) VALUES
('3ad1457f-1fbe-11f1-a6a6-a8934af61c9e', 'Hollow Knight', 'https://placehold.co/400x300/8b0000/FFF?text=Hollow+Knight', 'action', 'Team Cherry', '2017-02-24', 'Khám phá vương quốc côn trùng bị lãng quên dưới lòng đất, chiến đấu với quái vật và giải mã những bí ẩn cổ xưa.', 8000.00, 'https://v6p9d9t4.ssl.hwcdn.net/html/12345/index.html', 'available', '2026-03-14 22:55:31', '2026-03-14 23:53:05'),
('3ad15c2a-1fbe-11f1-a6a6-a8934af61c9e', 'Pokemon Scarlet (Web Emulator)', 'https://placehold.co/400x300/2E8B57/FFF?text=Pokemon+Scarlet', 'rpg', 'Game Freak', '2022-11-18', 'Bắt đầu cuộc phiêu lưu thế giới mở tại vùng Paldea, thu thập và huấn luyện các Pokemon thế hệ mới.', 6000.00, 'https://v6p9d9t4.ssl.hwcdn.net/html/12346/index.html', 'available', '2026-03-14 22:55:31', '2026-03-14 23:53:05'),
('3ad15d6d-1fbe-11f1-a6a6-a8934af61c9e', 'Stardew Valley', 'https://placehold.co/400x300/D2691E/FFF?text=Stardew+Valley', 'simulation', 'ConcernedApe', '2016-02-26', 'Thừa kế khu vườn cũ của ông nội, học cách trồng trọt, chăn nuôi và giao lưu với người dân thị trấn Pelican.', 5000.00, 'https://v6p9d9t4.ssl.hwcdn.net/html/12347/index.html', 'available', '2026-03-14 22:55:31', '2026-03-14 23:53:05'),
('3ad15dbe-1fbe-11f1-a6a6-a8934af61c9e', 'Celeste Classic', 'https://placehold.co/400x300/696969/FFF?text=Celeste+Classic', 'action', 'Maddy Thorson', '2015-07-21', 'Phiên bản web nguyên thủy của tựa game leo núi nổi tiếng. Thử thách kỹ năng nhảy và lướt qua các chướng ngại vật.', 3000.00, 'https://v6p9d9t4.ssl.hwcdn.net/html/12348/index.html', 'available', '2026-03-14 22:55:31', '2026-03-14 23:53:05'),
('3ad15e04-1fbe-11f1-a6a6-a8934af61c9e', 'Wuthering Waves (Cloud Edition)', 'https://placehold.co/400x300/4B0082/FFF?text=Wuthering+Waves', 'rpg', 'Kuro Games', '2024-05-22', 'Tỉnh dậy sau giấc ngủ dài, bạn trở thành Rover trong một thế giới hậu tận thế đầy rẫy những sinh vật bí ẩn và công nghệ cổ đại. Trải nghiệm mượt mà qua nền tảng Cloud.', 12000.00, 'https://v6p9d9t4.ssl.hwcdn.net/html/12349/index.html', 'available', '2026-03-14 22:55:31', '2026-03-14 23:53:05'),
('3ad15e5b-1fbe-11f1-a6a6-a8934af61c9e', 'Arknights: Endfield (Web Demo)', 'https://placehold.co/400x300/000000/FFF?text=Arknights:+Endfield', 'strategy', 'Hypergryph', '2025-05-01', 'Khám phá hành tinh Talos-II nguy hiểm. Xây dựng căn cứ, tự động hóa dây chuyền sản xuất và chỉ huy đội hình chiến đấu trong thời gian thực.', 15000.00, 'https://v6p9d9t4.ssl.hwcdn.net/html/12350/index.html', 'available', '2026-03-14 22:55:31', '2026-03-14 23:53:05'),
('3ad15edf-1fbe-11f1-a6a6-a8934af61c9e', 'Vampire Survivors', 'https://placehold.co/400x300/2F4F4F/FFF?text=Vampire+Survivors', 'action', 'poncle', '2021-12-17', 'Chống lại hàng ngàn sinh vật bóng tối cho đến lúc bình minh. Lối chơi tối giản nhưng cực kỳ gây nghiện.', 4000.00, 'https://v6p9d9t4.ssl.hwcdn.net/html/12351/index.html', 'available', '2026-03-14 22:55:31', '2026-03-14 23:53:05'),
('3ad16e06-1fbe-11f1-a6a6-a8934af61c9e', 'Friday Night Funkin', 'https://placehold.co/400x300/FF1493/FFF?text=Friday+Night+Funkin', 'action', 'The Funkin Crew', '2020-10-05', 'Đấu rap với vô số đối thủ kỳ lạ để giành lấy trái tim của Girlfriend. Bấm phím đúng nhịp và đừng để thanh máu cạn kiệt.', 2500.00, 'https://v6p9d9t4.ssl.hwcdn.net/html/12352/index.html', 'available', '2026-03-14 22:55:31', '2026-03-14 23:53:05'),
('3ad16f15-1fbe-11f1-a6a6-a8934af61c9e', 'Krunker.io', 'https://placehold.co/400x300/B22222/FFF?text=Krunker.io', 'action', 'Yendis Entertainment', '2018-05-20', 'Game bắn súng góc nhìn thứ nhất với đồ họa khối vuông cực nhẹ, chơi mượt mà ngay trên trình duyệt mà không cần cài đặt.', 0.00, 'https://v6p9d9t4.ssl.hwcdn.net/html/12353/index.html', 'available', '2026-03-14 22:55:31', '2026-03-14 23:53:05'),
('3ad16f63-1fbe-11f1-a6a6-a8934af61c9e', 'League of Legends (TFT Web Client)', 'https://placehold.co/400x300/000080/FFF?text=TFT+Web+Client', 'strategy', 'Riot Games', '2019-06-26', 'Trải nghiệm chế độ Đấu Trường Chân Lý của LMHT trực tiếp trên trình duyệt. Sắp xếp đội hình, kết hợp tộc hệ và giành top 1.', 7000.00, 'https://v6p9d9t4.ssl.hwcdn.net/html/12354/index.html', 'available', '2026-03-14 22:55:31', '2026-03-14 23:53:05');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`game_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
