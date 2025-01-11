<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임방 생성</title>
    <link rel="stylesheet" href="css/createParty.css">
</head>
<body>
    <!-- 헤더 -->
    <header>
        <nav>
            <button onclick="location.href='myPage.jsp'">마이페이지</button>
            <button onclick="location.href='logoutProcess'">로그아웃</button>
        </nav>
    </header>

    <div class="create-meeting-container">
        <h1>모임방 생성</h1>
        <main>
            <form action="createPartyProcess" method="post" enctype="multipart/form-data" id="create-meeting-form">
                <!-- 모임 제목 -->
                <div class="form-group">
                    <label for="partyTitle">모임방 제목</label>
                    <input type="text" id="partyTitle" name="partyTitle" placeholder="모임방 제목을 입력하세요" required>
                </div>

                <!-- 모임 소개 -->
                <div class="form-group">
                    <label for="partyDescription">모임방 소개</label>
                    <textarea id="partyDescription" name="partyDescription" rows="5" placeholder="모임방 소개를 입력하세요" required></textarea>
                </div>

                <!-- 이미지 업로드 -->
                <div class="form-group">
                    <label for="partyImage">모임방 이미지</label>
                    <input type="file" id="partyImage" name="partyImage" accept="image/*">
                </div>

                <!-- 모임 지역 -->
                <div class="form-group">
                    <label for="partyRegion">모임방 지역</label>
                    <select id="partyRegion" name="partyRegion" required>
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
            <div>
                <button onclick="location.href='main.jsp'">뒤로 가기</button>
            </div>
        </main>

        <script>
            document.getElementById('create-meeting-form').addEventListener('submit', function(event) {
                const title = document.getElementById('partyTitle').value;
                const description = document.getElementById('partyDescription').value;
                const location = document.getElementById('partyRegion').value;
                const image = document.getElementById('partyImage').files[0];
                const imageName = image ? image.name : "이미지 없음";

                if (!location) {
                    alert('지역을 선택해주세요.');
                    event.preventDefault(); // 제출 중단
                    return;
                }

                // 디버깅 용 메시지
                alert(`모임방 생성 요청!\n제목: ${title}\n소개: ${description}\n지역: ${location}\n이미지: ${imageName}`);
            });
        </script>
    </div>
</body>
</html>
