<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Gothic+A1:700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua:400" rel="stylesheet">
<style>
    /* 로고 스타일 추가 */
    nav{
    	font-family: 'Gothic A1', sans-serif;
    }
    .nav_bar_logo a {
        
        font-weight: bold;
        text-decoration: none;
        color: #fff;
    }
    .nav_bar_logo{
    	
    	font-size: 30px;
    	font-weight: bold;
    }
    .myid{
    	font-weight:bold;
    }
</style>

</head>
<body>
	<nav class="nav_bar">
    <div class="nav_bar_logo">
        <a href="main.jsp">우리동네 이벤트소식 <span class="emoji-gift">🎁</span></a>
    </div>
    
    <div class="nav_bar_signup">
    
        <% String sessionId = (String) session.getAttribute("id");
        	request.setCharacterEncoding("UTF-8");
        %>
        <% if(sessionId == null) { %>
        	<a href="loginForm.jsp">Login</a> &nbsp;&nbsp;&nbsp;&nbsp;
            <a href="signupForm.jsp">Sign up</a>
        <% } else { %>
        	<span class="myid" style="color:white"><%= sessionId %>님</span> &nbsp;&nbsp;&nbsp;&nbsp;
        	<a class="mypage" href="mypage.jsp">마이페이지</a>&nbsp;&nbsp;&nbsp;&nbsp;
	        <a class="mypage" href="storeForm.jsp">내 가게 등록하기</a>&nbsp;&nbsp;&nbsp;&nbsp;
	        <a class="mypage" href="eventForm.jsp" >이벤트 등록하기</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="../controller/logout.jsp">Logout</a>&nbsp;&nbsp;&nbsp;&nbsp;
	        
        <% } %>
    </div>
</nav>
</body>
</html>