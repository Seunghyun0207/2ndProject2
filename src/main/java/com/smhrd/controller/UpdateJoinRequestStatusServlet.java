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
        String action = request.getParameter("action");
        char agreeYn = action.equals("accept") ? 'y' : 'n';
        int partyIdx = Integer.parseInt(request.getParameter("partyIdx"));

        JoinRequestDAO dao = new JoinRequestDAO();
        int result = dao.updateJoinRequestStatus(userId, partyIdx, agreeYn);

        if (result > 0) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}