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
	<%@ page import="java.text.SimpleDateFormat" %>
	<%@ page import="java.sql.Date"%>
	<%@ page import="java.sql.Date"%>
	<%@ page import="java.text.ParseException" %>
	
	<% 
		//한글 처리를 위해 문자인코딩 지정
		request.setCharacterEncoding("euc-kr");
		//수정(update), 삭제(delete) 중 하나를 저장
	 	String menu = request.getParameter("menu"); 
		int user_id = Integer.parseInt
				(request.getParameter("user_id"));
		int store_id = strdb.getStoreId(user_id);
		int event_id = evdb.getEventId(user_id);
		

		
		//유저 정보
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		
		//가게 정보
		String s_name = request.getParameter("s_name");
		String s_number = request.getParameter("s_number");
		String s_location = request.getParameter("s_location");
		String s_category = request.getParameter("s_category");
		String s_reg_num = request.getParameter("s_reg_num");
		
		//이벤트 정보
		String e_title = request.getParameter("e_title");
		String e_content = request.getParameter("e_content");
		String e_image_path = request.getParameter("e_image_path");
		String period_start = request.getParameter("e_period_start");
		String period_end = request.getParameter("e_period_end");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date tempPeriodStart;
		java.util.Date tempPeriodEnd;

		try {
		    tempPeriodStart = dateFormat.parse(period_start);
		} catch(ParseException e) {
		    tempPeriodStart = new java.util.Date(0L); // 기본 날짜로 설정
		}

		try {
		    tempPeriodEnd = dateFormat.parse(period_end);
		} catch(ParseException e) {
		    tempPeriodEnd = new java.util.Date(0L); // 기본 날짜로 설정
		}

		java.sql.Date e_period_start = new java.sql.Date(tempPeriodStart.getTime());
		java.sql.Date e_period_end = new java.sql.Date(tempPeriodEnd.getTime());

		
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
			    alert("삭제가 완료되었습니다.");
			    // 삭제가 완료된 후 adminUserList.jsp로 리디렉션
			    location.href = "../views/adminUserList.jsp";
			</script>
			<%
			
		} else if( menu.equals("update") ){
		%>
		<!-- 수정 시 지정하는 필드 -->
		<jsp:setProperty name="usr" property="id" value="<%=id %>" />
		<jsp:setProperty name="usr" property="password" value="<%=password %>"/>
		<jsp:setProperty name="usr" property="name" value="<%=name %>"/>
		<jsp:setProperty name="usr" property="nickname" value="<%=nickname %>"/>
		<jsp:setProperty name="usr" property="email" value="<%=email %>"/>
		<jsp:setProperty name="usr" property="user_id" value="<%=user_id %>"/>
		
		<jsp:setProperty name="str" property="name" value="<%=s_name %>" />
	    <jsp:setProperty name="str" property="number" value="<%=s_number %>"/>
	    <jsp:setProperty name="str" property="location" value="<%=s_location %>"/>
	    <jsp:setProperty name="str" property="category" value="<%=s_category %>"/>
	    <jsp:setProperty name="str" property="reg_num" value="<%=s_reg_num %>"/>
	    <jsp:setProperty name="str" property="user_id" value="<%=user_id %>"/>
	    
	    <jsp:setProperty name="ev" property="title" value="<%=e_title %>"/>
	    <jsp:setProperty name="ev" property="content" value="<%=e_content %>"/>
	    <jsp:setProperty name="ev" property="image_path" value="<%=e_image_path %>"/>
	    <jsp:setProperty name="ev" property="period_start" value="<%=e_period_start %>"/>
	    <jsp:setProperty name="ev" property="period_end" value="<%=e_period_end %>"/>
	    <jsp:setProperty name="ev" property="event_id" value="<%=event_id %>"/>
	    
		<%
		evdb.updateDB(ev);
		strdb.updateDB(str);
		usrdb.updateDB(usr);
		%>
		<script>
			alert("수정이 완료되었습니다.");
			location.href = "../views/adminUserList.jsp";
		</script>
		<%
		}else {
			// update나 delete가 아닐 때 에러 페이지로 이동
			response.sendRedirect("../views/error.jsp");
		}

				
	%>
	
</body>
</html>