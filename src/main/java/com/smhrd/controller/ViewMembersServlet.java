package com.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.PartyDAO;
import com.smhrd.model.UserVO;

@WebServlet("/viewMembers")
public class ViewMembersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int partyIdx = Integer.parseInt(request.getParameter("partyIdx"));

        // PartyDAO를 통해 해당 모임의 회원 목록과 자기소개글 목록을 가져옴
        PartyDAO dao = new PartyDAO();
        List<UserVO> members = dao.getMembersByPartyIdx(partyIdx);  // 회원 목록 가져오기
        List<String> introList = dao.getJoinIntroByPartyIdx(partyIdx);  // 자기소개글 목록 가져오기

        // 조회된 회원 목록과 자기소개글을 JSP에 전달
        request.setAttribute("partyIdx", partyIdx);
        request.setAttribute("members", members);
        request.setAttribute("introList", introList);

        // memberList.jsp로 포워딩하여 결과를 표시
        request.getRequestDispatcher("membersList.jsp").forward(request, response);
    }
}