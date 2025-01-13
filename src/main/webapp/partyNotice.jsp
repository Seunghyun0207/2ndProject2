<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.smhrd.model.UserVO" %>
<%
		HttpSession session2 = request.getSession();
		UserVO user = (UserVO) session2.getAttribute("user"); // session2로 변경
		String partyIdx = (String) request.getAttribute("partyIdx");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 공지 작성</title>
    <link rel="stylesheet" href="css/partyNotice.css">
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58a4a5cfbc781b2348261bdd16809813&libraries=services"></script>
</head>
<body>
    <header>
        <h1>모임 공지 작성</h1>
    </header>

    <main>
        <form action="PartyNoticeProcess" method="post" id="create-notice-form">
            <!-- 유저 ID와 파티 ID를 hidden 필드로 전달 -->
            <input type="hidden" name="userId" value="<%= user != null ? user.getUserId() : "" %>">
            <input type="hidden" name="partyIdx" value="<%= partyIdx != null ? partyIdx : "" %>">
            <input type="hidden" name="latitude" id="latitudeInput">
            <input type="hidden" name="longitude" id="longitudeInput">

            <!-- 공지 제목 -->
            <div>
                <label for="partyTitle">모임 제목:</label>
                <input type="text" id="partyTitle" name="partyTitle" placeholder="공지 제목을 입력하세요" required>
            </div>

            <!-- 공지 내용 -->
            <div>
                <label for="partyDescription">공지 내용:</label>
                <textarea id="partyDescription" name="partyDescription" rows="5" placeholder="공지 내용을 입력하세요" required></textarea>
            </div>

            <!-- 지도와 위치 정보 -->
            <div id="mapContainer">
                <div id="map" style="width:100%; height:400px;"></div>
                <div id="locationInfo" style="margin-top: 10px;">
                    <p>선택한 위치:</p>
                    <p>위도: <span id="latitudeDisplay">미선택</span></p>
                    <p>경도: <span id="longitudeDisplay">미선택</span></p>
                </div>
            </div>

            <!-- 제출 버튼 -->
            <button type="submit">공지 생성</button>
        </form>
    </main>

    <script>
        let currentMarker = null;

        // 지도 초기화
        function initMap() {
            const mapContainer = document.getElementById('map');
            const mapOption = {
                center: new kakao.maps.LatLng(37.5665, 126.9780), // 서울 중심 좌표
                level: 3 // 확대 레벨
            };

            const map = new kakao.maps.Map(mapContainer, mapOption);

            // 지도 클릭 이벤트
            kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
                const latLng = mouseEvent.latLng;
                const lat = latLng.getLat();
                const lng = latLng.getLng();

                // 기존 마커 제거
                if (currentMarker) {
                    currentMarker.setMap(null);
                }

                // 새로운 마커 추가
                currentMarker = new kakao.maps.Marker({
                    position: latLng
                });
                currentMarker.setMap(map);

                // 값 업데이트
                document.getElementById('latitudeInput').value = lat.toFixed(6);
                document.getElementById('longitudeInput').value = lng.toFixed(6);
                document.getElementById('latitudeDisplay').textContent = lat.toFixed(6);
                document.getElementById('longitudeDisplay').textContent = lng.toFixed(6);
            });
        }

        // 폼 제출 시 값 확인
        document.getElementById('create-notice-form').addEventListener('submit', function(event) {
            const latitude = document.getElementById('latitudeInput').value;
            const longitude = document.getElementById('longitudeInput').value;

            if (!latitude || !longitude) {
                alert("지도를 클릭하여 위치를 선택해주세요.");
                event.preventDefault();
            }
        });

        // 지도 초기화 호출
        initMap();
    </script>
</body>
</html>
