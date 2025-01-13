package com.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.DataDAO;
import com.smhrd.model.UserVO;

@WebServlet("/filteredData")
public class FilteredDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("FilteredDataServlet 호출됨");

        // 세션에서 사용자 정보 가져오기
        UserVO user = (UserVO) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userGender = user.getUserGender();
        System.out.println("사용자 성별: " + userGender);

        boolean isRestricted = "M".equals(userGender);

        // JSON 응답 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 응답을 JSON 형식으로 반환
        String jsonResponse = "{ \"isRestricted\": " + isRestricted + " }";
        response.getWriter().write(jsonResponse);
    }
}