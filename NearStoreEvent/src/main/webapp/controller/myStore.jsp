<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
    <div>
        <% String sessionId = (String) session.getAttribute("id"); %>
        <% if(sessionId != null) {
        	%>
        	<div>
        	<input type="button" value="�� ���� ����ϱ�" onclick="location.href='../views/storeForm.jsp'">
        </div>
        <%
           } else {
            
        } %>
    </div>
</body>
</html>