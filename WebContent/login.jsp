<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - GameHub</title>
    <link rel="stylesheet" href="./styles/login.css">
</head>
<body>

    <div class="login-container">
        <div class="login-header">
            <h1>GameHub</h1>
            <p>Đăng nhập để bắt đầu thuê game</p>
        </div>
		<h4 style="color: red;">${error}</h4>
        <form class="authorizedForm" action="authorization" method="POST">
            <input type="hidden" name="action" value="login">
            <div class="input-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Nhập email của bạn" required>
            </div>
            
            <div class="input-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>
            </div>
            
            <button type="submit" class="btn-submit">Đăng nhập</button>
            
        </form>

        <div class="auth-links">
            <p>Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a></p>
        </div>
    </div>

</body>
</html>