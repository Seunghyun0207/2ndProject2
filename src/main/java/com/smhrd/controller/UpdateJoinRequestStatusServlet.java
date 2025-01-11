package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.JoinRequestDAO;

@WebServlet("/updateJoinRequestStatus")
public class UpdateJoinRequestStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int partyIdx = Integer.parseInt(request.getParameter("partyIdx"));
        String userId = request.getParameter("userId");
        char agreeYn = request.getParameter("agreeYn").charAt(0); // 'Y' 또는 'N'

        JoinRequestDAO dao = new JoinRequestDAO();
        int result = dao.updateJoinRequestStatus(partyIdx, userId, agreeYn);

        if (result > 0) {
            response.sendRedirect("partyRoom.jsp?partyIdx=" + partyIdx);
        } else {
            response.getWriter().println("업데이트 실패");
        }
    }
}