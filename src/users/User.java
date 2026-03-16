package users;

import java.util.UUID;
import java.io.Serializable;
import org.mindrot.jbcrypt.BCrypt;

public class User implements Serializable {
    private String userId;
    private String username;
    private String email;
    private String passwordHash;
    private UserRole role;

    public enum UserRole {
        CUSTOMER, // Khách hàng
        ADMIN     // Quản trị viên
    }

    public User() {
    }

    public User(String userId, String username, String email, String passwordHash, UserRole role) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = role;
    }
    
    public User(UserDTO userDTO) {
    	this.userId = UUID.randomUUID().toString();
		this.username = userDTO.getUsername();
		this.email = userDTO.getEmail();
		
		// Hash mật khẩu trước khi lưu vào cơ sở dữ liệu
		this.passwordHash = hashPassword(userDTO.getPassword());
		this.role = UserRole.CUSTOMER;
    }
    
    private String hashPassword(String password) {
		// Sử dụng thuật toán bcrypt để mã hóa
		return BCrypt.hashpw(password, BCrypt.gensalt());
    }
    
	//#region Getters and Setters	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}

	public UserRole getRole() {
		return role;
	}

	public void setRole(UserRole role) {
		this.role = role;
	}
	//#endregion
}
