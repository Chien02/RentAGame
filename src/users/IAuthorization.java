package users;

import javax.ws.rs.core.Response;

public interface IAuthorization {
	Response login(UserDTO userDTO);
    Response register(UserDTO userDTO);
    // Response logout(UserDTO userDTO); Đổi sang xóa session chứ ko cần gọi service.
    Response updateInfo(UserDTO userDTO);
    Response changePassword(UserDTO userDTO);
}
