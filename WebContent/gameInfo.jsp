<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin Game - Hệ Thống Thuê Game</title>
    <link rel="stylesheet" href="./styles/gameInfo.css">
</head>
<body>
    <aside class="sidebar">
        <h2>GameHub</h2>
        <ul class="nav-links">
            <li><a href="dashboard.jsp">Trang chủ</a></li>
            <li><a href="authorization?action=info" class="active">Tài khoản</a></li>
            <li><a href="games" class="active">Kho Game</a></li>
            <li><a href="userGames.jsp">Game đang thuê</a></li>
            <li><a href="#">Lịch sử giao dịch</a></li>
            <li><a href="authorization?action=logout">Đăng xuất</a></li>
        </ul>
    </aside>

    <main class="main-content">
        <h1 class="gameInfoTitle">THÔNG TIN TRÒ CHƠI</h1>
        
        <div class="gameInfoContainer">
            <img src="${dto.imageUrl}" alt="Ảnh bìa ${dto.title}" class="gameImage">
            
            <div class="gameDetails">
                <h2>${dto.title}</h2>
                <p><strong>Thể loại:</strong> ${dto.genre}</p>
                <p><strong>Ngày phát hành:</strong> ${dto.release}</p>
                <p><strong>Mô tả:</strong> ${dto.description}</p>
                <p class="price"><strong>Giá thuê:</strong> ${dto.hourlyRate} / Giờ</p>
                
                <button type="button" class="btn-rent-large">Thuê ngay</button>
            </div>
        </div>
    </main>
</body>
</html>