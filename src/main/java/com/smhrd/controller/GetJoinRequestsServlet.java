package com.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.JoinRequestVO;
import com.smhrd.model.PartyDAO;

@WebServlet("/getJoinRequests")
public class GetJoinRequestsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 응답을 JSON 형식으로 설정
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // 파라미터로 받은 partyIdx 값을 사용하여 참여 요청 목록을 조회
            int partyIdx = Integer.parseInt(request.getParameter("partyIdx"));
            PartyDAO partyDAO = new PartyDAO();
            List<JoinRequestVO> joinRequests = partyDAO.getJoinRequestsByPartyIdx(partyIdx);

            // joinIntro가 null이거나 빈 문자열인 경우 "내용 없음"으로 설정
            for (JoinRequestVO joinRequest : joinRequests) {
                if (joinRequest.getJoinIntro() == null || joinRequest.getJoinIntro().isEmpty()) {
                    joinRequest.setJoinIntro("내용 없음");  // 빈 문자열인 경우 "내용 없음"으로 설정
                }
            }

            // JSON 응답 데이터 생성
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("[");

            // joinRequests 목록을 JSON 형식으로 변환하여 응답에 포함
            if (joinRequests != null && !joinRequests.isEmpty()) {
                for (int i = 0; i < joinRequests.size(); i++) {
                    JoinRequestVO joinRequest = joinRequests.get(i);
                    jsonResponse.append("{")
                        .append("\"userId\":\"").append(joinRequest.getUserId()).append("\",")
                        .append("\"joinIntro\":\"").append(joinRequest.getJoinIntro()).append("\",")
                        .append("\"agreeYn\":\"").append(joinRequest.getAgreeYn()).append("\",")
                        .append("\"joinedAt\":\"").append(joinRequest.getJoinIntro()).append("\"")
                        .append("}");
                    if (i < joinRequests.size() - 1) {
                        jsonResponse.append(",");
                    }
                }
            }
            jsonResponse.append("]");

            // JSON 응답 데이터 출력
            response.getWriter().write(jsonResponse.toString());

        } catch (Exception e) {
            // 예외 발생 시 로그 출력 및 오류 메시지 반환
            System.err.println("서버 오류 발생: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"데이터를 불러오는 중 오류가 발생했습니다.\"}");
        }
    }
}