<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>유동회관 모임</title>
    <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/partyRoom.css"> <!-- CSS 경로 설정 -->
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
</head>
<body>
    <div id="app" class="wrapper" v-cloak v-bind:class="{'is-previous': isPreviousSlide, 'first-load': isFirstLoad}">
        <h1 class="site-name">유동회관모임</h1>

    <!-- about -->
    <div class="about">
        <a class="bg_links social portfolio" href="https://www.rafaelalucas.com" target="_blank">
            <span class="icon"></span>
        </a>
        <a class="bg_links social dribbble" href="https://dribbble.com/rafaelalucas" target="_blank">
            <span class="icon"></span>
        </a>
        <a class="bg_links social linkedin" href="https://www.linkedin.com/in/rafaelalucas/" target="_blank">
            <span class="icon"></span>
        </a>
        <a class="bg_links logo"></a>
    </div>
    <!-- end about -->

    <section id="wrapper">
        <div class="content">
            <!-- Tab links -->
            <div class="tabs">
                <button class="tablinks active" data-country="Meeting1"><p data-title="Meeting1">홈</p></button>
                <button class="tablinks" data-country="Board1"><p data-title="Board1">피드</p></button>
                <button class="tablinks" data-country="Event1"><p data-title="Event1">갤러리</p></button>
                <button class="tablinks" data-country="Notice1"><p data-title="Notice1">모임 위치</p></button>
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
                            <li>다음 모임 날짜: 2025년 1월 7일 (화요일)</li>
                            <li>모임 장소: 순천 스마트인재발원</li>
                            <li>이번 달 주제 도서: 프로젝트 준비</li>
                        </ul>
                    </section>

                    <!-- 관리자 전용 버튼 섹션 -->
				    <section class="admin-section" id="adminSection">
				        <button id="editButton">수정하기</button>
				        <form action="viewMembers" method="get" style="display:inline;">
				            <input type="hidden" name="partyIdx" value="${partyIdx}">
				            <button id="membersButton" type="submit">회원들 정보</button>
				        </form>
				    </section>
                </div>

                <div id="Board1" class="tabcontent">
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
                    <div class="comments-section">
                        <div class="comment-input-container">
                            <input type="text" class="comment-input" placeholder="댓글을 남겨주세요..." id="commentInput1">
                            <button class="comment-submit" onclick="submitComment(1)">댓글 달기</button>
                        </div>
                        <div class="comments-list" id="commentsList1">
                            <!-- 댓글들이 여기에 추가됩니다 -->
                        </div>
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
                    <!-- 카카오톡 API자리 -->
                </div>
            </div>
        </div>
    </section>

    <script src="<%= request.getContextPath() %>/partyRoom.js"></script> <!-- JS 경로 설정 -->
</body>
</html>