package users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
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
	private final String LOGOUT = "logout";
	
	ClientConfig config = new ClientConfig();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthorizationEndpoint() {
        super();
        // TODO Auto-generated constructor stub
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
			String errorMessage = apiResponse.readEntity(String.class);
			request.setAttribute("error", errorMessage);
			request.getRequestDispatcher("login.jsp").forward(request, response);
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
			String errorMessage = apiResponse.readEntity(String.class);
			request.setAttribute("error", errorMessage);
			request.getRequestDispatcher("register.jsp").forward(request, response);
		}
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.getSession().invalidate(); // Xóa thông tin người dùng khỏi session
    	response.sendRedirect("login.jsp");
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
		} else {
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
