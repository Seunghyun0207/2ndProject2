<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Frosted Glass Login Form</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel='stylesheet' href='https://fonts.googleapis.com/css2?family=Heebo:wght@100;200;300&display=swap'>
  <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/login.css">
  <style>
    /* 초기 화면에 애니메이션을 적용할 클래스 */
    .animation-screen {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.7);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 9999;
      animation: fadeInOut 3s forwards; /* 애니메이션 3초 */
    }

    /* 애니메이션 정의 */
    @keyframes fadeInOut {
      0% { opacity: 1; }
      50% { opacity: 0.7; }
      100% { opacity: 0; }
    }

    /* 카드(로그인 폼) 숨김 */
    .card {
      display: none;
    }
  </style>
</head>
<body>
  <!-- 애니메이션 화면 -->
  <div id="animationScreen" class="animation-screen">
    <h1 style="color: white;">청</h1>
    <h3 style="color: white;">춘은</h3>
    <h1 style="color: white;">바</h1>
    <h3 style="color: white;">로</h3>
    <h1 style="color: white;">지</h1>
    <h3 style="color: white;">금</h3>
  </div>

  <!-- 로그인 폼 -->
  <div class="scene flex">
    <section class="card">
      <figure class="card__figure">
        <img class="card__image" src="./images/blue.png" alt="" />
        <figcaption>
          <span class="visually-hidden">photo</span>
        </figcaption>
      </figure>
      <h1 class="card__heading">
        <span class="visually-hidden">Account name:</span>
        <span>청바지</span>
      </h1>
      <form class="card__form" action="loginProcess" method="post">
        <label for="userId" class="visually-hidden">ID:</label>
        <input id="userId" name="userId" class="card__input" type="text" placeholder="아이디를 입력하세요" required /><br>

        <label for="userPw" class="visually-hidden">Password:</label>
        <input id="userPw" name="userPw" class="card__input" type="password" placeholder="비밀번호를 입력하세요" required /><br>

        <div id="errorMessage" class="error hidden">로그인 정보가 올바르지 않습니다.</div>
        
        <div class="button-container">
          <button class="card__button" type="submit">
            <span class="main-text">로그인</span>
          </button>
          <button class="card__button" type="button" onclick="location.href='register.jsp'">
            <span class="secondary-text">회원가입</span>
          </button>
        </div>
      </form>
    </section>
  </div>

  <script>
    // 애니메이션이 끝난 후 로그인 폼 보이기
    window.onload = function () {
      setTimeout(function () {
        // 애니메이션 화면 숨기기
        document.getElementById('animationScreen').style.display = 'none';

        // 로그인 폼 보이기
        document.querySelector('.card').style.display = 'block';
      }, 3000); // 애니메이션이 끝난 후 3초 뒤에 실행
    };
  </script>
</body>
</html>
