<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="../static/css/style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script language=JavaScript src="../static/js/mypage.js" charset="utf-8"></script>
<link rel="stylesheet" href="../static/css/mypage.css?after">    
<title>마이페이지 : 내 가게</title>

</head>
<body onload="checkStoreInfo()">
	<% pageContext.include("header.jsp"); %>
    
        <div class="content">
            <div class="sidenav">
	           	<h2>마이페이지</h2>
	             <a href="mypage.jsp">내 정보</a>
	             <a href="mypage_myStore.jsp">내 가게</a>
	             <a href="mypage_myEvent.jsp">내 이벤트</a>
	          </div>
	        <div class="myInfo">
          		<h1>내 가게</h1>
    <jsp:useBean id="str" class="javabean.store.StoreEntity" scope="page" />
	<jsp:useBean id="strdb" class="javabean.store.StoreDAO" scope="page" />
	
	<%
		int user_id = (Integer) session.getAttribute("user_id");
		int store_id = strdb.getStoreId(user_id);
		
		if(store_id == -1){
	    	%>
	    	<script>
	    		alert("등록된 가게가 없습니다.");
	    		location.href="mypage.jsp"
	    	</script>
	    	<%
	    }
	    str = strdb.getStore(store_id);
	    
		String name = "";
		String number = "";
		String location = "";
		String category = "";
		String reg_num = "";  

		name = str.getName();
		number = str.getNumber();
		location = str.getLocation();
		category = str.getCategory();
		reg_num = str.getReg_num();

	%>
<form name=mypageform method=post action="../controller/mypageStoreProcess.jsp" >
<!-- menu : 등록, 수정 또는 삭제 구분을 위한 매개변수로 이용 -->
<input type=hidden name="menu" value="update">
<!-- 수정 또는 삭제를 위한 게시 id를 hidden으로 전송 -->
<input type=hidden name="user_id" value=<%=user_id %>>

<table border="1">
	<tr>
		<td>가게명</td>
		<td>
			<input type=text name=name value="<%=name %>" maxlength=50 >
		</td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td>
			<input type=text name=number value="<%=number %>" maxlength=255 >
		</td>
	</tr>
	<tr>
		<td>주소</td>
		<td>
			<input type="text" id="address_kakao" name="location" value="<%=location %>" readonly required/>
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
				window.onload = function(){
				    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
				        //카카오 지도 발생
				        new daum.Postcode({
				            oncomplete: function(data) { //선택시 입력값 세팅
				                document.getElementById("address_kakao").value = data.address; // 주소 넣기
				            }
				        }).open();
				    });
				}
			</script>
		</td>
	</tr>
	<tr>
		<td>카테고리</td>
		<td>
			<label for="category"></label>
			<select id="category" name="category" required>
			  <option value="" selected>선택하세요</option>
			  <option value="음식점">음식점</option>
			  <option value="마트">마트</option>
			  <option value="쇼핑몰">쇼핑몰</option>
			  <option value="영화관">영화관</option>
			  <option value="카페">카페</option>
			</select><br>
		</td>
	</tr>
	<tr>
		<td>사업자 등록번호</td>
		<td>
			<input type=text name=reg_num value="<%=reg_num %>" maxlength=100 >
		</td>
	</tr>
	
   	
</table>
	<input type=button value="수정완료" onClick="updateStore()">
	<input type="button" value="가게 정보 삭제" onClick="deleteStore()">
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