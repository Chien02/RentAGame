<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Thuê Game online</title>
	<link rel="stylesheet" href="./styles/walletInfo.css">
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
            <li><a href="authorization?action=logout">Đăng xuất</a></li>
        </ul>
    </aside>
    
	<h1 class="userWalletTitle">THÔNG TIN VÍ CỦA TÔI</h1>
	<div class="walletInfo">
        <p><strong>Chủ ví:</strong> <span id="userName"></span></p>
        <p><strong>Số dư:</strong> <span id="userBalance"></span></p>
    </div>

    <div class="userActions">
        <button id="repositBtn">Nạp tiền</button>
        <button id="userInfoBtn">Quay lại trang thông tin</button>
    </div>

    <%-- Thống kê thuê game, chi tiền bao nhiêu cho game nào, tháng này so sánh với tháng trước> --%>
    <div class="rentalReport">
        <h2>Thống kê thuê game</h2>
        <table>
            <thead>
                <tr>
                    <th>Tên game</th>
                    <th>Số lần thuê</th>
                    <th>Tổng chi tiêu</th>
                </tr>
            </thead>
            <tbody id="rentalReportBody">
                <!-- Thống kê thuê game sẽ được hiển thị ở đây -->
            </tbody>
        </table>
    </div>

    <div class="transactionHistory">
        <h2>Lịch sử giao dịch</h2>
        <table>
            <thead>
                <tr>
                    <th>Loại giao dịch</th>
                    <th>Ngày giao dịch</th>
                    <th>Số tiền</th>
                    <th>Chi tiết</th>
                </tr>
            </thead>
            <tbody id="transactionHistoryBody">
                <!-- Lịch sử giao dịch sẽ được hiển thị ở đây -->
            </tbody>
        </table>
    </div>
</body>
</html>