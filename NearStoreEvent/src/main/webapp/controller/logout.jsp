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
    session.invalidate(); //���� �����Ͽ� �α׾ƿ�
    response.sendRedirect("../views/main.jsp"); // �α׾ƿ� �� main.jsp�� �̵�
%>
</body>
</html>