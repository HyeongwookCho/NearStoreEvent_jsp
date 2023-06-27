<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../static/css/style.css?after">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>우리 동네 이벤트 소식</title>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=367fadd3d53756bf152071c1a7f543a2&libraries=services"></script>
    <script language=JavaScript src="../static/js/main.js" charset=UTF-8></script>
    
    
    
	
</head>
<body>
	<%@ page import="java.util.ArrayList,javabean.event.EventEntity,java.text.SimpleDateFormat" %>
    <jsp:useBean id="evdb" class="javabean.event.EventDAO" scope="page" />
    <jsp:useBean id="strdb" class="javabean.store.StoreDAO" scope="page" />
    
    <% 
	    request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
    	evdb.deleteExpiredEvents();
    	pageContext.include("header.jsp");
		
    %>
	<div class="eventInfo_header_wrapper">
    	<div class = "eventInfo_text">
    		<div class="bg">
    			<h1 id = "text1">우리 동네에 어떤 이벤트가 있을까?<br><br>바로 알아봐요!<br><br><span class="down-arrow">↓</span></h1>
    		</div>
    		
    		<div class="eventInfo_function">
    			<h2 id = "text2">먼저 찾으시는 가게나 이벤트나 키워드를 카테고리나 검색에서 찾아주세요!</h2>
		    	<div class="nav_bar_searchbar">
			        <form action="main.jsp" method="get">
			            <input type="text" placeholder="무얼 찾으시나요?" name="search">
			            <input type="submit" value="검색하기!">
			        </form>
			    </div>
		        <div class="eventInfo_categori_wrapper">
		            <form action="main.jsp" method="get">
					   <select class="eventInfo_category" name="category" onchange="this.form.submit()">
					      <option value="">카테고리</option>
					      <option value="음식점">음식점</option>
					      <option value="마트">마트</option>
					      <option value="쇼핑몰">쇼핑몰</option>
					      <option value="영화관">영화관</option>
					      <option value="카페">카페</option>
					   </select>
					  <br><br>
		            <input class="eventInfo_wholebtn" type="submit" value="전체 이벤트 목록보기!">
					</form>
		    	</div>
	    	</div>
	    	
    		
    	</div>
	    
	    
	    <% 
    	// 로그인 처리 되었을 경우 위치기반이벤트 추천 기능 사용
    	String sessionId = (String)session.getAttribute("id"); 
    
		if (sessionId != null) {
			%>
			<div class="eventInfo_location">
				<h2 id="text4">먼저 현재 위치를 설정하고 거리에 따른 버튼을 눌러주세요.</h2>
				<%
				pageContext.include("setLocation.jsp");
	    		%>
	    		<br><br>
	    		<h2 id="text4">아래에서 우리 동네에서 진행하는 이벤트를 확인해보세요!</h2>
	    		<h2 id="text4"><span class="down-arrow">↓</span></h2>
	    		
	    		
			</div>
			
	    <%	
	 	}else{
	 		%>
	 		<h2 class="text3">위치기반으로 하는 우리 동네 이벤트 소식은 로그인 후에 이용해주세요.</h2>
	 		<%
	 	} 
	%>
	    </div>
    
    <div class="eventInfo_wrapper">
    	
        <!-- 이벤트 목록 출력 -->
    <div class="eventInfo_grid">
    <!-- Event Modal -->
	<div class="modal fade" id="eventModal" tabindex="-1" role="dialog" aria-labelledby="eventModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header custom-header">
	        <h5 class="modal-title custom-title" id="eventModalLabel">이벤트 상세 정보</h5>
	        <button type="button" class="close custom-close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body custom-body">
	        <!-- 이곳에 이벤트 정보를 채웁니다. -->
	      </div>
	      <div class="modal-footer custom-footer">
	        <button type="button" class="btn btn-secondary custom-close-btn" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>

    
    <%
    
    int currentPage = 1;
    if (request.getParameter("page") != null) {
     currentPage = Integer.parseInt(request.getParameter("page"));
    }
    
    int eventsPerPage = 9;
    int startEvent = (currentPage - 1) * eventsPerPage;
    
    String category = request.getParameter("category");
    String search = request.getParameter("search");
    
    ArrayList<EventEntity> filteredEventList;

    if (search != null && !search.trim().isEmpty()) {
        filteredEventList = evdb.searchEventList(search);
    } else if (category == null || category.trim().isEmpty()) {
        filteredEventList = evdb.getEventList();
    } else {
        filteredEventList = evdb.getEventListByCategory(category);
    }
	
    ArrayList<EventEntity> pageEventList = new ArrayList<>();
    for (int i = startEvent; i < startEvent + eventsPerPage && i < filteredEventList.size(); i++) {
     pageEventList.add(filteredEventList.get(i));
    }
    
    String location = "static/event_image";
    for (EventEntity event : pageEventList) { %>
    <div class="eventInfo_item event-card" onclick=showEventDetails(this);>
        <p class="event-storeLocation" style="display: none;"><%= event.getStoreLocation() %></p>
        <p class="event-period"><%= event.getPeriod_start() %>~<%=event.getPeriod_end() %></p>
        <img src="<%= request.getContextPath() %>/<%=location %>/<%=event.getImage_path() %>" alt="이미지" class="eventInfo_img event-image">
        <h3 class="eventInfo_title event-title"><%= event.getTitle() %></h3>
        <p class="eventInfo_content event-content"><%= event.getContent() %></p>
    </div>
    <% } %>
	    	    
	</div>
                
    <!-- 페이징 네비게이션 -->
    <div class="pagination-wrapper">
	    <nav aria-label="Page navigation">
	        <ul class="pagination">
	            <% int totalPages = (int) Math.ceil((double)filteredEventList.size() / eventsPerPage);
	                for (int i = 1; i <= totalPages; i++) { %>
	                <li class="page-item"><a class="page-link" href="main.jsp?page=<%= i %>&<%= request.getQueryString() %>"><%= i %></a></li>
	            <% } %>
	        </ul>
	    </nav>
	</div>         
    </div>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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