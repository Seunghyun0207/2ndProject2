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
        String userId = request.getParameter("userId");
        int partyIdx = Integer.parseInt(request.getParameter("partyIdx"));
        String action = request.getParameter("action");  // 'accept' 또는 'reject'

        JoinRequestDAO dao = new JoinRequestDAO();
        int result = 0;

        if ("accept".equals(action)) {
            // 수락 처리
            result = dao.updateJoinRequestStatus(partyIdx, userId, 'Y');
        } else if ("reject".equals(action)) {
            // 거절 처리
            result = dao.updateJoinRequestStatus(partyIdx, userId, 'N');
        }

        if (result > 0) {
            // 성공 시, 목록에서 해당 신청을 제거하고 새로고침
            response.sendRedirect("viewMembers?partyIdx=" + partyIdx);
        } else {
            response.getWriter().println("오류가 발생했습니다.");
        }
    }
}