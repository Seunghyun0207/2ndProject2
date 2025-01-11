package com.smhrd.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.smhrd.model.JoinRequestDAO;
import com.smhrd.model.JoinRequestVO;
import com.smhrd.model.UserVO;


@WebServlet("/joinRequest")
public class JoinRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserVO user = (UserVO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = user.getUserId();
        int partyIdx = Integer.parseInt(request.getParameter("partyIdx"));
        
        // joinIntro 값이 null 또는 빈 값일 경우 빈 문자열로 설정
        String joinIntro = request.getParameter("joinIntro");
        if (joinIntro == null || joinIntro.trim().isEmpty()) {
            joinIntro = "";  // 빈 문자열로 설정
        }

        JoinRequestVO joinRequest = new JoinRequestVO(userId, partyIdx, joinIntro, 'N');
        JoinRequestDAO dao = new JoinRequestDAO();
        int result = dao.insertJoinRequest(joinRequest);

        if (result > 0) {
            // 신청 완료 후 alert을 띄우고 main.jsp로 리디렉션
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script type='text/javascript'>");
            response.getWriter().println("alert('신청이 완료되었습니다.');");
            response.getWriter().println("window.location.href = 'main.jsp';");
            response.getWriter().println("</script>");
        } else {
            response.getWriter().println("신청 실패");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int partyIdx = Integer.parseInt(request.getParameter("partyIdx"));
        JoinRequestDAO dao = new JoinRequestDAO();
        List<JoinRequestVO> joinRequests = dao.selectJoinRequestsByPartyIdx(partyIdx);

        request.setAttribute("joinRequests", joinRequests);
        request.getRequestDispatcher("partyRoom.jsp").forward(request, response);
    }
}
