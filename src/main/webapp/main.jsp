<%@page import="com.smhrd.model.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
UserVO user = (UserVO) session.getAttribute("user");
if (user == null) {
	// 로그인되지 않은 경우 로그인 페이지로 이동
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>유동회관</title>
<link
	href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/main.css">
<!-- 이 순서 중요! 위치변동x -->
<style>
h1 {
	font-family: 'East Sea Dokdo', cursive;
	color: white;
	font-size: 60px;
	text-align: center;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
}

/* 공통 스타일 */
.party-item {
	border: 1px solid #ccc;
	padding: 10px;
	margin: 10px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.3s ease;
}

/* 마우스를 올렸을 때 스타일 */
.party-item:hover {
	background-color: #f0f0f0;
	transform: scale(1.02); /* 약간 확대 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
}
</style>


<!-- 모임 찾기 AJAX -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
        // 모임 찾기 버튼 클릭 시 AJAX 호출
    function findParty() {
        $.ajax({
            url: '<%=request.getContextPath()%>/findPartyProcess',
            method: 'GET',
            success: function(response) {
                var partyList = response;

                console.log("응답 데이터:", partyList);

                var partyHtml = '';

                if (partyList.length === 0) {
                    partyHtml = '<p>등록된 모임이 없습니다.</p>';
                } else {
                    for (var i = 0; i < partyList.length; i++) {
                        var party = partyList[i];
                        // party-item 전체를 클릭 가능하도록 설정
                        partyHtml += '<div class="party-item" onclick="redirectToJoinParty(\'' + party.partyIdx + '\')">';
                        partyHtml += '<p><strong>모임 이름: </strong>' + party.partyNm + '</p>';
                        partyHtml += '<p><strong>지역: </strong>' + party.partyRegion + '</p>';
                        partyHtml += '<p><strong>작성자: </strong>' + party.userId + '</p>';
                        partyHtml += '<p><strong>생성일: </strong>' + party.createdAt + '</p>';
                        partyHtml += '</div>';
                    }
                }

                $('#partyList').html(partyHtml);
            },
            error: function(xhr, status, error) {
                console.log("AJAX 오류:", error);
                alert('모임 찾기 실패');
            }
        });
    }

    // 가입 페이지로 이동하는 함수
    function redirectToJoinParty(partyIdx) {
        window.location.href = '<%=request.getContextPath()%>/partyDetailProcess?partyIdx=' + partyIdx;
    }

    // 나의 모임 버튼 클릭 시 데이터 로드
    function loadMyParties() {
        $.ajax({
            url: '<%=request.getContextPath()%>/myParties',
            method: 'GET',
            success: function(response) {
                var myParties = response;

                var myPartyHtml = '';

                if (myParties.length === 0) {
                    myPartyHtml = '<p>참여한 모임이 없습니다.</p>';
                } else {
                    for (var i = 0; i < myParties.length; i++) {
                        var party = myParties[i];
                        myPartyHtml += '<div class="party-item" onclick="redirectToPartyRoom(\'' + party.partyIdx + '\')">';
                        myPartyHtml += '<p><strong>모임 이름: </strong>' + party.partyNm + '</p>';
                        myPartyHtml += '<p><strong>지역: </strong>' + party.partyRegion + '</p>';
                        myPartyHtml += '<p><strong>작성자: </strong>' + party.userId + '</p>';
                        myPartyHtml += '<p><strong>생성일: </strong>' + party.createdAt + '</p>';
                        myPartyHtml += '</div>';
                    }
                }

                $('#myPartyList').html(myPartyHtml);
            },
            error: function(xhr, status, error) {
                console.log("AJAX 오류:", error);
                alert('나의 모임 조회 실패');
            }
        });
    }

    // partyRoom으로 리다이렉트하는 함수 추가
    function redirectToPartyRoom(partyIdx) {
        window.location.href = '<%=request.getContextPath()%>/partyRoomProcess?partyIdx=' + partyIdx;
    }

    document.addEventListener("DOMContentLoaded", function() {
        // 모임 찾기 버튼 클릭 이벤트
        document.querySelector("[data-country='FindMeeting']").addEventListener('click', findParty);

        // 나의 모임 버튼 클릭 이벤트
        document.querySelector("[data-country='Meeting']").addEventListener('click', loadMyParties);
    });
    
    // partyIdx를 제대로 전달하도록 JavaScript를 수정
    function redirectToPartyRoom(partyIdx) {
        if (partyIdx) {
            window.location.href = '<%= request.getContextPath() %>/partyRoomProcess?partyIdx=' + partyIdx;
        } else {
            alert('잘못된 모임 ID입니다.');
        }
    }
    </script>

<!-- "나의 모임" 탭 콘텐츠 -->
<div id="Meeting" class="tabcontent">
	<!-- 검색 바 -->
	<div class="search-bar">
		<input type="text" id="my-party-search" placeholder="모임 제목을 검색하세요..." />
		<button id="my-party-search-btn">검색</button>
	</div>

	<!-- 나의 모임 리스트 출력 영역 -->
	<div id="myPartyList">
		<!-- AJAX로 데이터가 로드되면 여기에 표시됩니다 -->
	</div>
</div>



</head>
<body>
	<div id="app" class="wrapper" v-cloak
		v-bind:class="{'is-previous': isPreviousSlide, 'first-load': isFirstLoad}">
		<h1 class="site-name">온도차이</h1>

		<!-- about -->
		<div class="about">
			<a class="bg_links social portfolio"
				href="https://www.rafaelalucas.com" target="_blank"> <span
				class="icon"></span>
			</a> <a class="bg_links social dribbble"
				href="https://dribbble.com/rafaelalucas" target="_blank"> <span
				class="icon"></span>
			</a> <a class="bg_links social linkedin"
				href="https://www.linkedin.com/in/rafaelalucas/" target="_blank">
				<span class="icon"></span>
			</a> <a class="bg_links logo"></a>
		</div>


		<section id="wrapper">
			<div class="content">
				<!-- Tab links -->
				<div class="tabs">
					<button class="tablinks" data-country="FindMeeting"
						onclick="findParty()">
						<p data-title="FindMeeting">모임 찾기</p>
					</button>
					<button class="tablinks active" data-country="Meeting">
						<p data-title="Meeting">나의모임</p>
					</button>
					<button class="tablinks" data-country="Board">
						<p data-title="Board">피드</p>
					</button>
					<button class="tablinks" data-country="Event">
						<p data-title="Event">이벤트</p>
					</button>
					<button class="tablinks" data-country="Notice">
						<p data-title="Notice">공지사항</p>
					</button>

				</div>


				<!-- 모임 찾기 -->
				<div id="FindMeeting" class="tabcontent">
					<div class="search-bar">
						<input type="text" id="search-input" placeholder="모임 제목을 검색하세요..." />
						<button id="search-btn">검색</button>
					</div>

					<!-- 모임 생성 -->
					<div class="create-meeting-btn-container">
						<form action="<%=request.getContextPath()%>/createPartyForm"
							method="get">
							<button type="submit" class="btn btn-success"
								id="create-meeting-btn">모임 생성</button>
						</form>
					</div>

					<!-- 모임 불러오기 -->
					<div class="meeting-item">
						<div class="photo">
							<img src="./images/1.png" alt="모임 사진 1">
						</div>
						<div id="partyList" class="details"></div>
					</div>
				</div>

				<!-- Tab content -->
				<div id="Meeting" class="tabcontent active">
					<!-- 검색 바 -->
					<div class="search-bar">
						<input type="text" id="search-input" placeholder="모임 제목을 검색하세요..." />
						<button id="search-btn">검색</button>
					</div>

					<!-- 피드 모임 항목 -->
					<div class="meeting-item">
						<div class="photo">
							<img src="./images/9.jpg" alt="모임 사진 1">
						</div>
						<div class="details">
							<p>제목</p>
						</div>
					</div>

				</div>

				<div id="Board" class="tabcontent">
					<div class="feed-header">
						<div class="user-info">
							<img src="user-photo.jpg" alt="User photo" class="user-photo">
							<span class="user-name">John Doe</span>
						</div>
						<span class="feed-date">2025-01-07</span>
					</div>
					<div class="feed-content">
						<p>This is a post content.</p>
						<img src="post-image.jpg" alt="Post image" class="feed-image">
					</div>
					<div class="feed-actions">
						<button class="like-button" onclick="toggleLike()">좋아요❤️</button>
						<button class="share-button" onclick="sharePost()">공유하기</button>
					</div>
					<div class="comments-section">
						<div class="comment-input-container">
							<input type="text" class="comment-input"
								placeholder="댓글을 남겨주세요..." id="commentInput">
							<button class="comment-submit" onclick="submitComment()">댓글
								달기</button>
						</div>
						<div class="comments-list" id="commentsList">
							<!-- 댓글이 여기에 표시됩니다 -->
						</div>
					</div>
					<br> <br> <br>
					<div class="feed-header">
						<div class="user-info">
							<img src="user-photo.jpg" alt="User photo" class="user-photo">
							<span class="user-name">John Doe</span>
						</div>
						<span class="feed-date">2025-01-07</span>
					</div>
					<div class="feed-content">
						<p>This is a post content.</p>
						<img src="post-image.jpg" alt="Post image" class="feed-image">
					</div>
					<div class="feed-actions">
						<button class="like-button">좋아요❤️</button>
						<button class="share-button">공유하기</button>
					</div>
					<div class="comments-section">
						<div class="comment-input-container">
							<input type="text" class="comment-input"
								placeholder="댓글을 남겨주세요..." id="commentInput">
							<button class="comment-submit" onclick="submitComment()">댓글
								달기</button>
						</div>
						<div class="comments-list" id="commentsList">
							<!-- 댓글이 여기에 표시됩니다 -->
						</div>
					</div>
				</div>

				<div id="Event" class="tabcontent">
					<div class="event-board">
						<div class="event-item">
							<h3 class="event-title">이벤트 제목</h3>
							<p class="event-date">2025-01-07</p>
							<p class="event-location">이벤트 장소: 스마트인재개발원</p>
							<p class="event-content">출석 열심히 하면 "하이오 커피" 쿠폰 제공.</p>
						</div>
					</div>
				</div>

				<div id="Notice" class="tabcontent">
					<div class="notice-board">
						<div class="notice-item">
							<h3 class="notice-title">공지사항 제목</h3>
							<p class="notice-date">2025-01-07</p>
							<p class="notice-content">업데이트 중입니다.</p>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
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

// 
// 탭 전환 기능
function openTab(evt, tabName) {
    var i, tabcontent, tablinks;
    
    // 모든 tabcontent를 숨김
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].classList.remove("active");
    }

    // 모든 tablinks에서 active 클래스를 제거
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].classList.remove("active");
    }

    // 선택된 탭만 보이게 하고 활성화 클래스를 추가
    document.getElementById(tabName).classList.add("active");
    evt.currentTarget.classList.add("active");
}

// 검색 버튼 클릭 시 동작 (추가적인 기능 예시)
document.getElementById('search-btn').addEventListener('click', function() {
    var searchTerm = document.getElementById('search-input').value;
    console.log("검색어: ", searchTerm);
    // 실제 검색 로직을 이곳에 작성하면 됩니다.
});

// 좋아요 버튼 상태 토글
let isLiked = false;
function toggleLike() {
    isLiked = !isLiked;
    const likeButton = document.querySelector('.like-button');
    if (isLiked) {
        likeButton.textContent = "💖 좋아요 취소";
    } else {
        likeButton.textContent = "👍 좋아요";
    }
}

// 댓글 달기 기능
function submitComment() {
    const commentInput = document.getElementById('commentInput');
    const commentText = commentInput.value.trim();

    if (commentText !== "") {
        const commentsList = document.getElementById('commentsList');
        const newComment = document.createElement('div');
        newComment.className = 'comment-item';
        newComment.textContent = commentText;
        commentsList.appendChild(newComment);
        commentInput.value = ""; // 댓글 입력란 비우기
    }
}

// 공유하기 버튼 기능
function sharePost() {
    alert("게시물이 공유되었습니다!"); // 실제 공유 기능은 추가로 구현 필요
}

document.getElementById('create-meeting-btn').addEventListener('click', function() {
    // 모임 생성 폼을 띄우는 코드 (예: alert 창 또는 다른 방식으로 모임 생성 화면을 보여줄 수 있습니다)
    alert('모임 생성 화면으로 이동합니다!');
    
    // 실제 모임 생성 폼을 띄우려면 아래와 같은 방법을 사용할 수 있습니다:
    // window.location.href = '/create-meeting-page';
});
</script>
	<script src="main.js" defer></script>
</body>
</html>