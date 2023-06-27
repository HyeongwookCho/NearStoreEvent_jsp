<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="../static/css/admin.css?after">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.util.ArrayList,javabean.user.UserEntity,java.text.SimpleDateFormat" %>
	<jsp:useBean id="usrdb" class="javabean.user.UserDAO" scope="page" />
	
	<%
		
		ArrayList<UserEntity> list = usrdb.getUserList(); 
	   	int counter = list.size();
	   	int row = 0;
		//한글 처리를 위해 문자인코딩 지정
		request.setCharacterEncoding("euc-kr");
		
		String searchId = request.getParameter("searchId");
	
        if (searchId != null && !searchId.isEmpty()) {
            ArrayList<UserEntity> filteredList = new ArrayList<UserEntity>();
            for (UserEntity usr : list) {
                if (usr.getId().contains(searchId)) {
                    filteredList.add(usr);
                }
            }
            list = filteredList;
        }
		
		if (counter > 0) {
	%>
	<h1>관리자 모드</h1>
	<h2>우리동네이벤트 정보 관리 사이트</h2>
	<form method="POST" action="../views/adminUserList.jsp">
	  <input type="text" name="searchId" placeholder="아이디 검색">
	  <input type="submit" value="검색">
	</form>
	<table border="1">
		<tr>
			<th>user_id</th>
			<th>id</th>
			<th>password</th>
			<th>name</th>
			<th>nickname</th>
			<th>email</th>
			<th>created_at</th>
		</tr>
		<%
			for(UserEntity usr : list) {
		%>
		<tr>
			<td><a href="../views/editUser.jsp?user_id=<%= usr.getUser_id()%>"><%=usr.getUser_id()%></a></td>
			<td><%=usr.getId()%></td>
			<td><%=usr.getPassword()%></td>
			<td><%=usr.getName()%></td>
			<td><%=usr.getNickname()%></td>
			<td><%=usr.getEmail()%></td>
			<td><%=usr.getCreated_at()%></td>
		</tr>
		<%
	    }
		%>
	</table>
	<%
	} 
	%>
</body>
</html>