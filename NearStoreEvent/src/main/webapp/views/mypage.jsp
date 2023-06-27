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
<title>���������� : �츮�����̺�Ʈ</title>

</head>
<body>
    <%
    pageContext.include("header.jsp"); 
    %>
    
        <div class="content">
          <div class="sidenav">
           	<h2>����������</h2>
             <a href="mypage.jsp">�� ����</a>
             <a href="mypage_myStore.jsp">�� ����</a>
             <a href="mypage_myEvent.jsp">�� �̺�Ʈ</a>
          </div>
          <div class="myInfo">
          	<h1>�� ����</h1>
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
<!-- menu : ���, ���� �Ǵ� ���� ������ ���� �Ű������� �̿� -->
<input type=hidden name="menu" value="update">
<!-- ���� �Ǵ� ������ ���� �Խ� id�� hidden���� ���� -->
<input type=hidden name="user_id" value=<%=user_id %>>

<table border="1">
	<tr>
		<td>ID</td>
		<td>
			<input type=text name=id value="<%=id %>" maxlength=50 >
		</td>
	</tr>
	<tr>
		<td>��й�ȣ</td>
		<td>
			<input type=password name=password value="<%=password %>" maxlength=255 >
		</td>
	</tr>
	<tr>
		<td>����</td>
		<td>
			<input type=text name=name value="<%=name %>" maxlength=50 >
		</td>
	</tr>
	<tr>
		<td>�г���</td>
		<td>
			<input type=text name=nickname value="<%=nickname %>" maxlength=100 >
		</td>
	</tr>
	<tr>
		<td>�̸���</td>
		<td>
			<input type=text name=email value="<%=email %>" maxlength=100 >
		</td>
	</tr>
	
   	
</table>
	<input type=button value="�����Ϸ�" onClick="updateUser()">
	<input type=button value="Ż���ϱ�" onClick="deleteUser()">
</form>
          </div>     
          
        </div>

    <footer>
        <div class="footer-container">
            <div class="footer-info">
                <p>���������� ������Ʈ</p>
                <p>mhhu200@naver.com</p>
                <p>��2023. HyeongwookCho. all rights reserved. </p>
            </div>
        </div>
    </footer>
</body>
</html>
