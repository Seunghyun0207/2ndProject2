package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.PartyDAO;
import com.smhrd.model.PartyVO;
import com.smhrd.model.UserVO;

@WebServlet("/partyDetailProcess")
public class PartyDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	UserVO user = (UserVO) session.getAttribute("user");

    	if (user == null) {
    	    response.sendRedirect("login.jsp");
    	    return;
    	}
    	
    	int partyIdx = Integer.parseInt(request.getParameter("partyIdx"));
        
        PartyDAO dao = new PartyDAO();
        PartyVO party = dao.selectPartyByIdx(partyIdx);
        
        if (party != null) {
            request.setAttribute("party", party);
        } else {
            request.setAttribute("errorMsg", "해당 방의 정보를 찾을 수 없습니다.");
        }
        
        request.getRequestDispatcher("partyDetails.jsp").forward(request, response);
    }
}
