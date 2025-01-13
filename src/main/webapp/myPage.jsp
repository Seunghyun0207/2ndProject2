<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="css/myPage.css">
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
    
<div class="mypage-container">
    <h2>마이페이지</h2>

    <div class="user-info">
        <label for="username">이름:</label>
        <input type="text" id="username" value="<%= "John Doe" %>" disabled> <!-- 수정 불가능 -->

        <label for="userId">아이디:</label>
        <input type="text" id="userId" value="<%= "john123" %>" disabled> <!-- 수정 불가능 -->

        <label for="age">나이:</label>
        <input type="text" id="age" value="<%= 50 %>" disabled> <!-- 수정 불가능 -->

        <label for="nickname">닉네임:</label>
        <input type="text" id="nickname" value="<%= "Johnny" %>" disabled> <!-- 수정 가능 -->

        <label for="location">지역:</label>
        <select id="location" name="location" required>
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

        <label for="password">비밀번호:</label>
        <input type="password" id="password" value="<%= "******" %>" disabled> <!-- 수정 가능 -->
    </div>

    <div class="buttons">
        <button onclick="enableEdit()">수정하기</button>
        <button onclick="deleteAccount()">삭제하기</button>
        <button onclick="saveChanges()" style="display:none;" id="saveButton">수정완료</button>
    </div>

    <!-- 고객센터 -->
    <div class="customer-service">
        <h3>고객센터</h3>
        <button onclick="contactSupport()">문의하기</button>
        <button onclick="reportIssue()">신고하기</button>
        <button onclick="blockUser()">차단하기</button>
        <button onclick="deleteAccount()">계정탈퇴</button>
    </div>
</div>

<script>
// 초기 사용자 정보 (예시)
let user = {
    username: "김성권",   // 수정 불가능
    userId: "john123",      // 수정 불가능
    age: 50,                // 수정 불가능
    nickname: "Johnny",     // 수정 가능
    location: "전라남도",       // 수정 가능
    password: "******"      // 수정 가능
};

// 로그인된 사용자 정보 보여주기
window.onload = function() {
    document.getElementById("username").value = user.username;
    document.getElementById("userId").value = user.userId;
    document.getElementById("age").value = user.age;
    document.getElementById("nickname").value = user.nickname;
    document.getElementById("location").value = user.location;
    document.getElementById("password").value = user.password;
}

// 수정하기 버튼 클릭 시 입력 가능하게 만들기
function enableEdit() {
    document.getElementById("nickname").disabled = false;  // 닉네임은 수정 가능
    document.getElementById("location").disabled = false;  // 지역은 수정 가능
    document.getElementById("password").disabled = false;  // 비밀번호는 수정 가능

    // 수정완료 버튼 보이기
    document.getElementById("saveButton").style.display = "inline-block";
}

// 수정완료 버튼 클릭 시 정보 저장
function saveChanges() {
    user.nickname = document.getElementById("nickname").value;
    user.location = document.getElementById("location").value;
    user.password = document.getElementById("password").value;

    // 수정불가 상태로 변경
    document.getElementById("nickname").disabled = true;
    document.getElementById("location").disabled = true;
    document.getElementById("password").disabled = true;

    // 수정완료 버튼 숨기기
    document.getElementById("saveButton").style.display = "none";

    alert("정보가 수정되었습니다.");
}

// 삭제하기 버튼 클릭 시 회원 삭제
function confirmDelete(buttonElement) {
    // "삭제하기" 버튼 클릭 시, 사용자 확인
    let confirmation = confirm("정말로 이 모임을 삭제하시겠습니까?");
    if (confirmation) {
        let partyIdx = buttonElement.getAttribute("data-partyidx");
        // 서버로 삭제 요청 전송
        window.location.href = "deletePartyProcess?partyIdx=" + partyIdx;  // 삭제 후 리디렉션
    }
}
</script>

</body>
</html>
