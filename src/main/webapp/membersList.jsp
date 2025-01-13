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
           <c:choose>
    <c:when test="${not empty pendingRequests}">
        <c:forEach var="request" items="${pendingRequests}">
            <tr>
                <td>${request.userId}</td>
                <td>${request.joinIntro}</td>
                <td>
                    <form action="acceptJoinRequest" method="post">
    <input type="hidden" name="partyIdx" value="${partyIdx}">
    <input type="hidden" name="userId" value="${request.userId}">
    <button type="submit">수락</button>
</form>
                    <form action="rejectJoinRequest" method="post" style="display:inline;">
                        <input type="hidden" name="partyIdx" value="${partyIdx}">
                        <input type="hidden" name="userId" value="${request.userId}">
                        <button type="submit">거절</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <tr>
            <td colspan="3">가입 요청이 없습니다.</td>
        </tr>
    </c:otherwise>
</c:choose>
        </tbody>
    </table>

    <br>
    <a href="main.jsp">홈으로 돌아가기</a>

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