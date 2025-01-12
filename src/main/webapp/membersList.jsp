<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <!-- fn 태그 라이브러리 추가 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임방 요청 수락</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/meetingAccept.css"> <!-- CSS 경로 설정 -->
</head>
<body>
    <h2>회원 목록</h2>

    <!-- 오류 메시지가 있을 경우 alert을 통해 사용자에게 알림 -->
    <c:if test="${not empty errorMessage}">
        <script type="text/javascript">
            alert("${errorMessage}");
        </script>
    </c:if>

    <!-- 회원 목록 테이블 -->
    <table>
        <thead>
            <tr>
                <th>회원 ID</th>
                <th>가입 소개</th>
                <th>동의 여부</th>
                <th>가입일</th>
            </tr>
        </thead>
        <tbody>
            <!-- 반복문을 통해 각 회원의 데이터를 출력 -->
            <c:forEach var="request" items="${joinRequests}">
                <tr>
                    <!-- userId 출력 -->
                    <td>${request.userId}</td>
                    
                    <!-- joinIntro 출력, 비어 있으면 "내용 없음" 출력 -->
                    <td>${empty request.joinIntro ? '내용 없음' : request.joinIntro}</td>
                    
                    <!-- agreeYn 출력 -->
                    <td>${request.agreeYn}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="index.jsp">홈으로 돌아가기</a>

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