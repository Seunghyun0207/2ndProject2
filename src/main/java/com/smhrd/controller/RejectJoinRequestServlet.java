package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.PartyDAO;

@WebServlet("/rejectJoinRequest")
public class RejectJoinRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        int partyIdx = Integer.parseInt(request.getParameter("partyIdx"));

        PartyDAO dao = new PartyDAO();
        try {
            // 가입 요청 거절 처리
            dao.rejectJoinRequest(userId, partyIdx);

            // 세션에 메시지 저장
            HttpSession session = request.getSession();
            session.setAttribute("message", "가입 요청을 거절하였습니다.");

            // 리다이렉트
            response.sendRedirect("partyRoomProcess?partyIdx=" + partyIdx);
        } catch (Exception e) {
            e.printStackTrace();

            // 에러 메시지 처리 (선택적으로 에러 페이지로 이동 가능)
            HttpSession session = request.getSession();
            session.setAttribute("message", "가입 요청 처리 중 오류가 발생했습니다.");
            response.sendRedirect("partyRoomProcess?partyIdx=" + partyIdx);
        }
    }
}