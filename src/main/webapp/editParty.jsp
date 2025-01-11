<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임방 수정</title>
    <link rel="stylesheet" href="css/editParty.css">
</head>
<body>

<div class="meeting-edit-container">
    <h2>모임방 수정</h2>

    <div class="meeting-info">
        <label for="partyTitle">모임방 제목</label>
        <input type="text" id="partyTitle" name="partyTitle" value="${party.partyNm}" required>

        <label for="partyDescription">모임방 소개</label>
        <textarea id="partyDescription" name="partyDescription" rows="4" required>${party.partyInfo}</textarea>

        <label for="partyRegion">모임방 지역</label>
        <select id="meeting-location" name="location" required>
            <option value="" disabled selected>지역을 선택해주세요.</option>
              
              <option value="GG">경기도</option>
              <option value="GW">강원도</option>
              <option value="CB">충청북도</option>
              <option value="CN">충청남도</option>
              <option value="GB">경상북도</option>
              <option value="GN">경상남도</option>
              <option value="JB">전라북도</option>
              <option value="JN">전라남도</option>
              <option value="JJ">제주도</option>
        </select>

        <label for="partyImage">모임방 이미지</label>
        <input type="file" id="partyImage" name="partyImage" accept="image/*">

        <label for="partyNotice">공지사항</label>
        <textarea id="partyNotice" name="partyNotice" rows="5">${party.partyNotice}</textarea>
    </div>

    <div class="buttons">
        <button onclick="updateMeeting()">수정하기</button>
        <button onclick="confirmDelete()">삭제하기</button>
        <button onclick="saveChanges()" style="display:none;" id="saveButton">수정완료</button>
    </div>
</div>
 
<script>
    function updateMeeting() {
        // 수정하기 버튼 클릭 시 동작하는 코드
        alert("모임방이 수정되었습니다.");
        document.getElementById("saveButton").style.display = "inline-block"; // 수정완료 버튼 보이기
    }

    function deleteMeeting() {
        // 삭제하기 버튼 클릭 시 동작하는 코드
        let confirmation = confirm("정말로 모임방을 삭제하시겠습니까?");
        if (confirmation) {
            alert("모임방이 삭제되었습니다.");
            // 삭제 로직 추가
        }
    }

    function saveChanges() {
        // 수정완료 버튼 클릭 시 동작하는 코드
        alert("수정 내용이 저장되었습니다.");
        document.getElementById("saveButton").style.display = "none"; // 수정완료 버튼 숨기기
    }
</script>

</body>
</html>
