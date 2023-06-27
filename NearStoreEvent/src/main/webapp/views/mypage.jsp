<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="../static/css/style.css?after">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script language=JavaScript src="../static/js/mypage.js" charset="utf-8"></script>
<link rel="stylesheet" href="../static/css/mypage.css?after">
<title>마이페이지 : 우리동네이벤트</title>

</head>
<body>
    <%
    pageContext.include("header.jsp"); 
    %>
    
        <div class="content">
          <div class="sidenav">
           	<h2>마이페이지</h2>
             <a href="mypage.jsp">내 정보</a>
             <a href="mypage_myStore.jsp">내 가게</a>
             <a href="mypage_myEvent.jsp">내 이벤트</a>
          </div>
          <div class="myInfo">
          	<h1>내 정보</h1>
	<jsp:useBean id="usr" class="javabean.user.UserEntity" scope="page" />
    <jsp:useBean id="usrdb" class="javabean.user.UserDAO" scope="page" />
	
	<%
		String id = "";
		String password = "";
		String name = "";
		String nickname = "";
		String email = "";
		
		int user_id = (Integer) session.getAttribute("user_id");
        usr = usrdb.getUser(user_id);
			
		id = usr.getId();
		password = usr.getPassword();
		name = usr.getName();
		nickname = usr.getNickname();
		email = usr.getEmail();
		user_id = usr.getUser_id();

	%>
<form name=mypageform method=post action="../controller/mypageUserProcess.jsp" >
<!-- menu : 등록, 수정 또는 삭제 구분을 위한 매개변수로 이용 -->
<input type=hidden name="menu" value="update">
<!-- 수정 또는 삭제를 위한 게시 id를 hidden으로 전송 -->
<input type=hidden name="user_id" value=<%=user_id %>>

<table border="1">
	<tr>
		<td>ID</td>
		<td>
			<input type=text name=id value="<%=id %>" maxlength=50 >
		</td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td>
			<input type=password name=password value="<%=password %>" maxlength=255 >
		</td>
	</tr>
	<tr>
		<td>성함</td>
		<td>
			<input type=text name=name value="<%=name %>" maxlength=50 >
		</td>
	</tr>
	<tr>
		<td>닉네임</td>
		<td>
			<input type=text name=nickname value="<%=nickname %>" maxlength=100 >
		</td>
	</tr>
	<tr>
		<td>이메일</td>
		<td>
			<input type=text name=email value="<%=email %>" maxlength=100 >
		</td>
	</tr>
	
   	
</table>
	<input type=button value="수정완료" onClick="updateUser()">
	<input type=button value="탈퇴하기" onClick="deleteUser()">
</form>
          </div>     
          
        </div>

    <footer>
        <div class="footer-container">
            <div class="footer-info">
                <p>웹서버구축 프로젝트</p>
                <p>mhhu200@naver.com</p>
                <p>ⓒ2023. HyeongwookCho. all rights reserved. </p>
            </div>
        </div>
    </footer>
</body>
</html>
