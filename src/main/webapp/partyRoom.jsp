<%@page import="com.smhrd.model.UserVO"%>
<%@page import="com.smhrd.model.PostVO"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.PartyVO"%>
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
                        <p>${party.partyInfo}</p>
                    </section>

                    <!-- 모임 공지사항 섹션 -->
                    <section class="meeting-notices">
                        <h2>모임 공지사항</h2>
							<p> ${party.partyNotice}</p>
                    </section>

                    <!-- 관리자 전용 버튼 섹션 -->
                    <% 
                        PartyVO party = (PartyVO) request.getAttribute("party");
                        UserVO user = (UserVO) session.getAttribute("user");
                    %>

                    <!-- 방장이면 수정하기 버튼과 회원 정보 보기 버튼을 보여준다 -->
                    <% if (party != null && user != null && user.getUserId().equals(party.getUserId())) { %>
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
                    <% } %>

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
    
    
	 <script>
	        // tabs
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
	        }
	
	        // 📸 게시물 추가 기능
	        document.getElementById('addPost').addEventListener('click', function () {
	            const fileInput = document.getElementById('imageUpload');
	            const textInput = document.getElementById('postText');
	            const postList = document.querySelector('.post-list');
	
	            if (fileInput.files.length > 0) {
	                const file = fileInput.files[0];
	                const reader = new FileReader();
	
	                reader.onload = function (e) {
	                    const imageUrl = e.target.result;
	                    const textContent = textInput.value || '사용자 게시물입니다.';
	
	                    // 게시물 생성
	                    const newPost = document.createElement('li');
	                    newPost.innerHTML = `
	                        <div class="post">
	                            <img src="${imageUrl}" alt="사용자 이미지" class="post-image">
	                            <p class="post-text">${textContent}</p>
	                        </div>
	                    `;
	                    postList.appendChild(newPost);
	
	                    // 입력 필드 초기화
	                    fileInput.value = '';
	                    textInput.value = '';
	                };
	
	                reader.readAsDataURL(file);
	            } else {
	                alert('이미지를 선택해주세요!');
	            }
	        });
	
	        // [중략] 이하의 JavaScript 코드 생략
	    </script>

    
</body>
</html>