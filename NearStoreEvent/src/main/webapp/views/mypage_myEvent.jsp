<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="../static/css/style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script language=JavaScript src="../static/js/mypage.js?after" charset="utf-8"></script>
<link rel="stylesheet" href="../static/css/mypage.css?after">
<title>마이페이지 : 내 이벤트</title>
</head>
<body>
	
  <% pageContext.include("header.jsp"); %>
    
  <div class="content">
        <div class="sidenav">
          <h2>마이페이지</h2>
          <a href="mypage.jsp">내 정보</a>
          <a href="mypage_myStore.jsp">내 가게</a>
          <a href="mypage_myEvent.jsp">내 이벤트</a>
        </div>
        <div class="myInfo">
        	<h1>내 이벤트</h1>
    <jsp:useBean id="ev" class="javabean.event.EventEntity" scope="page" />
    <jsp:useBean id="evdb" class="javabean.event.EventDAO" scope="page" />
	<jsp:useBean id="strdb" class="javabean.store.StoreDAO" scope="page" />
  <%
  	request.setCharacterEncoding("EUC-KR");
    int user_id = (Integer) session.getAttribute("user_id");
    int store_id = strdb.getStoreId(user_id);
    int event_id = evdb.getEventId(user_id);
  	
    if(event_id == -1){
    	%>
    	<script>
    		alert("등록된 이벤트가 없습니다.");
    		location.href="mypage_myStore.jsp";
    	</script>
    	<%
    }
    ev = evdb.getEvent(event_id);

    String title = ev.getTitle();
    String content = ev.getContent();
    String period_start = ev.getPeriod_start().toString();
    String period_end = ev.getPeriod_end().toString();
    String image_path = ev.getImage_path();
    
  %>

  <form name="mypageform" method="post" action="../controller/mypageEventProcess.jsp" enctype="multipart/form-data">
    <input type="hidden" name="menu" value="delete">
    <input type="hidden" name="user_id" value="<%=user_id %>">
    <table border="1">
      <tr>
        <td>제목</td>
        <td>
          <input type="text" name="title" value="<%=title %>" maxlength="50">
        </td>
      </tr>
      <tr>
        <td>내용</td>
        <td>
          <textarea name="content" rows="5" cols="50"><%=content %></textarea>
        </td>
      </tr>
      <tr>
        <td>이벤트 기간</td>
        <td>
          <input type="date" name="period_start" value="<%=period_start %>">
          ~
          <input type="date" name="period_end" value="<%=period_end %>">
        </td>
      </tr>
      <tr>
        <td>이미지</td>
        <td>
          <input type="file" name="image_path" accept="image/*">
          <img src="../static/event_image/<%=image_path%>" width="100" height="100">
        </td>
      </tr>
    </table>

    <input type="button" value="이벤트 삭제" onClick="deleteEvent()">
  </form>
        </div>
    
  </div>
<footer>
        <div class="footer-container">
            <div class="footer-info">
                <p>웹서버구축 프로젝트</p>
                <p>mhhu200@naver.com</p>
                <p>ⓒ2023. HyeongwookCho. all rights reserved. </p>
            </div>
        </div>
    </footer>
</body>
</html>
