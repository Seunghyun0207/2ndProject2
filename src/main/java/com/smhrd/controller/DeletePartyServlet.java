package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.PartyDAO;
import com.smhrd.model.UserVO;

@WebServlet("/deletePartyProcess")
public class DeletePartyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // partyIdx 값 받기
            String partyIdxStr = request.getParameter("partyIdx");

            // 세션에서 user 객체를 가져옴
            HttpSession session = request.getSession();
            UserVO user = (UserVO) session.getAttribute("user");  // 세션에서 user 객체를 가져옴

            if (user == null) {
                // user 객체가 세션에 없으면 로그인 페이지로 리다이렉트
                response.sendRedirect("login.jsp");
                return;
            }

            String userId = user.getUserId();  // user 객체에서 userId 가져오기

            // 파라미터 유효성 검사
            if (partyIdxStr == null || partyIdxStr.isEmpty()) {
                throw new IllegalArgumentException("partyIdx 파라미터가 누락되었습니다.");
            }

            if (userId == null || userId.isEmpty()) {
                throw new IllegalArgumentException("userId 파라미터가 누락되었습니다.");
            }

            int partyIdx = Integer.parseInt(partyIdxStr);
            System.out.println("Deleting party with ID: " + partyIdx + " and user ID: " + userId);  // 삭제할 partyIdx와 userId 로그로 확인

            // PartyDAO 객체 생성
            PartyDAO partyDAO = new PartyDAO();

            // 모임 방 삭제
            int result = partyDAO.deleteParty(partyIdx, userId);  // userId도 함께 전달

            if (result > 0) {
                // 삭제 성공 시 main.jsp로 리디렉션
                System.out.println("Party deleted successfully. Redirecting to main.jsp.");
                response.sendRedirect("main.jsp");
            } else {
                // 삭제 실패 시 에러 메시지 출력
                System.out.println("Failed to delete party.");
                request.setAttribute("errorMsg", "모임 방 삭제에 실패했습니다.");
                request.getRequestDispatcher("partyRoom.jsp?partyIdx=" + partyIdx).forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "삭제 처리 중 오류가 발생했습니다.");
        }
    }
}