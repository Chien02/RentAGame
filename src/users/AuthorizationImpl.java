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
}