package com.smhrd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.model.PartyDAO;


@WebServlet("/acceptJoinRequest")
public class AcceptJoinRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AcceptJoinRequestServlet 호출됨."); // 디버깅 로그

        // 요청 파라미터 수집
        String userId = request.getParameter("userId"); // 가입 요청자
        int partyIdx = Integer.parseInt(request.getParameter("partyIdx")); // 모임 ID

        System.out.println("받은 파라미터: userId=" + userId + ", partyIdx=" + partyIdx); // 디버깅 로그

        PartyDAO dao = new PartyDAO();

        // 가입 요청 수락 처리
        boolean isAccepted = dao.acceptJoinRequest(userId, partyIdx);

        // 디버깅 로그
        if (isAccepted) {
            System.out.println("Join request accepted for userId: " + userId + ", partyIdx: " + partyIdx);
        } else {
            System.out.println("Failed to accept join request for userId: " + userId + ", partyIdx: " + partyIdx);
        }

        // 결과에 따라 페이지 이동
        response.sendRedirect("partyRoom.jsp");
    }
}