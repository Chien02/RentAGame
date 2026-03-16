-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 16, 2026 at 08:07 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rentagame`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(36) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role`, `created_at`) VALUES
('6b64aa4b-a21d-453e-9384-b2ab3bdfc71a', 'chien02', 'chien02@gmail.com', '$2a$10$LW0QiTus91iodVNhLhrOpOgkEq5pFvBr7u.QAYDeGP/jFSytsosb6', 'CUSTOMER', '2026-03-16 18:54:10'),
('96f3497e-e1a4-437a-bfd7-a524ed0e0de9', 'chien', 'test@gmail.com', '$2a$10$a9aEAbVYkEB3rUjrGvw7aO8R5/OS3LuXlWvBGwykXW4e9X85ckzU2', 'CUSTOMER', '2026-03-16 18:33:18'),
('u0000000-0000-0000-0000-000000000000', 'zero', 'player0@gmail.com', '$2a$10$pT6U5S4z6Q3P8X.Z.K.L.O4j1R9X5o.Y/2QjA1X9o/Y.2QjA1X', 'ADMIN', '2026-03-16 16:47:47'),
('u1111111-1111-1111-1111-111111111111', 'player_one', 'player1@gmail.com', 'hashed_pwd_123', 'CUSTOMER', '2026-03-16 16:47:47'),
('u2222222-2222-2222-2222-222222222222', 'pro_gamer', 'progamer@gmail.com', 'hashed_pwd_456', 'CUSTOMER', '2026-03-16 16:47:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
