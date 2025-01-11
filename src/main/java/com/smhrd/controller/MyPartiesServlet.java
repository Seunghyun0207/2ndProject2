package com.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.smhrd.model.PartyDAO;
import com.smhrd.model.PartyVO;
import com.smhrd.model.UserVO;

@WebServlet("/myParties")
public class MyPartiesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserVO user = (UserVO) session.getAttribute("user");

        // 세션에서 사용자 정보 확인
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 상태 반환
            response.getWriter().write("{\"error\":\"Unauthorized user\"}");
            return;
        }

        String userId = user.getUserId();
        PartyDAO partyDAO = new PartyDAO();

        // 사용자 모임 데이터 가져오기
        List<PartyVO> myParties = partyDAO.selectMyParties(userId);

        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 데이터가 없을 경우 빈 배열 반환
        if (myParties == null || myParties.isEmpty()) {
            response.getWriter().write("[]");
            System.out.println("No parties found for user: " + userId);
            return;
        }

        // JSON 데이터로 변환 및 반환
        String jsonResponse = new Gson().toJson(myParties);
        response.getWriter().write(jsonResponse);

        // 로그 출력
        System.out.println("User ID: " + userId + ", Parties: " + myParties.size());
        System.out.println("JSON Response: " + jsonResponse);
    }
}
