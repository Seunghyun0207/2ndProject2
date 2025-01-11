package com.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.PartyDAO;
import com.smhrd.model.PartyVO;
import com.smhrd.model.UserVO;

@WebServlet("/findPartyProcess")
public class FindPartyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserVO user = (UserVO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userRegion = user.getUserRegion();
        System.out.println("User Region: " + userRegion);  // userRegion 값 확인

        PartyDAO dao = new PartyDAO();
        List<PartyVO> partyList = dao.selectPartiesByRegion(userRegion);

        if (partyList == null || partyList.isEmpty()) {
            System.out.println("DAO에서 가져온 partyList가 비어있습니다. 지역: " + userRegion);
        } else {
            for (PartyVO party : partyList) {
                System.out.println("방 제목: " + party.getPartyNm());
                System.out.println("방 지역: " + party.getPartyRegion());
            }
        }

        // JSON 데이터 반환
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("[");
        if (partyList != null && !partyList.isEmpty()) {
            for (int i = 0; i < partyList.size(); i++) {
                PartyVO party = partyList.get(i);
                jsonResponse.append("{")
                    .append("\"partyNm\":\"").append(party.getPartyNm()).append("\",")
                    .append("\"partyRegion\":\"").append(party.getPartyRegion()).append("\",")
                    .append("\"userId\":\"").append(party.getUserId()).append("\",")
                    .append("\"createdAt\":\"").append(party.getCreatedAt()).append("\",")
                    .append("\"partyIdx\":\"").append(party.getPartyIdx()).append("\"")
                    .append("}");
                if (i < partyList.size() - 1) {
                    jsonResponse.append(",");
                }
            }
        }
        jsonResponse.append("]");

        // JSON 데이터 반환
        System.out.println("응답 데이터: " + jsonResponse.toString());  // 확인용 로그
        response.getWriter().write(jsonResponse.toString());
    }
}