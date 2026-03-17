package rentals;

import java.util.UUID;

public interface IRentalService {

    // ==========================================
    // NHÓM 1: CHỨC NĂNG THUÊ GAME
    // ==========================================

    /**
     * Thực hiện toàn bộ luồng thuê: 
     * 1. Lấy giá từ GameService.
     * 2. Gọi PaymentService để trừ tiền.
     * 3. Tạo bản ghi vào bảng Rentals.
     */
    RentalResultDTO rentGame(UUID userId, UUID gameId, int durationHours);


    // ==========================================
    // NHÓM 2: CHỨC NĂNG CHƠI & TÍNH GIỜ
    // ==========================================

    /**
     * Người dùng bấm nút [Chơi].
     * Hàm này chuyển trạng thái sang PLAYING, cập nhật last_resume_time.
     * Trả về URL iframe và số giây còn lại để Frontend đếm ngược.
     */
    PlaySessionDTO startGame(UUID rentalId, UUID userId) throws AccessDeniedException;

    /**
     * Nhận nhịp tim (Ping) mỗi 30 giây từ giao diện JSP/HTML.
     * Hàm này trừ thời gian và kiểm tra xem có hết hạn không.
     */
    HeartbeatResponse processHeartbeat(UUID rentalId);

    /**
     * Người dùng chủ động bấm [Thoát] hoặc tắt tab.
     * Chốt lại thời gian, lưu số giây còn dư vào DB và chuyển về IDLE.
     */
    void stopGame(UUID rentalId);

    
    // --- Các DTO trả về cho giao diện (Controller/Servlet) ---

    class RentalResultDTO {
        public boolean success;
        public UUID rentalId;
        public String message;
    }

    class PlaySessionDTO {
        public String iframeUrl;
        public int remainingSeconds;
    }

    class HeartbeatResponse {
        public boolean isExpired;
        public int currentRemainingSeconds;
    }

    class AccessDeniedException extends Exception {
        public AccessDeniedException(String message) { super(message); }
    }
}