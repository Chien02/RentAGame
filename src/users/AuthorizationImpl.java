package users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.ws.rs.core.Response;
import org.mindrot.jbcrypt.BCrypt;
import dbconnect.Connect;

public class AuthorizationImpl implements IAuthorization {

    @Override
    public Response login(UserDTO userDTO) {
        try (Connection connection = Connect.getConnection()) {
            String emailInput = userDTO.getEmail();
            String passwordInput = userDTO.getPassword();

            String sql = "SELECT * FROM users WHERE user_email = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, emailInput);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                String dbPasswordHash = resultSet.getString("user_passwordHash");
                
                if (BCrypt.checkpw(passwordInput, dbPasswordHash)) {
                    User user = new User();
                    user.setUserId(resultSet.getString("user_id"));
                    user.setUsername(resultSet.getString("user_name"));
                    user.setEmail(resultSet.getString("user_email"));
                    user.setRole(User.UserRole.valueOf(resultSet.getString("user_role")));
                    
                    return Response.ok(user).build();
                } else {
                    return Response.status(Response.Status.UNAUTHORIZED).entity("Sai mật khẩu").build();
                }
            } else {
                return Response.status(Response.Status.UNAUTHORIZED).entity("Email không tồn tại").build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Lỗi hệ thống").build();
        }
    }

    @Override
    public Response register(UserDTO userDTO) {
        try (Connection connect = Connect.getConnection()) {
            String checkSql = "SELECT COUNT(*) FROM users WHERE user_name = ? OR user_email = ?";
            PreparedStatement checkStatement = connect.prepareStatement(checkSql);
            checkStatement.setString(1, userDTO.getUsername());
            checkStatement.setString(2, userDTO.getEmail());
            
            ResultSet checkResult = checkStatement.executeQuery();
            if (checkResult.next() && checkResult.getInt(1) > 0) {
                return Response.status(Response.Status.CONFLICT).entity("Tài khoản hoặc Email đã tồn tại").build();
            }
            
            String insertSql = "INSERT INTO users (user_id, user_name, user_email, user_passwordHash, user_registerDay, user_role) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement insertStatement = connect.prepareStatement(insertSql);
            
            User newUser = new User(userDTO);
            insertStatement.setString(1, newUser.getUserId().toString());
            insertStatement.setString(2, newUser.getUsername());
            insertStatement.setString(3, newUser.getEmail());
            insertStatement.setString(4, newUser.getPasswordHash());
            insertStatement.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            insertStatement.setString(6, newUser.getRole().toString());

            int rowsInserted = insertStatement.executeUpdate();
            if (rowsInserted > 0) {
                return Response.ok("Tạo tài khoản thành công").build();
            } else {
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Tạo tài khoản thất bại").build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Lỗi kết nối cơ sở dữ liệu").build();
        }
    }

    @Override
	public Response updateInfo(UserDTO userDTO) {
		String userId = userDTO.getUserId();
		String new_username = userDTO.getUsername();
		String new_email = userDTO.getEmail();
		
		// Kiểm tra an toàn: Đảm bảo có ID người dùng
		if (userId == null || userId.trim().isEmpty()) {
			return Response.status(Response.Status.BAD_REQUEST).entity("Không tìm thấy ID người dùng để cập nhật").build();
		}

		try (Connection connect = Connect.getConnection()) {
			// Kiểm tra xem username hoặc email mới có bị trùng với người RẤT KHÁC không
			String checkSql = "SELECT COUNT(*) FROM users WHERE (user_email = ? OR user_name = ?) AND user_id != ?";
			PreparedStatement checkStmt = connect.prepareStatement(checkSql);
			checkStmt.setString(1, new_email);
			checkStmt.setString(2, new_username);
			checkStmt.setString(3, userId);
			
			ResultSet rsCheck = checkStmt.executeQuery();
			if (rsCheck.next() && rsCheck.getInt(1) > 0) {
				return Response.status(Response.Status.CONFLICT).entity("Email hoặc Tên hiển thị đã được sử dụng bởi người khác!").build();
			}

			// Thực hiện câu lệnh UPDATE
			// Lưu ý: Sử dụng đúng tên cột (user_name, user_email, user_id)
			String updateSql = "UPDATE users SET user_name = ?, user_email = ? WHERE user_id = ?";
			PreparedStatement updateStatement = connect.prepareStatement(updateSql);
			
			updateStatement.setString(1, new_username);
			updateStatement.setString(2, new_email);
			updateStatement.setString(3, userId);
			
			// LƯU Ý QUAN TRỌNG: Với các lệnh INSERT/UPDATE/DELETE, phải dùng executeUpdate() thay vì executeQuery()
			int rowsUpdated = updateStatement.executeUpdate(); 
			
			if (rowsUpdated > 0) {
				UserDTO updatedUser = new UserDTO();
				updatedUser.setUserId(userId);
				updatedUser.setUsername(new_username);
				updatedUser.setEmail(new_email);
				// Cập nhật thành công
				return Response.ok(updatedUser).build();
			} else {
				// ID không tồn tại trong DB
				return Response.status(Response.Status.NOT_FOUND).entity("Không tìm thấy dữ liệu người dùng này trong hệ thống").build();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Lỗi kết nối SQL: " + e.getMessage()).build();
		}
	}
}