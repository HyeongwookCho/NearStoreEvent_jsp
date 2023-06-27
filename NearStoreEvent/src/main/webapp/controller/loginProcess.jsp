<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
    <jsp:useBean id="usr" class="javabean.user.UserEntity" scope="page" />
    <jsp:useBean id="usrdb" class="javabean.user.UserDAO" scope="page" />
	<jsp:useBean id="ev" class="javabean.event.EventEntity" scope="page" />
    <jsp:useBean id="evdb" class="javabean.event.EventDAO" scope="page" />
    <jsp:useBean id="str" class="javabean.store.StoreEntity" scope="page" />
	<jsp:useBean id="strdb" class="javabean.store.StoreDAO" scope="page" />
    <%
        //한글 처리를 위해 문자인코딩 지정
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String id = request.getParameter("id");
        String pw = request.getParameter("password");
		
        usr.setId(id);
        usr.setPassword(pw);
        
        boolean isRightUser = usrdb.isRightUser(usr);
        
        if (isRightUser) {
            int user_id = usrdb.getUserId(id);
            session.setAttribute("user_id", user_id);
            session.setAttribute("id", id);
            
            //로그인 시 해당 유저와 연결된 가게 및 이벤트 정보 세션에 저장
            int store_id = strdb.getStoreId(user_id);
            int event_id = evdb.getEventId(store_id);
            
            session.setAttribute("store_id", store_id);
            session.setAttribute("event_id", event_id);
            
            if (id.equals("admin")) {
                response.sendRedirect("../views/adminUserList.jsp");
            } else {
                response.sendRedirect("../views/main.jsp");
            }
        } else {
            %>
            <script>
                alert("등록되지 않은 회원입니다.");
                history.back();
            </script>
            <%
        }
    %>
</body>
</html>
