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
		//�ѱ� ó���� ���� �������ڵ� ����
		request.setCharacterEncoding("euc-kr");
		
	 	// ���ǿ��� user_id ��������
        int user_id = (Integer) session.getAttribute("user_id");
		int store_id = strdb.getStoreId(user_id);
		
		ev.setUser_id(user_id);
        ev.setStore_id(store_id);
		int event_id = evdb.getEventId(user_id);
		
		//������ ����
		String location = "C:\\Users\\mhhu2\\eclipse-workspace\\NearStoreEvent\\src\\main\\webapp\\static\\event_image";
		// �ִ� ������ ����
		int maxSize = 1024 * 1024 * 5; // Ű�ι���Ʈ * �ް�����Ʈ * �Ⱑ����Ʈ  
		MultipartRequest multi = new MultipartRequest(request,
				  location,
				  maxSize,
				  "utf-8",
				  new DefaultFileRenamePolicy());
		//����(update), ����(delete) �� �ϳ��� ����
	 	String menu = multi.getParameter("menu");
		if ( menu != null && menu.equals("delete") ) {
			evdb.deleteDB(event_id);
			%>
			<script>
			    alert("������ �Ϸ�Ǿ����ϴ�.");
			    // ������ �Ϸ�� �� mypage.jsp�� ���𷺼�
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
			    File file = multi.getFile(element);  // getFile �޼����� ��ȯ���� ������ ����
			    
			    if (file != null) {
			        length = file.length();  // ��ȯ���� null�� �ƴ� ��쿡�� length() �޼��� ȣ��
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
			alert("������ �Ϸ�Ǿ����ϴ�.");
			location.href = "../views/mypage.jsp";
		</script>
		<%
		}else {
			// update�� delete�� �ƴ� �� ���� �������� �̵�
			response.sendRedirect("../views/error.jsp");
		}
		%>
</body>
</html>