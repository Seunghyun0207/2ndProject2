<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가입 신청</title>
    <link rel="stylesheet" href="css/joinRequestForm.css">
</head>
<body>
    <div class="signup-container">
        <!-- 한 줄 소개 -->
        <div class="intro-container">
            <label for="intro">자기소개</label>
            <textarea id="intro" name="joinIntro" placeholder="자기소개를 입력하세요" required></textarea>
        </div>
        
        <!-- 신청 버튼 -->
        <div class="submit-container">
            <form action="joinRequest" method="post">
                <input type="hidden" name="partyIdx" value="${partyIdx}">
                <button type="submit" id="submit-btn">신청하기</button>
            </form>
        </div>
    </div>
    <script>
    function joinRequest() {
        alert('신청이 완료되었습니다!');
        // 여기에 가입 로직을 추가할 수 있습니다.
    }
    </script>

    <script>
    document.getElementById("submit-btn").addEventListener("click", function(event) {
        const introValue = document.getElementById("intro").value;
        if (!introValue.trim()) {
            event.preventDefault();
            alert("자기소개를 입력해주세요.");
        } else {
            document.getElementById("hiddenIntro").value = introValue;
        }
    });
    </script>
    
    
</body>
</html>
