<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>우동소 로그인하기!</title>
    <link rel="stylesheet" href="../static/css/loginandregi.css">
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1:700" rel="stylesheet">
</head>

<body>
    <main>
        <div class="logo">우리 동네 소식</div>
        <div class="login-box">
            <form action="../controller/loginProcess.jsp" method=POST> <label for="id">아이디</label>
                <input type="text" id="id" name="id" required>
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" required>
					<button onclick="location.href='main.jsp'">메인으로 돌아가기</button>
                    <button type="submit">로그인</button>
            </form>
            <div class="login-links">
                <a href="#">비밀번호 찾기</a>
                <a href="#">아이디 찾기</a>
                <a href="signupForm.jsp">회원 가입</a>
            </div>
        </div>
    </main>
</body>

</html>

