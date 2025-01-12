<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 공지</title>
    <link rel="stylesheet" href="css/createParty.css">
    <style>
        h1 {
            font-family: 'East Sea Dokdo', cursive;
            color: white;
            font-size: 60px;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        }
        .post {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #fff;
        }
        .post img {
            max-width: 100%;
            border-radius: 5px;
            margin-top: 10px;
        }
        .post-actions {
            display: flex;
            justify-content: space-around;
            margin-top: 10px;
        }
        .post-actions button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #007bff;
            color: white;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .post-actions button:hover {
            background-color: #0056b3;
        }
    </style>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58a4a5cfbc781b2348261bdd16809813&libraries=services"></script>
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
        <h1>모임 공지</h1>
        <main>
            <form action="createPartyProcess" method="post" enctype="multipart/form-data" id="create-meeting-form">
                <!-- 모임 공지 제목 -->
                <div class="form-group">
                    <label for="partyTitle">모임 날짜 & 시간</label>
                    <input type="text" id="partyTitle" name="partyTitle" placeholder="모임 날짜와 시간을 입력하세요" required>
                </div>

                <!-- 모임 공지 안내 -->
                <div class="form-group">
                    <label for="partyDescription">모임 안내</label>
                    <textarea id="partyDescription" name="partyDescription" rows="5" placeholder="모임에 대한 안내사항을 입력하세요." required></textarea>
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

                <!-- 모임 위치 섹션 -->
                <div id="mapContent" style="margin-top: 20px;">
                    <div id="map" style="width:100%; height:400px;"></div>
                    <div id="location-info" style="padding: 10px; background-color: #f0f0f0; margin-top: 10px;">
                        <p>위도: <span id="latitude">0</span></p>
                        <p>경도: <span id="longitude">0</span></p>
                        <p>주소: <span id="address">주소가 여기에 표시됩니다.</span></p>
                    </div>
                </div>

                <!-- 모임 공지 생성 버튼 -->
                <div class="form-group">
                    <button type="submit" id="create-meeting-btn">모임 공지 생성</button>
                </div>
            </form>
            <div>
                <button onclick="location.href='main.jsp'">뒤로 가기</button>
            </div>
        </main>

        <script>
            // 지도 초기화 함수
            let currentMarker = null;

            function initMap(lat = 37.5665, lng = 126.9780) {
                var mapContainer = document.getElementById('map');
                var mapOption = {
                    center: new kakao.maps.LatLng(lat, lng),
                    level: 3
                };
                var map = new kakao.maps.Map(mapContainer, mapOption);
                var geocoder = new kakao.maps.services.Geocoder();

                kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
                    var latLng = mouseEvent.latLng;
                    var lat = latLng.getLat();
                    var lng = latLng.getLng();

                    if (currentMarker) currentMarker.setMap(null);

                    currentMarker = new kakao.maps.Marker({ position: latLng });
                    currentMarker.setMap(map);

                    document.getElementById("latitude").textContent = lat;
                    document.getElementById("longitude").textContent = lng;

                    geocoder.coord2Address(lng, lat, function(result, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            document.getElementById("address").textContent = result[0].address.address_name;
                        }
                    });
                });
            }

            initMap();
        </script>
    </div>
</body>
</html>
