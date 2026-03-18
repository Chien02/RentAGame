package users;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.*;

@Path("/auth")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AuthorizationService implements IAuthorization {
	private static AuthorizationImpl authorization = new AuthorizationImpl();

	@Override
	@POST
	@Path("/login")
	public Response login(UserDTO  userDTO) {
		return authorization.login(userDTO);
	}

	@Override
	@POST
	@Path("/register")
	public Response register(UserDTO userDTO) {
		return authorization.register(userDTO);
	}

	@Override
	@POST
	@Path("/update")
	public Response updateInfo(UserDTO userDTO) {
		return authorization.updateInfo(userDTO);
	}
}
