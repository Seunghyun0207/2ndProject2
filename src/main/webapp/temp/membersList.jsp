<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <h1>회원들 정보</h1>
    <table>
        <thead>
            <tr>
                <th>회원 ID</th>
                <th>회원 이름</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="member" items="${members}">
                <tr>
                    <td>${member.userName}</td>
                    <td>${introList[loop.index]}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>