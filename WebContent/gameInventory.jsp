<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        
        <form action="${pageContext.request.contextPath}/games" method="GET" class="filter-bar">
            <input type="text" name="keyword" value="${keyword}" class="search-input" placeholder="Nhập tên game bạn muốn tìm...">
            
            <select name="category" class="filter-select">
                <option value="all">Tất cả thể loại</option>
                <option value="rpg" ${param.category == 'rpg' ? 'selected' : ''}>Nhập vai (RPG)</option>
                <option value="action" ${param.category == 'action' ? 'selected' : ''}>Hành động</option>
                <option value="strategy" ${param.category == 'strategy' ? 'selected' : ''}>Chiến thuật</option>
                <option value="simulation" ${param.category == 'simulation' ? 'selected' : ''}>Mô phỏng</option>
            </select>
            <select name="price" class="filter-select">
                <option value="all">Mọi mức giá</option>
                <option value="under_5k" ${param.price == 'under_5k' ? 'selected' : ''}>Dưới 5.000đ/Giờ</option>
                <option value="over_5k" ${param.price == 'over_5k' ? 'selected' : ''}>Trên 5.000đ/Giờ</option>
            </select>

            <button type="submit" class="btn-search">Tìm kiếm</button>
        </form>

        <div class="section-header">
            <h2 class="section-title">Tất cả trò chơi</h2>
            <span class="game-count">Hiển thị ${gameList.size()} kết quả</span> 
        </div>

		<div class="game-grid">
    		<c:forEach items="${gameList}" var="dto">
        		<div class="game-card">
            		<div class="game-thumbnail" style="background-image: url('${dto.imageUrl}'); background-size: cover; background-position: center;"></div> 
            			<div class="game-info">
                			<h3 class="game-title">${dto.title}</h3>
                				<span class="game-category">${dto.genre}</span>
                				<span class="game-price">${dto.hourlyRate}đ / Giờ</span>
                			<a href="/game-detail.jsp?id=${dto.id}" class="btn-rent">Chi tiết</a>
            			</div>
        		</div>
    		</c:forEach>

    	<c:if test="${empty gameList}">
        		<p style="color: white; text-align: center; width: 100%;">Không tìm thấy trò chơi nào.</p>
    	</c:if>
</div>
    </main>

</body>
</html>