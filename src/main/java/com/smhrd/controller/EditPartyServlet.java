package com.smhrd.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.smhrd.model.PartyDAO;
import com.smhrd.model.PartyVO;

@WebServlet("/editPartyProcess")
@MultipartConfig
public class EditPartyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // UTF-8로 인코딩 처리
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=UTF-8");

            // 파라미터 받기
            String partyIdxStr = request.getParameter("partyIdx");
            if (partyIdxStr == null || partyIdxStr.isEmpty()) {
                throw new IllegalArgumentException("partyIdx 파라미터가 누락되었습니다.");
            }

            int partyIdx = Integer.parseInt(partyIdxStr);
            String partyTitle = request.getParameter("partyTitle");
            String partyDescription = request.getParameter("partyDescription");
            String partyRegion = request.getParameter("partyRegion");
            String partyNotice = request.getParameter("partyNotice");

            // 이미지 파일 처리
            Part partyImagePart = request.getPart("partyImage");
            String fileName = null;
            if (partyImagePart != null && partyImagePart.getSize() > 0) {
                fileName = Paths.get(partyImagePart.getSubmittedFileName()).getFileName().toString();
                partyImagePart.write("C:/upload/" + fileName);
            }

            // PartyVO 객체 생성
            PartyVO party = new PartyVO(partyIdx, partyTitle, partyDescription, partyRegion, fileName, null);

            // DB 업데이트
            PartyDAO partyDAO = new PartyDAO();
            int result = partyDAO.updateParty(party);  // 업데이트 처리

            if (result > 0) {
                response.sendRedirect("main.jsp");  // 성공 시 해당 방으로 리디렉션
            } else {
                request.setAttribute("errorMsg", "수정에 실패했습니다.");
                request.getRequestDispatcher("editParty.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "수정 처리 중 오류가 발생했습니다.");
        }
    }
}