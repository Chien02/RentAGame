<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Thuê Game online</title>
	<link rel="stylesheet" href="./styles/userInfo.css">
</head>
<body>
	<h1 class="userInfoTitle">THÔNG TIN NGƯỜI DÙNG</h1>
	<div class="userInfo">
        <p><strong>Email:</strong> <span id="userEmail"></span></p>
        <p><strong>Họ và tên:</strong> <span id="userFullName"></span></p>
        <p><strong>Số điện thoại:</strong> <span id="userPhone"></span></p>
    </div>

    <div class="userActions">
        <button id="walletbtn">Ví của tôi</button>
        <button id="editInfoBtn">Chỉnh sửa thông tin</button>
        <button id="changePasswordBtn">Đổi mật khẩu</button>
        <button id="logoutBtn">Đăng xuất</button>
    </div>

    <div class="rentalHistory">
        <h2>Lịch sử thuê game</h2>
        <table>
            <thead>
                <tr>
                    <th>Tên game</th>
                    <th>Ngày thuê</th>
                    <th>Ngày trả</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody id="rentalHistoryBody">
                <!-- Lịch sử thuê sẽ được hiển thị ở đây -->
            </tbody>
        </table>
    </div>
</body>
</html>