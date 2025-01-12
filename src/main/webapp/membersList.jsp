<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임방 요청 수락</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/meetingAccept.css"> <!-- CSS 경로 설정 -->
</head>
<body>
    <div class="acceptance-container">
        <h1>모임방 요청 수락</h1>

        <!-- 요청 리스트 -->
        <div id="request-list" class="request-list">
            <!-- 요청 카드가 동적으로 생성됩니다. -->
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const requestList = document.getElementById('request-list');
            const partyIdx = <%= request.getAttribute("partyIdx") %>;  // partyIdx 값

            // 서버에서 데이터를 비동기적으로 받아오기
            fetch(`getJoinRequests?partyIdx=${partyIdx}`)
                .then(response => response.json())
                .then(requests => {
                    // 요청 카드 생성 함수
                    function createRequestCard(request) {
                        const card = document.createElement('div');
                        card.className = 'request-card';

                        card.innerHTML = `
                            <p><strong>아이디:</strong> ${request.userId}</p>
                            <p><strong>이름:</strong> ${request.name}</p>
                            <p><strong>활동 지역:</strong> ${request.region}</p>
                            <p><strong>자기소개글:</strong> ${request.introduction}</p>
                            <p><strong>나이:</strong> ${request.age}</p>
                            <p><strong>작성 시간:</strong> ${request.timestamp}</p>
                            <div class="button-group">
                                <button class="accept-btn" data-action="accept">수락하기</button>
                                <button class="reject-btn" data-action="reject">거절하기</button>
                            </div>
                        `;

                        // 버튼 이벤트 추가
                        card.querySelector('.accept-btn').addEventListener('click', function() {
                            handleRequestAction(request.userId, 'accept', card);
                        });

                        card.querySelector('.reject-btn').addEventListener('click', function() {
                            handleRequestAction(request.userId, 'reject', card);
                        });

                        return card;
                    }

                    // 요청 카드 리스트 렌더링
                    requests.forEach(request => {
                        const card = createRequestCard(request);
                        requestList.appendChild(card);
                    });
                })
                .catch(error => console.error('Error fetching requests:', error));

            // 요청 수락/거절 처리 함수
            function handleRequestAction(userId, action, card) {
                fetch('updateJoinRequestStatus', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ userId, action })
                })
                .then(response => {
                    if (response.ok) {
                    	alert("요청을 " + (action === 'accept' ? '수락' : '거절') + "했습니다.");
                        card.remove();
                    } else {
                        alert('요청 처리 중 오류가 발생했습니다.');
                    }
                })
                .catch(error => console.error('Error processing request:', error));
            }
        });
    </script>


    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }

        .acceptance-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            color: #444;
        }

        .request-list {
            margin-top: 20px;
        }

        .request-card {
            background: #f4f4f4;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .request-card p {
            margin: 5px 0;
        }

        .button-group {
            margin-top: 10px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .accept-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .reject-btn {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .accept-btn:hover {
            background-color: #45a049;
        }

        .reject-btn:hover {
            background-color: #e53935;
        }
    </style>
</body>
</html>