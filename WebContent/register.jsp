<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - GameHub</title>
    <link rel="stylesheet" href="./styles/register.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-header">
            <h1>GameHub</h1>
            <p>Tạo tài khoản để trải nghiệm hàng trăm tựa game</p>
        </div>

        <p id="error-message">Mật khẩu nhập lại không khớp!</p>

        <form class="authorizedForm" id="registerForm" action="/register" method="POST">
            
            <div class="input-group">
                <label for="username">Tên hiển thị (Nickname)</label>
                <input type="text" id="username" name="username" placeholder="Nhập tên hiển thị của bạn" required>
            </div>

            <div class="input-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Nhập email hợp lệ" required>
            </div>
            
            <div class="input-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Tối thiểu 6 ký tự" minlength="6" required>
            </div>

            <div class="input-group">
                <label for="passwordConfirmed">Nhập lại mật khẩu</label>
                <input type="password" id="passwordConfirmed" name="passwordConfirmed" placeholder="Xác nhận lại mật khẩu" required>
            </div>
            
            <button type="submit" class="btn-submit">Đăng Ký</button>
            
        </form>

        <div class="auth-links">
            <p>Đã có tài khoản? <a href="/login.jsp">Đăng nhập ngay</a></p>
        </div>
    </div>

    <script>
        const form = document.getElementById('registerForm');
        const password = document.getElementById('password');
        const passwordConfirmed = document.getElementById('passwordConfirmed');
        const errorMessage = document.getElementById('error-message');

        form.addEventListener('submit', function(event) {
            if (password.value !== passwordConfirmed.value) {
                // Ngăn không cho form gửi dữ liệu lên server
                event.preventDefault(); 
                // Hiển thị dòng thông báo lỗi
                errorMessage.style.display = 'block';
                // Focus lại vào ô nhập lại mật khẩu
                passwordConfirmed.focus(); 
            } else {
                errorMessage.style.display = 'none';
            }
        });
    </script>

</body>
</html>