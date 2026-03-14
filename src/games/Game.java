package games;

import java.math.BigDecimal;
import java.util.UUID;

public class Game {

    // Các thuộc tính được đặt là private để đảm bảo tính đóng gói (Encapsulation)
    private UUID gameId;
    private String title;
    private String browserUrl;
    private String imageUrl;
    private BigDecimal hourlyRate;
    private GameStatus status;

    // Định nghĩa Enum cho trạng thái trực tiếp trong class (hoặc bạn có thể tách ra file riêng)
    public enum GameStatus {
        ACTIVE,      // Đang hoạt động, cho phép thuê
        MAINTENANCE, // Đang bảo trì, không cho thuê
        INACTIVE     // Đã gỡ khỏi hệ thống
    }

    // 1. Constructor mặc định (Bắt buộc phải có khi làm việc với các framework như Hibernate/Spring hoặc các thư viện mapping DB)
    public Game() {
    }

    // 2. Constructor đầy đủ tham số (Dùng để khởi tạo nhanh đối tượng khi lấy dữ liệu từ MySQL lên)
    public Game(UUID gameId, String title, String browserUrl, BigDecimal hourlyRate, GameStatus status) {
        this.gameId = gameId;
        this.title = title;
        this.browserUrl = browserUrl;
        this.hourlyRate = hourlyRate;
        this.status = status;
    }

    // ==========================================
    // 3. CÁC PHƯƠNG THỨC GETTER & SETTER
    // ==========================================

    public UUID getGameId() {
        return gameId;
    }

    public void setGameId(UUID gameId) {
        this.gameId = gameId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBrowserUrl() {
        return browserUrl;
    }

    public void setBrowserUrl(String browserUrl) {
        this.browserUrl = browserUrl;
    }

    public BigDecimal getHourlyRate() {
        return hourlyRate;
    }

    public void setHourlyRate(BigDecimal hourlyRate) {
        this.hourlyRate = hourlyRate;
    }

    public GameStatus getStatus() {
        return status;
    }

    public void setStatus(GameStatus status) {
        this.status = status;
    }

    // ==========================================
    // 4. PHƯƠNG THỨC TIỆN ÍCH
    // ==========================================

    // Kiểm tra nhanh xem game có đang cho phép thuê hay không
    public boolean isAvailable() {
        return this.status == GameStatus.ACTIVE;
    }

    @Override
    public String toString() {
        return "Game{" +
                "gameId=" + gameId +
                ", title='" + title + '\'' +
                ", hourlyRate=" + hourlyRate +
                ", status=" + status +
                '}';
    }
}