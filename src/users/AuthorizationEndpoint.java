package users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.glassfish.jersey.client.*;
import org.mindrot.jbcrypt.BCrypt;

/**
 * Servlet implementation class AuthorizationEndpoint
 */
@WebServlet("/authorization")
public class AuthorizationEndpoint extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final String AUTH_URL = "http://localhost:8080/GameRentals/rest/auth";
	
	private final String LOGIN = "login";
	private final String REGISTER = "register";
	private final String INFO = "info";
	private final String LOGOUT = "logout";
	private final String UPDATE = "updateInfo";
	private final String CHANGEPASSWORD = "changePassword";
	
	ClientConfig config = new ClientConfig();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthorizationEndpoint() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private void throwErrorMessage(HttpServletRequest request, HttpServletResponse response, Response apiResponse, String path) throws ServletException, IOException {
    	String errorMessage = apiResponse.readEntity(String.class);
		request.setAttribute("errorMessage", errorMessage);
		request.getRequestDispatcher(path).forward(request, response);
    }
    
    private void login(HttpServletRequest request, HttpServletResponse response, WebTarget target) throws ServletException, IOException {
    	UserDTO userDTO = new UserDTO();
		userDTO.setEmail(request.getParameter("email"));
		userDTO.setPassword(request.getParameter("password"));

		Response apiResponse = target.path("login").request().post(Entity.json(userDTO));
		if (apiResponse.getStatus() == Response.Status.OK.getStatusCode()) {
			User user = apiResponse.readEntity(User.class);
			request.getSession().setAttribute("user", user); // Lưu thông tin người dùng vào session
			response.sendRedirect("dashboard.jsp");
		} else {
			throwErrorMessage(request, response, apiResponse, "login.jsp");
		}
    }
    
    private void register(HttpServletRequest request, HttpServletResponse response, WebTarget target) throws ServletException, IOException {
    	UserDTO userDTO = new UserDTO();
		userDTO.setUsername(request.getParameter("username"));
		userDTO.setEmail(request.getParameter("email"));
		userDTO.setPassword(request.getParameter("password"));
		userDTO.setConfirmPassword(request.getParameter("confirmPassword"));

		Response apiResponse = target.path("register").request().post(Entity.json(userDTO));
		if (apiResponse.getStatus() == Response.Status.OK.getStatusCode()) {
			request.setAttribute("success", "Tạo tài khoản thành công");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		} else {
			throwErrorMessage(request, response, apiResponse, "register.jsp");
		}
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.getSession().invalidate(); // Xóa thông tin người dùng khỏi session
    	response.sendRedirect("login.jsp");
    }
    
    private void userInfo(HttpServletRequest request, HttpServletResponse response, WebTarget target) throws ServletException, IOException {
    	// Kiểm tra trong session còn user không, nếu còn thì truyền vào biến user, nếu không thì mới gọi api
    	HttpSession session = request.getSession();
    	if (session.getAttribute("user") == null) {
    		String error = "Mất phiên đăng nhập";
    		response.sendRedirect("login.jsp"); // Load lại trang đăng nhập
    		request.setAttribute("eror", error);
    	} else {
    		// Nhận dữ liệu từ sesion, và truyền vào trang userInfo
    		User user = (User) session.getAttribute("user");
    		request.setAttribute("user", user);
    		request.getRequestDispatcher("userInfo.jsp").forward(request, response);
    	}
    }
    
    private void updateInfo(HttpServletRequest request, HttpServletResponse response, WebTarget target) throws ServletException, IOException {
    	User user = (User) request.getSession().getAttribute("user");
    	String userId = user.getUserId();
    	String new_username = request.getParameter("username");
    	String new_email = request.getParameter("email");
    	
    	// Đóng gói để gửi đến service, chỉ sử dụng 3 thuộc tính
    	UserDTO userDTO = new UserDTO();
    	userDTO.setUserId(userId);
    	userDTO.setUsername(new_username);
    	userDTO.setEmail(new_email);
    	
    	Response apiResponse = target.path("update").request().post(Entity.json(userDTO));
    	
    	// Xử lý kết quả nhận về từ api
    	if (apiResponse.getStatus() == Response.Status.OK.getStatusCode()) {
    		// Đọc UserDTO nhận về, chỉ lấy username và email mới, sau đó cập nhật cho biến user của session
    		UserDTO updatedUserDTO = apiResponse.readEntity(UserDTO.class);
    		user.setUsername(updatedUserDTO.getUsername());
    		user.setEmail(updatedUserDTO.getEmail());
    		
    		// Lưu vào session
    		request.getSession().setAttribute("user", user);
    		request.setAttribute("user", user);
    		request.getRequestDispatcher("userInfo.jsp").forward(request, response);
    	} else {
    		throwErrorMessage(request, response, apiResponse, "userInfo.jsp");
    	}
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, WebTarget target) throws ServletException, IOException {
    	String userId = request.getParameter("userId");
    	String oldPassword = request.getParameter("oldPassword");
    	String newPassword = request.getParameter("newPassword");
    	
    	// Đóng gói vào UserDTO và gửi đi
    	UserDTO userDTO = new UserDTO();
    	userDTO.setUserId(userId);
    	userDTO.setPassword(oldPassword);
    	userDTO.setNewPassword(newPassword);
    	
    	// Gọi API
    	Response apiResponse = target.path("changePassword").request().post(Entity.json(userDTO));
    	
    	// Xử lý kết quả
    	if (apiResponse.getStatus() == Response.Status.OK.getStatusCode()) {
    		// Tải lại trang và thông báo ra màn hình
    		request.setAttribute("successMessage", "Thay đổi mật khẩu thành công!");
            request.getRequestDispatcher("userInfo.jsp").forward(request, response);
    	} else {
    		throwErrorMessage(request, response, apiResponse, "userInfo.jsp");
    	}
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Khởi tạo client
		Client client = ClientBuilder.newClient(config);
		WebTarget target = client.target(AUTH_URL);

		// Sử dụng tham số action để phân biệt yêu cầu
		String action = request.getParameter("action");
		
		// Dùng chuỗi hằng số gọi .equals() sẽ an toàn tuyệt đối
		if (LOGIN.equals(action)) {
		    login(request, response, target);
		} else if (REGISTER.equals(action)) {
		    register(request, response, target);
		} else if (LOGOUT.equals(action)) {
		    logout(request, response);
		} else if (INFO.equals(action)) {
			userInfo(request, response, target);
		} else if (UPDATE.equals(action)) {
			updateInfo(request, response, target);
		} else if (CHANGEPASSWORD.equals(action)) {
			changePassword(request, response, target);
		}
		else {
		    // Xử lý khi action không hợp lệ (vd: quay về trang chủ)
		    response.sendRedirect("login.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
