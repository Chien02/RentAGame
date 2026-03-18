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
            <li><a href="dashboard.jsp">Trang chủ</a></li>
            <li><a href="authorization?action=info" class="active">Tài khoản</a></li>
            <li><a href="games">Kho Game</a></li>
            <li><a href="userGames.jsp">Game đang thuê</a></li>
            <li><a href="#">Lịch sử giao dịch</a></li>
            <li><a href="authorization?action=logout">Đăng xuất</a></li>
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
                <button id="walletbtn" class="btn btn-wallet">Ví của tôi</button>
                <button id="editInfoBtn" class="btn btn-edit">Chỉnh sửa thông tin</button>
                <button id="changePasswordBtn" class="btn btn-edit">Đổi mật khẩu</button>
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

    <div id="editInfoModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" id="closeEditModal">&times;</span>
            <h2>Cập nhật thông tin</h2>
            
            <form action="authorization" method="POST">
                <input type="hidden" name="action" value="updateInfo">
                
                <div class="input-group">
                    <label for="editUsername">Tên hiển thị mới</label>
                    <input type="text" id="editUsername" name="username" value="${user != null ? user.username : ''}" required>
                </div>
                
                <div class="input-group">
                    <label for="editEmail">Email mới</label>
                    <input type="email" id="editEmail" name="email" value="${user != null ? user.email : ''}" required>
                </div>
                
                <input type="hidden" name="userId" value="${user != null ? user.userId : ''}">

                <button type="submit" class="btn btn-edit" style="width: 100%; margin-top: 10px;">Lưu thay đổi</button>
            </form>
        </div>
    </div>
    
    <div id="changePasswordModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" id="closeChangePasswordModal">&times;</span>
            <h2>Thay đổi mật khẩu</h2>
            
            <form id="changePasswordForm" action="authorization" method="POST">
                <input type="hidden" name="action" value="changePassword">
                
                <div class="input-group">
                    <label for="oldPassword">Mật khẩu cũ</label>
                    <input type="password" id="oldPassword" name="oldPassword" placeholder="Nhập mật khẩu cũ" required>
                </div>
                
                <div class="input-group">
                    <label for="newPassword">Mật khẩu mới</label>
                    <input type="password" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" required>
                </div>
                
                <div class="input-group">
                    <label for="confirmPassword">Xác nhận lại mật khẩu mới</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                </div>
                
                <input type="hidden" name="userId" value="${user != null ? user.userId : ''}">

                <button type="submit" class="btn btn-edit" style="width: 100%; margin-top: 10px;">Lưu thay đổi</button>
            </form>
        </div>
    </div>
    
    <div id="messageModal" class="modal" style="display: ${not empty successMessage or not empty errorMessage ? 'flex' : 'none'}; z-index: 2000;">
        <div class="modal-content" style="text-align: center; max-width: 350px; border-top: 4px solid ${not empty successMessage ? '#4caf50' : '#ff5252'};">
            <h2 style="color: ${not empty successMessage ? '#4caf50' : '#ff5252'}; font-size: 1.5rem; margin-bottom: 10px;">
                ${not empty successMessage ? 'Thành công!' : 'Có lỗi xảy ra'}
            </h2>
            <p style="color: #b3b3b3; font-size: 1rem; margin-bottom: 25px;">
                ${not empty successMessage ? successMessage : errorMessage}
            </p>
            <button id="closeMessageBtn" class="btn ${not empty successMessage ? 'btn-wallet' : 'btn-danger'}" style="width: 100%;">Đóng</button>
        </div>
    </div>

    <script>
        // ---  Xử lý Modal Chỉnh sửa thông tin ---
        const editBtn = document.getElementById('editInfoBtn');
        const editModal = document.getElementById('editInfoModal');
        const closeBtn = document.getElementById('closeEditModal');
        
        editBtn.addEventListener('click', () => { editModal.style.display = 'flex'; });
        closeBtn.addEventListener('click', () => { editModal.style.display = 'none'; });

        // ---  Xử lý Modal Đổi mật khẩu ---
        const changePasswordBtn = document.getElementById('changePasswordBtn');
        const changePasswordModal = document.getElementById('changePasswordModal');
        const closeChangePasswordBtn = document.getElementById('closeChangePasswordModal');

        changePasswordBtn.addEventListener('click', () => { changePasswordModal.style.display = 'flex'; });
        closeChangePasswordBtn.addEventListener('click', () => { changePasswordModal.style.display = 'none'; });

        // --- Kiểm tra mật khẩu khớp nhau trước khi submit ---
        const changePassForm = document.getElementById('changePasswordForm');
        changePassForm.addEventListener('submit', function(event) {
            const newPass = document.getElementById('newPassword').value;
            const confirmPass = document.getElementById('confirmPassword').value;
            
            if (newPass !== confirmPass) {
                event.preventDefault(); // Chặn không cho gửi form lên server
                alert("Mật khẩu mới và xác nhận mật khẩu không khớp nhau!");
            }
        });

        // ---  Xử lý Modal Thông báo (Message) ---
        const messageModal = document.getElementById('messageModal');
        const closeMessageBtn = document.getElementById('closeMessageBtn');
        if (closeMessageBtn) {
            closeMessageBtn.addEventListener('click', () => {
                messageModal.style.display = 'none';
            });
        }

        // ---  Đóng modal khi click ra ngoài vùng mờ ---
        window.addEventListener('click', (event) => {
            if (event.target === editModal) editModal.style.display = 'none';
            if (event.target === changePasswordModal) changePasswordModal.style.display = 'none';
            if (event.target === messageModal) messageModal.style.display = 'none';
        });
    </script>

</body>
</html>