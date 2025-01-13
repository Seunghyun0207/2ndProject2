package com.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.JoinRequestVO;
import com.smhrd.model.PartyDAO;
import com.smhrd.model.UserVO;

@WebServlet("/viewMembers")
public class ViewMembersServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String partyIdxParam = request.getParameter("partyIdx");
	    if (partyIdxParam == null || partyIdxParam.isEmpty()) {
	        throw new IllegalArgumentException("partyIdx 값이 유효하지 않습니다.");
	    }

	    int partyIdx = Integer.parseInt(partyIdxParam);
	    PartyDAO dao = new PartyDAO();

	    // 가입 요청 목록 조회
	    List<JoinRequestVO> pendingRequests = dao.getPendingJoinRequests(partyIdx);

	    // Null 체크 및 디버깅
	    if (pendingRequests == null || pendingRequests.isEmpty()) {
	        System.out.println("No pending join requests found.");
	    } else {
	        for (JoinRequestVO requestItem : pendingRequests) {
	            if (requestItem != null) {
	                System.out.println("UserId: " + requestItem.getUserId());
	                System.out.println("Intro: " + requestItem.getJoinIntro());
	            } else {
	                System.out.println("Null JoinRequestVO found!");
	            }
	        }
	    }

	    // JSP로 데이터 전달
	    request.setAttribute("pendingRequests", pendingRequests);
	    request.setAttribute("partyIdx", partyIdx);

	    RequestDispatcher rd = request.getRequestDispatcher("membersList.jsp");
	    rd.forward(request, response);
	}
}