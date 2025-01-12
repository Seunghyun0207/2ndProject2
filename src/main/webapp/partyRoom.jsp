<%@page import="com.smhrd.model.UserVO"%>
<%@page import="com.smhrd.model.PostVO"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.PartyVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    PartyVO party = (PartyVO) request.getAttribute("party");
    List<PostVO> latestPosts = (List<PostVO>) request.getAttribute("latestPosts");
%>
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
    
        <script>
        // 회원 정보 보기로 이동 (동적으로 렌더링)
        function viewMembers(partyIdx) {
            if (partyIdx) {
                // 서버에 요청을 보냄 (AJAX를 사용)
                fetch('viewMembers?partyIdx=' + partyIdx)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('네트워크 응답에 문제가 있습니다.');
                        }
                        return response.text(); // 응답 데이터를 문자열로 받음
                    })
                    .then(html => {
                        // membersList 부분 업데이트
                        document.getElementById('membersList').innerHTML = html;
                        document.getElementById('membersSection').style.display = 'block';
                    })
                    .catch(error => {
                        alert('회원 정보를 불러오는 중 문제가 발생했습니다.');
                        console.error('Error:', error);
                    });
            } else {
                alert('잘못된 모임 ID입니다.');
            }
        }
    </script>
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
					<%
					    PartyVO partyVO = (PartyVO) request.getAttribute("party");
					    if (party == null) {
					%>
					        <p>모임 정보를 가져올 수 없습니다.</p>
					        <a href="main.jsp">메인 화면으로 돌아가기</a>
					<%
					        return; // JSP 실행 중단
					    }
					%>
					
					<!-- party 객체가 null이 아닌 경우 -->
					<section class="admin-section" id="adminSection">
					    <!-- 수정하기 버튼: partyIdx를 쿼리 파라미터로 전달 -->
					    <a href="editParty.jsp?partyIdx=<%= party.getPartyIdx() %>">
					        <button type="button" id="editButton">수정하기</button>
					    </a>
					
					    <!-- 회원 정보 보기 버튼 -->
					    <form action="viewMembers" method="get">
					        <input type="hidden" name="partyIdx" value="<%= party.getPartyIdx() %>">
					        <button type="submit">회원 정보 보기</button>
					    </form>
					</section>
                </div>
                <%
				    List<UserVO> members = (List<UserVO>) request.getAttribute("members");
				    List<String> introList = (List<String>) request.getAttribute("introList");
				%>

				<% if (members != null && introList != null && !members.isEmpty()) { %>
				    <!-- 가입 신청한 사람이 있는 경우 -->
				    <table border="1" style="width: 50%; margin: auto; text-align: center;">
				        <thead>
				            <tr>
				                <th>이름</th>
				                <th>소개글</th>
				            </tr>
				        </thead>
				        <tbody>
				            <% for (int i = 0; i < members.size(); i++) { %>
				                <tr>
				                    <td><%= members.get(i).getUserName() %></td> <!-- 이름 출력 -->
				                    <td><%= introList.get(i) %></td> <!-- 소개글 출력 -->
				                </tr>
				            <% } %>
				        </tbody>
				    </table>
				<% } else { %>
				    <!-- 가입 신청한 사람이 없는 경우 -->
				    <div style="text-align: center; margin-top: 50px;">
				        <p>가입 신청한 사람이 없습니다.</p>
				    </div>
				<% } %>

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