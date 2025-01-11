<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임방 생성</title>
    <link rel="stylesheet" href="css/createParty.css">
</head>
<body>
    <div class="create-meeting-container">
        <h1>모임방 생성</h1>
        
        <form id="create-meeting-form">
            <!-- 모임 제목 -->
            <div class="form-group">
                <label for="meeting-title">모임방 제목</label>
                <input type="text" id="meeting-title" name="title" placeholder="모임방 제목을 입력하세요" required>
            </div>

            <!-- 모임 소개 -->
            <div class="form-group">
                <label for="meeting-description">모임방 소개</label>
                <textarea id="meeting-description" name="description" rows="4" placeholder="모임방 소개를 입력하세요" required></textarea>
            </div>

            <!-- 이미지 업로드 -->
            <div class="form-group">
                <label for="meeting-image">모임방 이미지</label>
                <input type="file" id="meeting-image" name="image" accept="image/*" required>
            </div>

            <!-- 모임 지역 -->
            <div class="form-group">
                <label for="meeting-location">모임방 지역</label>
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
            </div>

            <!-- 방 생성 버튼 -->
            <div class="form-group">
                <button type="submit" id="create-meeting-btn">방 생성</button>
            </div>
        </form>
    </div>

    <script>
    document.getElementById('create-meeting-form').addEventListener('submit', function(event) {
        event.preventDefault(); // 폼 제출을 막고, 아래 로직을 실행합니다.

        // 입력 값 가져오기
        const title = document.getElementById('meeting-title').value;
        const description = document.getElementById('meeting-description').value;
        const location = document.getElementById('meeting-location').value;
        const image = document.getElementById('meeting-image').files[0];

        // 방 생성 처리 (예시로 alert으로 모임 정보 출력)
        alert(`모임방 생성 완료!\n제목: ${title}\n소개: ${description}\n지역: ${location}\n이미지: ${image.name}`);

        // 방 생성 후 해당 모임방 페이지로 이동 (예시 URL로 이동)
        window.location.href = "http://localhost:8081/main/dist/index.html";  // 실제 페이지 주소로 변경 필요
    });
    </script>

</body>
</html>