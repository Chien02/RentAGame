import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public interface IGameService {
    
    /**
     * Tìm kiếm game theo các tiêu chí (có thể null nếu không lọc).
     */
    List<GameDTO> searchGames(String keyword, String category, BigDecimal maxPrice);

    /**
     * Lấy chi tiết một tựa game.
     * Thường được gọi bởi RentalService để check giá tiền trước khi thanh toán.
     */
    GameDTO getGameDetails(UUID gameId);

    // DTO mô phỏng dữ liệu trả về
    class GameDTO {
        public UUID id;
        public String title;
        public String browserUrl;
        public BigDecimal hourlyRate;
        public String status; 
    }
}