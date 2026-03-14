<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đang chơi game - Hệ thống Thuê Game</title>
    <link rel="stylesheet" href="./styles/play.css">
</head>
<body>

    <div class="top-bar">
        <div class="game-info">
            <%-- Về sau đổi lại thành ${gameName}--%>
            <span>Đang chơi: <strong>Super Mario Bros (Itch.io)</strong></span>
        </div>
        <div class="timer-container">
            <span>⏳ Thời gian còn lại:</span>
            <span id="timer-display">--:--:--</span>
        </div>
        <button class="btn-exit" onclick="exitGame()">Thoát & Lưu giờ</button>
    </div>

    <%-- Giả sử là link này, về sau đổi lại thành ${gameLink} --%>
    <iframe id="game-frame" src="https://chien02.itch.io/rabbitranch" allowfullscreen="true"></iframe>

    <script>
        // --- 1. CẤU HÌNH BAN ĐẦU ---
        // Biến này sẽ nhận giá trị số giây còn lại từ server khi trang vừa load xong
        // (Trong JSP, bạn có thể gán: let remainingSeconds = ${remainingTime};)
        let remainingSeconds = 7200; // Giả sử còn 2 giờ (7200 giây)
        const rentalId = "RENTAL-UUID-12345"; // ID của phiên thuê hiện tại
        
        const timerDisplay = document.getElementById('timer-display');
        let countdownInterval;
        let heartbeatInterval;

        // --- 2. LOGIC ĐẾM NGƯỢC (HIỂN THỊ UI) ---
        function formatTime(totalSeconds) {
            const h = Math.floor(totalSeconds / 3600).toString().padStart(2, '0');
            const m = Math.floor((totalSeconds % 3600) / 60).toString().padStart(2, '0');
            const s = (totalSeconds % 60).toString().padStart(2, '0');
            return `${h}:${m}:${s}`;
        }

        function startCountdown() {
            // Cập nhật giao diện ngay lập tức
            timerDisplay.innerText = formatTime(remainingSeconds);
            
            countdownInterval = setInterval(() => {
                if (remainingSeconds > 0) {
                    remainingSeconds--;
                    timerDisplay.innerText = formatTime(remainingSeconds);
                } else {
                    forceKickUser();
                }
            }, 1000);
        }

        // --- 3. LOGIC HEARTBEAT (GIAO TIẾP BACKEND) ---
        function startHeartbeat() {
            // Cứ mỗi 30 giây gửi một request ping về server
            heartbeatInterval = setInterval(() => {
                // Gọi tới endpoint API (ví dụ một Servlet xử lý ping)
                fetch('/api/rentals/ping', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ rentalId: rentalId })
                })
                .then(response => {
                    if (response.status === 403 || response.status === 401) {
                        // Server báo hết giờ hoặc khóa không hợp lệ
                        forceKickUser();
                    }
                })
                .catch(err => console.error("Lỗi gửi heartbeat:", err));
            }, 30000); // 30,000 ms = 30 giây
        }

        // --- 4. CÁC HÀM XỬ LÝ THOÁT GAME ---
        function forceKickUser() {
            clearInterval(countdownInterval);
            clearInterval(heartbeatInterval);
            document.getElementById('game-frame').remove(); // Xóa game ngay lập tức
            alert("Đã hết thời gian thuê game! Hệ thống sẽ đưa bạn về trang chủ.");
            window.location.href = '/game-info.jsp'; // Điều hướng về trang thông tin
        }

        function exitGame() {
            // Người dùng chủ động bấm nút "Thoát"
            const confirmExit = confirm("Bạn có chắc chắn muốn thoát? Thời gian còn lại sẽ được lưu.");
            if (confirmExit) {
                // Gửi request dừng tính giờ lên server
                fetch('/api/rentals/stop', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ rentalId: rentalId })
                }).then(() => {
                    window.location.href = '/game-info.jsp';
                });
            }
        }

        // Xử lý sự kiện khi người dùng ĐÓNG TAB ngang
        window.addEventListener('beforeunload', function (e) {
            // Dùng sendBeacon để đảm bảo request được gửi đi kể cả khi tab đang đóng
            const data = JSON.stringify({ rentalId: rentalId });
            navigator.sendBeacon('/api/rentals/stop', data);
        });

        // --- BẮT ĐẦU CHẠY KHI TẢI TRANG ---
        window.onload = () => {
            if (remainingSeconds > 0) {
                startCountdown();
                startHeartbeat();
            } else {
                forceKickUser();
            }
        };
    </script>
</body>
</html>