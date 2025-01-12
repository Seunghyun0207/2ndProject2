package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.PartyDAO;

@WebServlet("/deletePartyProcess")
public class DeletePartyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int partyIdx = Integer.parseInt(request.getParameter("partyIdx"));
            PartyDAO partyDAO = new PartyDAO();
            int result = partyDAO.deleteParty(partyIdx);  // 삭제 처리

            if (result > 0) {
                response.sendRedirect("main.jsp");  // 삭제 후 메인 페이지로 리디렉션
            } else {
                request.setAttribute("errorMsg", "삭제에 실패했습니다.");
                request.getRequestDispatcher("partyRoom.jsp?partyIdx=" + partyIdx).forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "삭제 처리 중 오류가 발생했습니다.");
        }
    }
}