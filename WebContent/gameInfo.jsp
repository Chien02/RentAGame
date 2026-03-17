<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Thuê Game online</title>
	<link rel="stylesheet" href="./styles/authorizedForm.css">
</head>
<body>
	<h1 class="gameInfoTitle">THÔNG TIN TRÒ CHƠI</h1>
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
	<div class="gameInfoContainer">
        <img src="${gameImage}" alt="Game Image" class="gameImage">
        <div class="gameDetails">
            <h2>Tên Game ${gameName}</h2>
            <p><strong>Thể loại:</strong> ${gameGenre}</p>
            <p><strong>Ngày phát hành:</strong> ${gameReleaseDate}</p>
            <p><strong>Mô tả:</strong> ${gameDescription}</p>
            <p><strong>Giá thuê theo giờ:</strong> ${gamePrice}</p>
            <button type="button">Thuê ngay</button>
        </div>
    </div>
</body>
</html>