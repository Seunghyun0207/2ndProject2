<%@page import="com.smhrd.model.PartyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.smhrd.model.PartyVO" %>
<%
    // partyIdx를 URL 파라미터에서 받아옴
    String partyIdxParam = request.getParameter("partyIdx");
    PartyDAO partyDAO = new PartyDAO();

    if (partyIdxParam != null && !partyIdxParam.isEmpty()) {
        int partyIdx = Integer.parseInt(partyIdxParam);
        // partyIdx로 모임 정보를 가져옴
        PartyVO party = partyDAO.selectPartyById(partyIdx);
        request.setAttribute("party", party);  // party 객체를 JSP에 전달
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임방 수정</title>
    <link rel="stylesheet" href="css/editParty.css">
</head>
<body>

<!-- about -->
    <div class="about">
        <a class="bg_links social portfolio" href="./myPage.jsp">
            <span class="icon"></span>
        </a>
       
        <a class="bg_links social linkedin" href="./login.jsp">
            <span class="icon"></span>
        </a>
        <a class="bg_links logo"></a>
    </div>
    
    <div class="home-button-container">
		        <a href="http://localhost:8081/2ndProject/main.jsp" class="home-button">Home</a>
		    </div>
		    <div id="app" class="wrapper" v-cloak v-bind:class="{'is-previous': isPreviousSlide, 'first-load': isFirstLoad}">
		        <!-- 나머지 코드 -->
		    </div>
    
			<div class="meeting-edit-container">
			    <h2>모임방 수정</h2>

    <div class="meeting-info">
        <!-- 수정 폼 -->
		<form id="editPartyForm" action="editPartyProcess" method="POST" enctype="multipart/form-data">
		    <input type="hidden" name="partyIdx" value="${param.partyIdx}"> <!-- partyIdx를 hidden 필드로 설정 -->
            
            <label for="partyTitle">모임방 제목</label>
            <input type="text" id="partyTitle" name="partyTitle" value="${party.partyNm}" required>

            <label for="partyRegion">모임방 지역</label>
            <select id="meeting-location" name="partyRegion" required>
                <option value="GG" ${party.partyRegion == 'GG' ? 'selected' : ''}>경기도</option>
                <option value="GW" ${party.partyRegion == 'GW' ? 'selected' : ''}>강원도</option>
                <option value="CB" ${party.partyRegion == 'CB' ? 'selected' : ''}>충청북도</option>
                <option value="CN" ${party.partyRegion == 'CN' ? 'selected' : ''}>충청남도</option>
                <option value="GB" ${party.partyRegion == 'GB' ? 'selected' : ''}>경상북도</option>
                <option value="GN" ${party.partyRegion == 'GN' ? 'selected' : ''}>경상남도</option>
                <option value="JB" ${party.partyRegion == 'JB' ? 'selected' : ''}>전라북도</option>
                <option value="JN" ${party.partyRegion == 'JN' ? 'selected' : ''}>전라남도</option>
                <option value="JJ" ${party.partyRegion == 'JJ' ? 'selected' : ''}>제주도</option>
            </select>

            <label for="partyImage">모임방 이미지</label>
            <input type="file" id="partyImage" name="partyImage" accept="image/*">
        
            <label for="partyDescription">모임방 소개</label>
            <textarea id="partyDescription" name="partyDescription" rows="4" required>${party.partyInfo}</textarea>

            <label for="partyNotice">공지사항</label>
            <textarea id="partyNotice" name="partyNotice" rows="5">${party.partyNotice}</textarea>
        </form>
    </div>

    <div class="buttons">
        <button type="button" onclick="confirmUpdate()">수정하기</button>
        <button type="button" id="deleteButton" data-partyidx="${party.partyIdx}" onclick="confirmDelete(this)">삭제하기</button>
        <button style="display:none;" id="saveButton" onclick="submitForm()">수정완료</button>
    </div>

<script>
    function confirmUpdate() {
        // "수정하기" 버튼 클릭 시, 사용자 확인
        let confirmation = confirm("변경 사항을 저장하시겠습니까?");
        if (confirmation) {
            document.getElementById("saveButton").style.display = "inline-block"; // 수정완료 버튼 보이기
            document.getElementById("editPartyForm").submit(); // 폼 제출
        }
    }

    function confirmDelete(buttonElement) {
        // 버튼에서 partyIdx 값 추출
        let partyIdx = buttonElement.getAttribute("data-partyidx");

        // "삭제하기" 버튼 클릭 시, 사용자 확인
        let confirmation = confirm("정말로 이 모임을 삭제하시겠습니까?");
        if (confirmation) {
            // 삭제 후 리디렉션
            window.location.href = "deletePartyProcess?partyIdx=" + partyIdx;
        }
    }


    function submitForm() {
        // "수정완료" 버튼 클릭 시 폼 제출
        document.getElementById("editPartyForm").submit(); // 폼 제출
    }
</script>

</body>
</html>
