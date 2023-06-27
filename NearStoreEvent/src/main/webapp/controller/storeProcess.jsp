<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="str" class="javabean.store.StoreEntity" scope="page" />
    <jsp:useBean id="strdb" class="javabean.store.StoreDAO" scope="page" />
	<%
		 //세션에서 user_id 가져오기
	    int user_id = (Integer) session.getAttribute("user_id");
	    // StoreEntity에 user_id 설정
	    str.setUser_id(user_id);
        
        
      	//한글 처리를 위해 문자인코딩 지정
        request.setCharacterEncoding("UTF-8");
    %>
    <jsp:setProperty name="str" property="name" />
    <jsp:setProperty name="str" property="number" />
    <jsp:setProperty name="str" property="location" />
    <jsp:setProperty name="str" property="category" />
    <jsp:setProperty name="str" property="reg_num" />
    <%
    
	 // 사용자 ID에 대한 중복된 스토어 확인
	    boolean exists = strdb.storeExists(user_id);
	    if (!exists) {
	        // 동일한 user_id가 없으면 store 정보를 추가합니다.
	        strdb.insertDB(str);
	        %>
            <script>
               alert('등록이 완료되었습니다.');
               location.href="../views/main.jsp";  
           </script>
           <%
        	// 성공적으로 store 정보 저장 시, store_id를 세션에 저장
           session.setAttribute("store_id", str.getStore_id());
       	
	    } else {
	        // 동일한 user_id가 존재할 경우 오류 메시지 출력
	    	%>
            <script>
                alert("동일한 id에 해당하는 스토어가 이미 있습니다.");
                location.href="../views/storeForm.jsp";
            </script>
    		<%
	    }
    	%>
    
</body>
</html>