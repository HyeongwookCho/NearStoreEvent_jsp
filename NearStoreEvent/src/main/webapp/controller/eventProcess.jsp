<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>event</title>
</head>
<body>
	<jsp:useBean id="ev" class="javabean.event.EventEntity" scope="page" />
    <jsp:useBean id="evdb" class="javabean.event.EventDAO" scope="page" />
    <jsp:useBean id="str" class="javabean.store.StoreEntity" scope="page" />
	<jsp:useBean id="strdb" class="javabean.store.StoreDAO" scope="page" />
	<% 
		request.setCharacterEncoding("UTF-8");
	
		// 세션에서 user_id 가져오기
        int user_id = (Integer) session.getAttribute("user_id");
		// 해당 user_id의 세션에서 store_id 가져오기
	    int store_id = strdb.getStoreId(user_id);

        session.setAttribute("store_id", str.getStore_id());
        
        // event에 저장
        ev.setUser_id(user_id);
        ev.setStore_id(store_id);
	    
		
		//저장경로 설정
		String location = "C:\\Users\\mhhu2\\eclipse-workspace\\NearStoreEvent\\src\\main\\webapp\\static\\event_image";
		// 최대 사이즈 설정
		int maxSize = 1024 * 1024 * 5; // 키로바이트 * 메가바이트 * 기가바이트  
		 
		MultipartRequest multi = new MultipartRequest(request,
							 						  location,
													  maxSize,
													  "utf-8",
													  new DefaultFileRenamePolicy());

		Enumeration<?> files = multi.getFileNames();

		String element = "";
		String filesystemName = "";
		String originalFileName = "";
		String contentType = "";
		long length = 0;
		
				
		if (files.hasMoreElements()) { 
			
			element = (String)files.nextElement(); 
			 
			filesystemName 			= multi.getFilesystemName(element);
			originalFileName 		= multi.getOriginalFileName(element);
			contentType 			= multi.getContentType(element);
			length 					= multi.getFile(element).length(); 
			
            ev.setImage_path(filesystemName);
		}
        
        ev.setTitle(multi.getParameter("title"));
        ev.setContent(multi.getParameter("content"));
        ev.setPeriod_start(java.sql.Date.valueOf(multi.getParameter("period_start")));
        ev.setPeriod_end(java.sql.Date.valueOf(multi.getParameter("period_end")));
        
		// 가게 없는 유저가 이벤트를 등록할 경우
		boolean storeExists = strdb.storeExists(user_id);
		if(!storeExists){
				%>
				<script>
			       alert('가게를 먼저 등록해주세요.');
			       location.href="../views/main.jsp";  
			   </script>
				<%
			}
		// 가게 ID에 대한 중복된 event 확인
		boolean exists = evdb.eventExists(store_id);
		if(exists){
			//동일한 store_id 가 없으면 event 정보 추가
			evdb.insertDB(ev);
			
			%>
			
			<script>
		       alert('이벤트 등록이 완료되었습니다.');
		       location.href="../views/main.jsp";  
		   </script>
			<%
			// 성공적으로 store 정보 저장 시, store_id를 세션에 저장
           session.setAttribute("event_id", ev.getEvent_id());
		} else {
			%>
            <script>
                alert("한 가게 당 하나의 이벤트를 등록할 수 있습니다.\n기존의 이벤트를 삭제해주세요.");
                location.href="../views/main.jsp";
            </script>
    		<%
		}
	%>
	    
</body>
</html>
