package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/createJoinRequest")
public class CreateJoinRequestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // partyIdx 파라미터 받아오기
        String partyIdxStr = request.getParameter("partyIdx");

        if (partyIdxStr == null || partyIdxStr.trim().isEmpty()) {
            // partyIdx 값이 없거나 빈 문자열일 경우 에러 응답
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "partyIdx 값이 유효하지 않습니다.");
            return;
        }

        int partyIdx;
        try {
            // 문자열을 정수로 변환
            partyIdx = Integer.parseInt(partyIdxStr);
        } catch (NumberFormatException e) {
            // 변환 실패 시 에러 응답
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "partyIdx 값이 숫자가 아닙니다.");
            return;
        }

        // partyIdx를 JSP로 전달
        request.setAttribute("partyIdx", partyIdx);

        // 소개글 입력 페이지로 포워딩
        request.getRequestDispatcher("joinRequestForm.jsp").forward(request, response);
    }
}