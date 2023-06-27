<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="str" class="javabean.store.StoreEntity" scope="page" />
	<jsp:useBean id="strdb" class="javabean.store.StoreDAO" scope="page" />
	<jsp:useBean id="usr" class="javabean.user.UserEntity" scope="page" />
	<jsp:useBean id="usrdb" class="javabean.user.UserDAO" scope="page" />
	<jsp:useBean id="ev" class="javabean.event.EventEntity" scope="page" />
    <jsp:useBean id="evdb" class="javabean.event.EventDAO" scope="page" />

	<% 
		//�ѱ� ó���� ���� �������ڵ� ����
		request.setCharacterEncoding("euc-kr");
		//����(update), ����(delete) �� �ϳ��� ����
	 	String menu = request.getParameter("menu"); 
	 	int user_id = Integer.parseInt
				(request.getParameter("user_id"));
		int store_id = strdb.getStoreId(user_id);
		int event_id = evdb.getEventId(user_id);
		
		if ( menu.equals("delete") ) {
			if(event_id == -1 && store_id != -1){
				strdb.deleteDB(store_id);
			}else{
				evdb.deleteDB(event_id);
				strdb.deleteDB(store_id);
			}
			%>
			<script>
			    alert("������ �Ϸ�Ǿ����ϴ�.");
			    // ������ �Ϸ�� �� mypage.jsp�� ���𷺼�
			    location.href = "../views/mypage.jsp";
			</script>
			<%
			
		} else if( menu.equals("update") ){
		%>
		<!-- ���� �� �����ϴ� �ʵ� -->
		<jsp:setProperty name="str" property="name" />
	    <jsp:setProperty name="str" property="number" />
	    <jsp:setProperty name="str" property="location" />
	    <jsp:setProperty name="str" property="category" />
	    <jsp:setProperty name="str" property="reg_num" />
	    <jsp:setProperty name="str" property="user_id" />
		<%
		strdb.updateDB(str);
		%>
		<script>
			alert("������ �Ϸ�Ǿ����ϴ�.");
			location.href = "../views/mypage_myStore.jsp";
		</script>
		<%
		}else {
			// update�� delete�� �ƴ� �� ���� �������� �̵�
			response.sendRedirect("../views/error.jsp");
		}
		%>
</body>
</html>