<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css2?family=Heebo:wght@100;200;300&amp;display=swap'>
    <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/join.css">
</head>

<body>
    <div id="signup-modal" class="modal hidden">
        <div class="modal-content">
          <h2>회원가입</h2>
          
          <form action="registerProcess" method="post" class="signup-form">
            <input type="text" id="userName" name="userName" placeholder="이름을 입력하세요" required />
            
            <div class="id-container">
              <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required />
              <button type="button" class="duplicate-check" onclick="checkDuplicateId()">중복확인</button>
            </div>
            <input type="password" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요" required />
            <input type="date" id="userAge" name="userAge" placeholder="나이를 입력하세요" required />
            
            <select id="userGender" name="userGender" required>
              <option value="" disabled selected>성별을 선택해주세요.</option>
              <option value="M">남성</option>
              <option value="F">여성</option>
            </select>
           
           <select id="userRegion" name="userRegion" required>
  		   <option value="" disabled selected>지역을 선택해주세요.</option>
              
              <option value="GG">경기도</option>
              <option value="GW">강원도</option>
              <option value="CB">충청북도</option>
              <option value="CN">충청남도</option>
              <option value="GB">경상북도</option>
              <option value="GN">경상남도</option>
              <option value="JB">전라북도</option>
              <option value="JN">전라남도</option>
              <option value="JJ">제주도</option>
            </select>

            <button class="card__button" type="submit">
              <span>회원가입</span>
            </button>
          </form>
        </div>
      </div>

      <script>
      const signupButton = document.querySelector('.card__button:nth-child(2)');
      const signupModal = document.getElementById('signup-modal');
      const closeModal = document.querySelector('.close-btn');

      signupButton.addEventListener('click', () => {
        signupModal.classList.remove('hidden');
      });

      closeModal.addEventListener('click', () => {
        signupModal.classList.add('hidden');
      });

      window.addEventListener('click', (e) => {
        if (e.target === signupModal) {
          signupModal.classList.add('hidden');
        }
      });
      </script>
</body>
</html>
