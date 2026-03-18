<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Hệ Thống Thuê Game</title>
    <link rel="stylesheet" href="styles/dashboard.css">
</head>
<body>

    <aside class="sidebar">
        <h2>GameHub</h2>
        <ul class="nav-links">
            <li><a href="#" class="active">Trang chủ</a></li>
            <li><a href="userInfo.jsp">Tài khoản</a></li>
            <li><a href="games?action=search">Kho Game</a></li>
            <li><a href="userGames.jsp">Game đang thuê</a></li>
            <li><a href="#">Lịch sử giao dịch</a></li>
        </ul>
    </aside>

    <main class="main-content">
        
        <section class="banner">
            <h1>Hollow Knight - Web Edition</h1>
            <p>Khám phá vương quốc côn trùng bị lãng quên ngay trên trình duyệt của bạn. Tựa game đang được thuê nhiều nhất tuần qua!</p>
            <a href="/game-info.jsp?id=123" class="btn-play-now">Xem chi tiết</a>
        </section>

        <h2 class="section-title">Khám phá trò chơi</h2>
        <div class="game-grid">
            
            <div class="game-card">
                <div class="game-thumbnail"></div> 
                <div class="game-info">
                    <h3 class="game-title">Super Mario Bros</h3>
                    <span class="game-price">5.000đ / Giờ</span>
                    <a href="#" class="btn-rent">Thuê ngay</a>
                </div>
            </div>

            <div class="game-card">
                <div class="game-thumbnail"></div>
                <div class="game-info">
                    <h3 class="game-title">Celeste Classic</h3>
                    <span class="game-price">4.000đ / Giờ</span>
                    <a href="#" class="btn-rent">Thuê ngay</a>
                </div>
            </div>

            <div class="game-card">
                <div class="game-thumbnail"></div>
                <div class="game-info">
                    <h3 class="game-title">Flappy Bird Cổ điển</h3>
                    <span class="game-price">2.000đ / Giờ</span>
                    <a href="#" class="btn-rent">Thuê ngay</a>
                </div>
            </div>
            
            <div class="game-card">
                <div class="game-thumbnail"></div>
                <div class="game-info">
                    <h3 class="game-title">Pokemon Showdown</h3>
                    <span class="game-price">6.000đ / Giờ</span>
                    <a href="#" class="btn-rent">Thuê ngay</a>
                </div>
            </div>

            </div>
    </main>

</body>
</html>