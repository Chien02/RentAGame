package games; 

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import games.IGameService.GameDTO;

@WebServlet("/games")
public class GameEndpoint extends HttpServlet {
    
    private IGameService gameService = new GameService();

    
	private final String SEARCH = "search";
	private final String DETAIL = "detail";
	
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
    	String action = request.getParameter("action");
    	if (action == null || action.trim().isEmpty()) {
            action = SEARCH;
        }
    	
    	if(SEARCH.equals(action)) {
    		String keyword = request.getParameter("keyword");
    		String category = request.getParameter("category");
    		String priceStr = request.getParameter("price");
        
    		BigDecimal maxPrice = null;
    		if ("under_5k".equals(priceStr)) {
    			maxPrice = new BigDecimal("5000");
    		}

    		List<IGameService.GameDTO> gameList = gameService.searchGames(keyword, category, maxPrice);
        
    		request.setAttribute("gameList", gameList);
    		request.setAttribute("keyword", keyword); 
        
    		request.getRequestDispatcher("gameInventory.jsp").forward(request, response);
    	}
    	else if(DETAIL.equals(action)) {
    		
    		String id = request.getParameter("id");
    		GameDTO gameinfo = gameService.getGameDetails(id);
    		
    		request.setAttribute("dto", gameinfo);
    		request.getRequestDispatcher("gameInfo.jsp").forward(request, response);
    		
    	}
        
    }
}