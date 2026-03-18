package games;

import dbconnect.Connect;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class GameService implements IGameService {

    @Override
    public List<GameDTO> searchGames(String keyword, String category, BigDecimal maxPrice) {
        List<GameDTO> resultList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM games WHERE game_status = 'available'");

        // 1. Lọc theo từ khóa
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND game_title LIKE ?");
        }
        
        // 2. Lọc theo thể loại (Bây giờ dùng = vì dữ liệu đã chuẩn hóa thành action, rpg...)
        if (category != null && !category.equals("all") && !category.trim().isEmpty()) {
            sql.append(" AND game_genre = ?"); 
        }
        
        // 3. Lọc theo mức giá
        // Quy ước ngầm: Nếu maxPrice = -1 thì hiểu là tìm game > 5000đ
        // Nếu maxPrice > 0 thì hiểu là tìm game <= maxPrice
        if (maxPrice != null) {
            if (maxPrice.compareTo(BigDecimal.ZERO) < 0) { // Nếu maxPrice là số âm (-1)
                sql.append(" AND game_hourlyRate > 5000");
            } else { // Nếu maxPrice là số dương (ví dụ 5000)
                sql.append(" AND game_hourlyRate <= ?");
            }
        }

        System.out.println("👉 [DEBUG] Câu SQL chuẩn bị chạy: " + sql.toString());

        try (Connection conn = Connect.getConnection()) {
             
             if (conn == null) {
                 System.err.println("Không thể kết nối tới MySQL. Hãy kiểm tra lại XAMPP.");
                 return resultList;
             }

             try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                 int paramIndex = 1;
                 
                 // Gắn tham số 1: Keyword
                 if (keyword != null && !keyword.trim().isEmpty()) {
                     ps.setString(paramIndex++, "%" + keyword + "%");
                 }
                 
                 // Gắn tham số 2: Category
                 if (category != null && !category.equals("all") && !category.trim().isEmpty()) {
                     ps.setString(paramIndex++, category);
                 }
                 
                 // Gắn tham số 3: maxPrice (Chỉ gắn khi maxPrice > 0, vì nếu < 0 ta đã fix cứng số 5000 ở trên)
                 if (maxPrice != null && maxPrice.compareTo(BigDecimal.ZERO) >= 0) {
                     ps.setBigDecimal(paramIndex++, maxPrice);
                 }

                 ResultSet rs = ps.executeQuery();
                 while (rs.next()) {
                     GameDTO dto = new GameDTO();
                     dto.id = UUID.fromString(rs.getString("game_id"));
                     dto.title = rs.getString("game_title");
                     dto.browserUrl = rs.getString("game_browserUrl");
                     dto.hourlyRate = rs.getBigDecimal("game_hourlyRate");
                     dto.status = rs.getString("game_status");
                     dto.imageUrl = rs.getString("game_imageUrl"); 
                     dto.genre = rs.getString("game_genre"); 
                     dto.release = rs.getString("game_releaseDate");
                     dto.description = rs.getString("game_description");
                     
                     resultList.add(dto);
                 }
                 System.out.println("Lấy thành công " + resultList.size() + " game.");
             }
        } catch (Exception e) {
            System.err.println("Lỗi khi truy vấn MySQL:");
            e.printStackTrace();
        }
        return resultList;
    }

    @Override
    public GameDTO getGameDetails(String gameId) {
        String sql = "SELECT * FROM games WHERE game_id = ?";
        
        try (Connection conn = Connect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, gameId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                GameDTO dto = new GameDTO();
                dto.id = UUID.fromString(rs.getString("game_id"));
                dto.title = rs.getString("game_title");
                dto.browserUrl = rs.getString("game_browserUrl");
                dto.hourlyRate = rs.getBigDecimal("game_hourlyRate");
                dto.status = rs.getString("game_status");
                dto.imageUrl = rs.getString("game_imageUrl"); 
                dto.genre = rs.getString("game_genre");
                dto.release = rs.getString("game_releaseDate");
                dto.description = rs.getString("game_description");
                
                return dto; 
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy chi tiết game:");
            e.printStackTrace();
        }
        
        return null; 
    }
}