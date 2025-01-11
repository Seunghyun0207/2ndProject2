<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Frosted Glass Login Form</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel='stylesheet' href='https://fonts.googleapis.com/css2?family=Heebo:wght@100;200;300&display=swap'>
  <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/login.css">
</head>
<body>
<div class="scene flex">
  <section class="card">
    <figure class="card__figure">
      <img class="card__image" src="images/3.png" alt="온도차이"/>
      <figcaption>
        <span class="visually-hidden">photo</span>
      </figcaption>
    </figure>
    <h1 class="card__heading">
      <span class="visually-hidden">Account name:</span>
      <span>온도차이</span>
    </h1>
    <form class="card__form" action="loginProcess" method="post">
      <label for="userId" class="visually-hidden">ID:</label>
      <input id="userId" name="userId" class="card__input" type="text" placeholder="아이디를 입력하세요" required/><br>

      <label for="userPw" class="visually-hidden">Password:</label>
      <input id="userPw" name="userPw" class="card__input" type="password" placeholder="비밀번호를 입력하세요" required/><br>
	<div id="errorMessage" class="error hidden">로그인 정보가 올바르지 않습니다.</div>
		
      <div class="button-container">
        <button class="card__button" type="submit">
          <span>로그인</span>
        </button>
        <button class="card__button" type="button" onclick="location.href='register.jsp'">
          <span>회원가입</span>
        </button>
      </div>
    </form>
  </section>
</div>
</body>
</html>