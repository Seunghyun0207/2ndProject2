package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.UserVO;
import com.smhrd.model.LocationDAO;
import com.smhrd.model.LocationVO;

@WebServlet("/PartyNoticeForm")
public class PartyNoticeFormServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserVO user = (UserVO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String partyIdx = request.getParameter("partyIdx");

        // 콘솔에 partyIdx와 userId 출력
        System.out.println("PartyNoticeFormServlet - partyIdx: " + partyIdx);
        System.out.println("PartyNoticeFormServlet - userId: " + user.getUserId());

        if (partyIdx == null || partyIdx.isEmpty()) {
            response.sendRedirect("partyRoom.jsp?error=missingPartyIdx");
            return;
        }

        request.setAttribute("user", user);
        request.setAttribute("partyIdx", partyIdx);

        request.getRequestDispatcher("partyNotice.jsp").forward(request, response);
    }
}

