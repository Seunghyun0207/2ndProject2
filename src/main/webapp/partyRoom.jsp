<%@page import="com.smhrd.model.UserVO"%>
<%@page import="com.smhrd.model.PostVO"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.PartyVO"%>
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
    <div id="app" class="wrapper">
        <h1 class="site-name">유동회관모임</h1>
        <div class="about">
            <a class="bg_links social portfolio" href="<%= request.getContextPath() %>/myPage.jsp">
                <span class="icon"></span>
            </a>
            <a class="bg_links social linkedin" href="<%= request.getContextPath() %>/login.jsp">
                <span class="icon"></span>
            </a>
            <a class="bg_links logo"></a>
        </div>

        <section id="wrapper">
            <div class="content">
                <div class="tabs">
                    <button class="tablinks active" data-country="Meeting1">홈</button>
                    <button class="tablinks" data-country="Board1">피드</button>
                    <button class="tablinks" data-country="Event1">갤러리</button>
                    <button class="tablinks" data-country="Notice1">모임 위치</button>
                </div>

                <div class="wrapper_tabcontent">
                    <div id="Meeting1" class="tabcontent active">
                        <section>
                            <img src="<%= request.getContextPath() %>/images/7.jpg" alt="Meeting">
                        </section>
                        <section class="meeting-introduction">
                            <h2>모임 소개</h2>
                            <p>${party.partyInfo}</p>
                        </section>
                        <section class="meeting-notices">
                            <h2>모임 공지사항</h2>
                            <p>${party.partyNotice}</p>
                        </section>
                        <% 
                            PartyVO party = (PartyVO) request.getAttribute("party");
                            UserVO user = (UserVO) session.getAttribute("user");
                        %>
                        <% if (party != null && user != null && user.getUserId().equals(party.getUserId())) { %>
                        <section class="admin-section" id="adminSection">
                            <a href="editParty.jsp?partyIdx=<%= party.getPartyIdx() %>">
                                <button type="button" id="editButton">수정하기</button>
                            </a>
                            <form action="viewMembers" method="get">
                                <input type="hidden" name="partyIdx" value="<%= party.getPartyIdx() %>">
                                <button type="submit">회원 정보 보기</button>
                            </form>
                        </section>
                        <% } %>
                    </div>

                    <div id="Board1" class="tabcontent">
                        <div class="feed-item">
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
                                <button onclick="likePost(1)">좋아요❤️ 0</button>
                                <button onclick="sharePost(1)">공유하기</button>
                                <button onclick="editPost(1)">수정하기</button>
                            </div>
                            <div class="comments-section">
                                <div class="comment-input-container">
                                    <input type="text" class="comment-input" placeholder="댓글을 남겨주세요..." id="commentInput1">
                                    <button class="comment-submit" onclick="submitComment(1)">댓글 달기</button>
                                </div>
                                <div class="comments-list" id="commentsList1">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="Event1" class="tabcontent">
                        <div class="post-header">
                            <img class="profile-pic" src="<%= request.getContextPath() %>/images/7.jpg" alt="Profile">
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
                   <div id="location-info" style="padding: 10px; background-color: #f0f0f0; margin-top: 10px;">
                       <p>위도: <span id="latitude">0</span></p>
                       <p>경도: <span id="longitude">0</span></p>
                   </div>
               `;
               initMap(37.5665, 126.9780); // 서울시청 좌표 예시
           }
       }
   
       // 지도 초기화 함수
       // 전역 변수로 마커 선언
      let currentMarker = null;
      
      function initMap(lat, lng) {
          var mapContainer = document.getElementById('map'); // 지도 div
          var mapOption = {
              center: new kakao.maps.LatLng(lat, lng), // 중심 좌표
              level: 3 // 지도 확대 레벨
          };
          var map = new kakao.maps.Map(mapContainer, mapOption);
      
          // 클릭 시 마커 추가하고 위도, 경도 표시
          kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
              var latLng = mouseEvent.latLng; // 클릭한 위치의 위도, 경도
              var lat = latLng.getLat();
              var lng = latLng.getLng();
      
              // 기존 마커가 있으면 삭제
              if (currentMarker) {
                  currentMarker.setMap(null); // 마커 삭제
              }
      
              // 새로운 마커 추가
              currentMarker = new kakao.maps.Marker({
                  position: latLng
              });
              currentMarker.setMap(map);
      
              // 위도, 경도 표시
              document.getElementById("latitude").textContent = lat;
              document.getElementById("longitude").textContent = lng;
          });
      }

   </script>
    