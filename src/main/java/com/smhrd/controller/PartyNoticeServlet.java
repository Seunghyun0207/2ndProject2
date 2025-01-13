package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.LocationDAO;
import com.smhrd.model.LocationVO;
import com.smhrd.model.UserVO;


@WebServlet("/PartyNoticeProcess")
public class PartyNoticeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserVO user = (UserVO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String l_post_nm = request.getParameter("partyTitle");
            String l_post_content = request.getParameter("partyDescription");
            String latitudeStr = request.getParameter("latitude");
            String longitudeStr = request.getParameter("longitude");
            String partyIdxStr = request.getParameter("partyIdx");

            System.out.println("PartyNoticeServlet - partyTitle: " + l_post_nm);
            System.out.println("PartyNoticeServlet - partyDescription: " + l_post_content);
            System.out.println("PartyNoticeServlet - latitude: " + latitudeStr);
            System.out.println("PartyNoticeServlet - longitude: " + longitudeStr);
            System.out.println("PartyNoticeServlet - partyIdx: " + partyIdxStr);
            System.out.println("PartyNoticeServlet - userId: " + user.getUserId());

            double latitude = (latitudeStr != null && !latitudeStr.isEmpty()) ? Double.parseDouble(latitudeStr) : 0.0;
            double longitude = (longitudeStr != null && !longitudeStr.isEmpty()) ? Double.parseDouble(longitudeStr) : 0.0;
            int party_idx = Integer.parseInt(partyIdxStr);

            LocationVO location = new LocationVO();
            location.setL_post_nm(l_post_nm);
            location.setL_post_content(l_post_content);
            location.setLatitude(latitude);
            location.setLongitude(longitude);
            location.setUser_id(user.getUserId());
            location.setParty_idx(party_idx);

            LocationDAO dao = new LocationDAO();
            boolean isSuccess = dao.insertLocationPost(location);

            if (isSuccess) {
                response.sendRedirect("partyRoom.jsp?partyIdx=" + party_idx);
            } else {
                response.sendRedirect("partyNotice.jsp?error=fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("partyNotice.jsp?error=exception");
        }
    }
}
