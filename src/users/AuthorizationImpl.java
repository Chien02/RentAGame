package users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import javax.ws.rs.core.Response;

import org.mindrot.jbcrypt.BCrypt;

import dbconnect.Connect;

public class AuthorizationImpl implements IAuthorization {
	@Override
	public Response login(UserDTO  userDTO) {
		try (Connection connection = Connect.getConnection()) {
			String email = userDTO.getEmail();
			String password = userDTO.getPassword();

			StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE email = ?");
			PreparedStatement statement = connection.prepareStatement(sql.toString());
			statement.setString(1, email);

			ResultSet resultSet = statement.executeQuery();
			if (resultSet.next()) {
				// So sánh mật khẩu băm
				String dbPasswordHash = resultSet.getString("password_hash");
				if (BCrypt.checkpw(password, dbPasswordHash)) {
					User user = new User();
					user.setUserId(resultSet.getString("id"));
					user.setUsername(resultSet.getString("username"));
					user.setEmail(resultSet.getString("email"));
					user.setRole(User.UserRole.valueOf(resultSet.getString("role")));
					
					return Response.ok(user).build();
				} else {
					return Response.status(Response.Status.UNAUTHORIZED).entity("Sai mật khẩu").build();
				}
			} else {
				return Response.status(Response.Status.UNAUTHORIZED).entity("Invalid email or password").build();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Internal server error").build();
		}
	}

	@Override
	public Response register(UserDTO userDTO) {
		try (Connection connect = Connect.getConnection()) {
			// Kiểm tra username đã tồn tại chưa
			String checkSql = "SELECT COUNT(*) FROM users WHERE username = ?";
			PreparedStatement checkStatement = connect.prepareStatement(checkSql);
			
			checkStatement.setString(1, userDTO.getUsername());
			ResultSet checkResult = checkStatement.executeQuery();
			
			if (checkResult.next() && checkResult.getInt(1) > 0) {
				return Response.status(Response.Status.UNAUTHORIZED).entity("Tài khoản đã tồn tại").build();
			}
			
			// Thêm người dùng vào database
			String insertSql = new String("INSERT INTO users (id, username, email, password_hash, role) VALUES (?, ?, ?, ?, ?)");
			PreparedStatement insertStatement = connect.prepareStatement(insertSql);
			
			User newUser = new User(userDTO);
			insertStatement.setString(1, newUser.getUserId().toString());
			insertStatement.setString(2, newUser.getUsername());
			insertStatement.setString(3, newUser.getEmail());
			insertStatement.setString(4, newUser.getPasswordHash());
			insertStatement.setString(5, newUser.getRole().toString());

			int rowsInserted = insertStatement.executeUpdate();
			if (rowsInserted > 0) {
				return Response.ok("Tạo tài khoản thành công").build();
			} else {
				return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Tạo tài khoản thất bại").build();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Lỗi kết nối cơ sở dữ liệu").build();
		}
	}
}
