<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kho Game - Hệ Thống Thuê Game</title>
    <link rel="stylesheet" href="styles/gameInventory.css">
</head>
<body>

    <aside class="sidebar">
        <h2>GameHub</h2>
        <ul class="nav-links">
            <li><a href="/index.jsp">Trang chủ</a></li>
            <li><a href="/games.jsp" class="active">Kho Game</a></li>
            <li><a href="#">Game đang thuê</a></li>
            <li><a href="#">Lịch sử giao dịch</a></li>
        </ul>
    </aside>

    <main class="main-content">
        
        <form action="/games" method="GET" class="filter-bar">
            <input type="text" name="keyword" class="search-input" placeholder="Nhập tên game bạn muốn tìm...">
            
            <select name="category" class="filter-select">
                <option value="all">Tất cả thể loại</option>
                <option value="rpg">Nhập vai (RPG)</option>
                <option value="action">Hành động</option>
                <option value="strategy">Chiến thuật</option>
                <option value="sports">Thể thao</option>
            </select>

            <select name="price" class="filter-select">
                <option value="all">Mọi mức giá</option>
                <option value="under_5k">Dưới 5.000đ/Giờ</option>
                <option value="over_5k">Trên 5.000đ/Giờ</option>
            </select>

            <button type="submit" class="btn-search">Tìm kiếm</button>
        </form>

        <div class="section-header">
            <h2 class="section-title">Tất cả trò chơi</h2>
            <span class="game-count">Hiển thị 24 kết quả</span> 
        </div>

        <div class="game-grid">
            
            <div class="game-card">
                <div class="game-thumbnail" style="background-color: #8b0000;"></div> 
                <div class="game-info">
                    <h3 class="game-title">Hollow Knight</h3>
                    <span class="game-category">Hành động / Đi cảnh</span>
                    <span class="game-price">8.000đ / Giờ</span>
                    <a href="/game-detail.jsp?id=1" class="btn-rent">Chi tiết</a>
                </div>
            </div>

            <div class="game-card">
                <div class="game-thumbnail" style="background-color: #2E8B57;"></div>
                <div class="game-info">
                    <h3 class="game-title">Pokemon Scarlet</h3>
                    <span class="game-category">Nhập vai (RPG)</span>
                    <span class="game-price">6.000đ / Giờ</span>
                    <a href="/game-detail.jsp?id=2" class="btn-rent">Chi tiết</a>
                </div>
            </div>

            <div class="game-card">
                <div class="game-thumbnail" style="background-color: #4682B4;"></div>
                <div class="game-info">
                    <h3 class="game-title">Cobblemon Modpack</h3>
                    <span class="game-category">Phiêu lưu</span>
                    <span class="game-price">5.000đ / Giờ</span>
                    <a href="/game-detail.jsp?id=3" class="btn-rent">Chi tiết</a>
                </div>
            </div>

            <div class="game-card">
                <div class="game-thumbnail" style="background-color: #D2691E;"></div>
                <div class="game-info">
                    <h3 class="game-title">Stardew Valley</h3>
                    <span class="game-category">Mô phỏng</span>
                    <span class="game-price">4.000đ / Giờ</span>
                    <a href="/game-detail.jsp?id=4" class="btn-rent">Chi tiết</a>
                </div>
            </div>
            
            <div class="game-card">
                <div class="game-thumbnail" style="background-color: #696969;"></div>
                <div class="game-info">
                    <h3 class="game-title">Celeste Classic</h3>
                    <span class="game-category">Đi cảnh</span>
                    <span class="game-price">3.000đ / Giờ</span>
                    <a href="/game-detail.jsp?id=5" class="btn-rent">Chi tiết</a>
                </div>
            </div>

        </div>
    </main>

</body>
</html>