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
		//한글 처리를 위해 문자인코딩 지정
		request.setCharacterEncoding("euc-kr");
		//수정(update), 삭제(delete) 중 하나를 저장
	 	String menu = request.getParameter("menu"); 
		int user_id = Integer.parseInt
				(request.getParameter("user_id"));
		int store_id = strdb.getStoreId(user_id);
		int event_id = evdb.getEventId(user_id);
		
		if ( menu.equals("delete") ) {
			if(event_id == -1 && store_id == -1){
				usrdb.deleteDB(user_id);
			}else if(event_id == -1 && store_id != -1){
				strdb.deleteDB(store_id);
				usrdb.deleteDB(user_id);
			}else{
				evdb.deleteDB(event_id);
				strdb.deleteDB(store_id);
				usrdb.deleteDB(user_id);
			}
			%>
			<script>
			    alert("탈퇴가 완료되었습니다.");
			    // 삭제가 완료된 후 mypage.jsp로 리디렉션
			    location.href = "logout.jsp";
			</script>
			<%
			
		} else if( menu.equals("update") ){
		%>
		<!-- 수정 시 지정하는 필드 -->
		<jsp:setProperty name="usr" property="id" />
		<jsp:setProperty name="usr" property="password" />
		<jsp:setProperty name="usr" property="name" />
		<jsp:setProperty name="usr" property="nickname" />
		<jsp:setProperty name="usr" property="email" />
		<jsp:setProperty name="usr" property="location" />
		<jsp:setProperty name="usr" property="user_id" />
		<%
		usrdb.updateDB(usr);
		%>
		<script>
			alert("수정이 완료되었습니다.");
			location.href = "../views/mypage.jsp";
		</script>
		<%
		}else {
			// update나 delete가 아닐 때 에러 페이지로 이동
			response.sendRedirect("../views/error.jsp");
		}
		%>
</body>
</html>