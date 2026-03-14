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