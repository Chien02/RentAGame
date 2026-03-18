package users;

import java.util.UUID;

public class UserDTO implements java.io.Serializable {
	private String userId; // Chỉ dùng cho đăng xuất, session
	private String username;
	private String email;
	private String password;
	private String newPassword;
	private String confirmPassword;
	private String passwordHash;
	
	public UserDTO() {
		super();
	}

	public UserDTO(String userId, String username, String email, String password, String confirmPassword,
			String passwordHash) {
		super();
		this.userId = userId;
		this.username = username;
		this.email = email;
		this.password = password;
		this.confirmPassword = confirmPassword;
		this.passwordHash = passwordHash;
	}
	
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}
	
	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
}
