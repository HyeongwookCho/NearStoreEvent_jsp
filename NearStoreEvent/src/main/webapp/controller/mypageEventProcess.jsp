<%@page import="java.io.File" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="ev" class="javabean.event.EventEntity" scope="page" />
    <jsp:useBean id="evdb" class="javabean.event.EventDAO" scope="page" />
	<jsp:useBean id="strdb" class="javabean.store.StoreDAO" scope="page" />
	
	<% 
		//한글 처리를 위해 문자인코딩 지정
		request.setCharacterEncoding("euc-kr");
		
	 	// 세션에서 user_id 가져오기
        int user_id = (Integer) session.getAttribute("user_id");
		int store_id = strdb.getStoreId(user_id);
		
		ev.setUser_id(user_id);
        ev.setStore_id(store_id);
		int event_id = evdb.getEventId(user_id);
		
		//저장경로 설정
		String location = "C:\\Users\\mhhu2\\eclipse-workspace\\NearStoreEvent\\src\\main\\webapp\\static\\event_image";
		// 최대 사이즈 설정
		int maxSize = 1024 * 1024 * 5; // 키로바이트 * 메가바이트 * 기가바이트  
		MultipartRequest multi = new MultipartRequest(request,
				  location,
				  maxSize,
				  "utf-8",
				  new DefaultFileRenamePolicy());
		//수정(update), 삭제(delete) 중 하나를 저장
	 	String menu = multi.getParameter("menu");
		if ( menu != null && menu.equals("delete") ) {
			evdb.deleteDB(event_id);
			%>
			<script>
			    alert("삭제가 완료되었습니다.");
			    // 삭제가 완료된 후 mypage.jsp로 리디렉션
			    location.href = "../views/mypage.jsp";
			</script>
			<%
			
		} else if( menu != null && menu.equals("update") ){
			Enumeration<?> files = multi.getFileNames();

			String element = "";
			String filesystemName = "";
			String originalFileName = "";
			String contentType = "";
			long length = 0;
			
					
			if (files.hasMoreElements()) { 
			    element = (String)files.nextElement(); 
			    filesystemName = multi.getFilesystemName(element);
			    originalFileName = multi.getOriginalFileName(element);
			    contentType = multi.getContentType(element);
			    File file = multi.getFile(element);  // getFile 메서드의 반환값을 변수에 저장
			    
			    if (file != null) {
			        length = file.length();  // 반환값이 null이 아닌 경우에만 length() 메서드 호출
			    }
			    
			    String image_path = evdb.getImage_path(user_id);
			    ev.setImage_path(multi.getParameter("image_path"));
			}
	        
	        ev.setTitle(multi.getParameter("title"));
	        ev.setContent(multi.getParameter("content"));
	        ev.setPeriod_start(java.sql.Date.valueOf(multi.getParameter("period_start")));
	        ev.setPeriod_end(java.sql.Date.valueOf(multi.getParameter("period_end")));
	        
			evdb.updateDB(ev);
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