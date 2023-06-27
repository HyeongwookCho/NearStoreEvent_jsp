<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../static/css/loginandregi.css">
    <script language=JavaScript src="../static/js/signupform.js" charset="utf-8"></script>
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1:700" rel="stylesheet">
    <title>회원가입 : 우리동네 이벤트소식</title>

</head>
<body>
    <main>
      <h1>우리동네 이벤트<br>회원가입</h1>
      <form action="../controller/signupProcess.jsp" method=POST onsubmit="onSubmitForm(event)">
 
        <label for="id">ID</label>
        <input type="text" id="id" name="id" required>
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>

        <label for="password_check">Password 확인</label>
        <input type="password" id="password_check" name="password_check" required onblur="checkPassword()">

        <label for="name">성명</label>
        <input type="text" id="name" name="name" required>

        <label for="nickname">닉네임</label>
        <input type="text" id="nickname" name="nickname" required>

        <label for="email">이메일</label>
        <input type="email" id="email" name="email" required>

        <button type="button" onclick="goMain()">메인으로 돌아가기</button>

        <button type="submit">가입하기</button>
      </form>
    </main>
  </body>
</html>