<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
    session.invalidate(); //세션 종료하여 로그아웃
    response.sendRedirect("../views/main.jsp"); // 로그아웃 후 main.jsp로 이동
%>
</body>
</html>