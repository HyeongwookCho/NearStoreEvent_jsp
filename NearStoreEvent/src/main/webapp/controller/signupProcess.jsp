<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <jsp:useBean id="usr" class="javabean.user.UserEntity" scope="page" />
    <jsp:useBean id="usrdb" class="javabean.user.UserDAO" scope="page" />

    <%
        //한글 처리를 위해 문자인코딩 지정
        request.setCharacterEncoding("UTF-8");
    %>
    <jsp:setProperty name="usr" property="id" />
    <jsp:setProperty name="usr" property="password" />
    <jsp:setProperty name="usr" property="name" />
    <jsp:setProperty name="usr" property="nickname" />
    <jsp:setProperty name="usr" property="email" />

    <%
        // 중복 ID check
        boolean isIdDuplicate = usrdb.isIdExists(usr.getId());

        if (isIdDuplicate) {
    %>
            <script>
                alert("중복된 아이디입니다. 다시 입력해주세요.");
                location.href="../views/signupForm.jsp";
            </script>
    <%
        } else {
            // 중복 검사를 통과할 시! 회원 정보 삽입
            usrdb.insertDB(usr);
            %>
             <script>
                alert('회원가입이 완료되었습니다.');
                location.href="../views/main.jsp";  
            </script>
            <%
        }
    %>
</body>
</html>
