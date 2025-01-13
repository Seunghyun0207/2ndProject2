package com.smhrd.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.LocationDAO;
import com.smhrd.model.LocationVO;

@WebServlet("/partyNoticeView")
public class PartyNoticeViewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 파라미터에서 partyIdx 가져오기
        String partyIdxStr = request.getParameter("partyIdx");
        if (partyIdxStr == null || partyIdxStr.isEmpty()) {
            response.sendRedirect("main.jsp?error=missingPartyIdx");
            return;
        }

        try {
            int partyIdx = Integer.parseInt(partyIdxStr);

            // DAO를 통해 위치 데이터를 가져옴
            LocationDAO dao = new LocationDAO();
            List<LocationVO> locationList = dao.getLocationsByPartyIdx(partyIdx);

            // JSP로 데이터 전달
            request.setAttribute("locationList", locationList);
            request.setAttribute("partyIdx", partyIdx); // partyIdx 전달

            // partyRoom.jsp로 포워딩
            request.getRequestDispatcher("partyRoom.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("main.jsp?error=invalidPartyIdx");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("main.jsp?error=exception");
        }
    }
}
