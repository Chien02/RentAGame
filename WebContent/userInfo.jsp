<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin người dùng - GameHub</title>
    <link rel="stylesheet" href="./styles/userInfo.css">
</head>
<body>

    <aside class="sidebar">
        <h2>GameHub</h2>
        <ul class="nav-links">
            <li><a href="#" class="active">Trang chủ</a></li>
            <li><a href="userInfo.jsp">Tài khoản</a></li>
            <li><a href="gameInventory.jsp">Kho Game</a></li>
            <li><a href="userGames.jsp">Game đang thuê</a></li>
            <li><a href="#">Lịch sử giao dịch</a></li>
        </ul>
    </aside>

    <main class="main-content">
        <div class="page-header">
            <h1>THÔNG TIN NGƯỜI DÙNG</h1>
        </div>

        <div class="profile-card">
            <div class="info-grid">
                <div class="info-item">
                    <p>Tên hiển thị (Username)</p>
                    <span id="userFullName">${user != null ? user.username : 'Đang cập nhật...'}</span>
                </div>
                <div class="info-item">
                    <p>Email liên hệ</p>
                    <span id="userEmail">${user != null ? user.email : 'Đang cập nhật...'}</span>
                </div>
                <div class="info-item">
                    <p>Loại tài khoản</p>
                    <span id="userRole">${user != null ? user.role : 'CUSTOMER'}</span>
                </div>
                <div class="info-item">
                    <p>Trạng thái</p>
                    <span style="color: #4caf50;">Đang hoạt động</span>
                </div>
            </div>

            <div class="user-actions">
                <button id="walletbtn" class="btn btn-wallet"> Ví của tôi</button>
                <button id="editInfoBtn" class="btn btn-edit">✏ Chỉnh sửa thông tin</button>
                <button id="changePasswordBtn" class="btn btn-edit"> Đổi mật khẩu</button>
                
                <form action="authorization" method="GET" style="margin: 0;">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" id="logoutBtn" class="btn btn-danger"> Đăng xuất</button>
                </form>
            </div>
        </div>

        <div class="history-section">
            <h2>Lịch sử thuê game gần đây</h2>
            <table class="history-table">
                <thead>
                    <tr>
                        <th>Tên game</th>
                        <th>Ngày thuê</th>
                        <th>Thời lượng</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody id="rentalHistoryBody">
                    <tr>
                        <td>Hollow Knight - Web Edition</td>
                        <td>16/03/2026</td>
                        <td>2 Giờ</td>
                        <td><span class="status-badge status-expired">Đã hết hạn</span></td>
                    </tr>
                    <tr>
                        <td>Pokemon Showdown</td>
                        <td>17/03/2026</td>
                        <td>5 Giờ</td>
                        <td><span class="status-badge status-playing">Đang còn hạn</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </main>

</body>
</html>