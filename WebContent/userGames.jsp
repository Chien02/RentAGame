<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Game Đang Thuê - Hệ Thống Thuê Game</title>
    <link rel="stylesheet" href="styles/userGames.css">
</head>
<body>

    <aside class="sidebar">
        <h2>GameHub</h2>
        <ul class="nav-links">
            <li><a href="dashboard.jsp">Trang chủ</a></li>
            <li><a href="userInfo.jsp">Tài khoản</a></li>
            <li><a href="games?action=search">Kho Game</a></li>
            <li><a href="userGames.jsp" class="active">Game đang thuê</a></li>
            <li><a href="#">Lịch sử giao dịch</a></li>
        </ul>
    </aside>

    <main class="main-content">
        
        <div class="page-header">
            <h1>Game Đang Thuê</h1>
            <p>Quản lý các trò chơi bạn đã thuê và tiếp tục chơi bất cứ lúc nào.</p>
        </div>

        <div class="rented-list">
            
            <div class="rented-item status-active">
                <div class="item-thumbnail" style="background-color: #8b0000;"></div>
                <div class="item-info">
                    <h3 class="item-title">Hollow Knight</h3>
                    <div class="time-badge time-active">⏳ Còn 01:45:30</div>
                    <span class="item-details">Thuê lúc: 14/03/2026 08:00 | Mã phiên: RNT-9821</span>
                </div>
                <div class="item-actions">
                    <a href="/play.jsp?rentalId=RNT-9821" class="btn btn-play">▶ Chơi tiếp</a>
                </div>
            </div>

            <div class="rented-item status-active">
                <div class="item-thumbnail" style="background-color: #4682B4;"></div>
                <div class="item-info">
                    <h3 class="item-title">Cobblemon Modpack</h3>
                    <div class="time-badge time-active">⏳ Còn 00:20:15</div>
                    <span class="item-details">Thuê lúc: 13/03/2026 20:15 | Mã phiên: RNT-7534</span>
                </div>
                <div class="item-actions">
                    <a href="/play.jsp?rentalId=RNT-7534" class="btn btn-play">▶ Chơi tiếp</a>
                </div>
            </div>

            <div class="rented-item status-expired">
                <div class="item-thumbnail" style="background-color: #2E8B57;"></div>
                <div class="item-info">
                    <h3 class="item-title">Pokemon Scarlet</h3>
                    <div class="time-badge time-expired">❌ Đã hết hạn</div>
                    <span class="item-details">Thuê lúc: 10/03/2026 14:00 | Mã phiên: RNT-1120</span>
                </div>
                <div class="item-actions">
                    <a href="/game-detail.jsp?id=2" class="btn btn-renew">🔄 Thuê lại</a>
                </div>
            </div>

        </div>
    </main>

</body>
</html>