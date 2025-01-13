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
            System.out.println("사용자가 로그인하지 않음. 로그인 페이지로 이동.");
            response.sendRedirect("login.jsp");
            return;
        }

        String userGender = user.getUserGender();
        System.out.println("사용자 ID: " + user.getUserId());
        System.out.println("사용자 성별: " + userGender);

        DataDAO dataDAO = new DataDAO();
        List<?> filteredData = null;

        if ("M".equals(userGender)) {
            System.out.println("남성 사용자: 데이터베이스 쿼리 실행 안 함.");
            filteredData = null; // 남성은 데이터 없음
        } else if ("F".equals(userGender)) {
            System.out.println("여성 사용자: 데이터 가져오기 시작.");
            filteredData = dataDAO.getAllData();

            if (filteredData != null) {
                System.out.println("가져온 데이터 크기: " + filteredData.size());
            } else {
                System.out.println("가져온 데이터가 없습니다.");
            }
        } else {
            System.out.println("알 수 없는 성별: " + userGender);
        }

        // JSP로 데이터 전달
        System.out.println("JSP로 전달된 데이터: " + (filteredData == null ? "null" : filteredData));
        request.setAttribute("filteredData", filteredData);
        RequestDispatcher dispatcher = request.getRequestDispatcher("filteredData.jsp");
        dispatcher.forward(request, response);
    }
}