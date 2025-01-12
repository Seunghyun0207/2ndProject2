<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>유동회관 모임</title>
    <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/partyRoom.css">
    <style>
        h1 {
            font-family: 'East Sea Dokdo', cursive;
            color: white;
            font-size: 60px;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        }
    </style>
    <style>
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
    <!-- 카카오 맵 API 추가 -->
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58a4a5cfbc781b2348261bdd16809813&libraries=services"></script>

</head>
<body>
    <div id="app" class="wrapper" v-cloak v-bind:class="{'is-previous': isPreviousSlide, 'first-load': isFirstLoad}">
        <h1 class="site-name">유동회관모임</h1>

        <!-- about -->
        <div class="about">
            <a class="bg_links social portfolio" href="<%= request.getContextPath() %>./myPage.jsp">
                <span class="icon"></span>
            </a>
            <a class="bg_links social linkedin" href="<%= request.getContextPath() %>./login.jsp">
                <span class="icon"></span>
            </a>
            <a class="bg_links logo"></a>
        </div>
        <!-- end about -->

        <section id="wrapper">
            <div class="content">
                <!-- Tab links -->
                <div class="tabs">
                    <button class="tablinks active" data-country="Meeting1"><p>홈</p></button>
                    <button class="tablinks" data-country="Board1"><p>피드</p></button>
                    <button class="tablinks" data-country="Event1"><p>갤러리</p></button>
                    <button class="tablinks" data-country="Notice1"><p>모임 위치</p></button>
                </div>

                <!-- Tab content -->
                <div class="wrapper_tabcontent">
                    <div id="Meeting1" class="tabcontent active">
                        <!-- 모임 소개 섹션 -->
                        <section>
                            <img src="<%= request.getContextPath() %>/images/7.jpg">
                        </section>

                        <section class="meeting-introduction">
                            <h2>모임 소개</h2>
                            <p>중장년들을 위한 지역 기반 SNS입니다.</p>
                        </section>

                        <!-- 모임 공지사항 섹션 -->
                        <section class="meeting-notices">
                            <h2>모임 공지사항</h2>
                            <ul>
                                <li>다음 모임 날짜: <%= new java.util.Date() %></li>
                                <li>모임 장소: 순천 스마트인재발원</li>
                                <li>이번 달 주제 도서: 프로젝트 준비</li>
                            </ul>
                        </section>

                        <!-- 관리자 전용 버튼 섹션 -->
                        <section class="admin-section" id="adminSection">
                            <button id="editButton">수정하기</button>
                            <button id="membersButton">회원들 정보</button>
                        </section>
                    </div>

                    <div id="Board1" class="tabcontent">
                        <!-- 피드 게시물 표시 -->
                        <div class="feed-item" id="post1">
                            <div class="feed-header">
                                <div class="user-info">
                                    <img src="<%= request.getContextPath() %>/images/11.jpg" alt="User photo" class="user-photo">
                                    <span class="user-name">sunggwon</span>
                                </div>
                                <span class="feed-date">2025-01-08</span>
                            </div>
                            <div class="feed-content">
                                <h3>게시글 제목</h3>
                                <p>✨성권이의 블로그✨</p>
                                <img src="<%= request.getContextPath() %>/images/10.jpg" alt="Post image" class="feed-image">
                            </div>
                            <div class="feed-actions">
                                <button class="like-button" onclick="likePost(1)">좋아요❤️ 0</button>
                                <button class="share-button" onclick="sharePost(1)">공유하기</button>
                                <button class="edit-button" onclick="editPost(1)">수정하기</button>
                            </div>
                        </div>
                    </div>

                    <div id="Event1" class="tabcontent">
                        <div class="post-header">
                            <div class="profile-pic-wrapper">
                                <img class="profile-pic" src="<%= request.getContextPath() %>/images/7.jpg" alt="Profile" />
                            </div>
                        </div>
                    </div>

                    <div id="Notice1" class="tabcontent">
                        <div id="mapContent"></div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <script>
        // Tabs script
        var tabLinks = document.querySelectorAll(".tablinks");
        var tabContent = document.querySelectorAll(".tabcontent");

        tabLinks.forEach(function(el) {
            el.addEventListener("click", openTabs);
        });

        function openTabs(el) {
            var btnTarget = el.currentTarget;
            var country = btnTarget.dataset.country;

            tabContent.forEach(function(el) {
                el.classList.remove("active");
            });

            tabLinks.forEach(function(el) {
                el.classList.remove("active");
            });

            document.querySelector("#" + country).classList.add("active");
            btnTarget.classList.add("active");

            // "모임 위치" 탭 클릭 시 지도 로드
            if (country === "Notice1") {
                loadMapContent();
            }
        }

        function loadMapContent() {
            const mapContent = document.getElementById("mapContent");

            if (mapContent.innerHTML.trim() === "") {
                console.log("Fetching kakaomap...");
                mapContent.innerHTML = `
                    <div id="map" style="width:100%; height:400px;"></div>
                `;
                initMap(37.5665, 126.9780); // 서울시청 좌표 예시
            }
        }

        // 지도 초기화 함수
        function initMap(lat, lng) {
            var mapContainer = document.getElementById('map'); // 지도 div
            var mapOption = {
                center: new kakao.maps.LatLng(lat, lng), // 중심 좌표
                level: 3 // 지도 확대 레벨
            };
            var map = new kakao.maps.Map(mapContainer, mapOption);
        }
    </script>
</body>
</html>
