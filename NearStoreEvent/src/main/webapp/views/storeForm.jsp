<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../static/css/loginandregi.css">
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1:700" rel="stylesheet">
    <title>가게 등록 : 우리동네 이벤트소식</title>

</head>
<body>
    <main>
      <h1>우리동네 이벤트<br>내 가게 등록하기</h1>
      <form action="../controller/storeProcess.jsp" method=POST>
 
        <label for="name">가게명</label>
        <input type="text" id="name" name="name" required>
        
        <label for="number">전화번호</label>
        <input type="text" id="number" name="number" required>
        
        <label for="location">가게 위치</label>
        <input type="text" id="address_kakao" name="location" readonly required/>
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
        <label for="category">카테고리</label>
		<select id="category" name="category" required>
		  <option value="">선택하세요</option>
		  <option value="음식점">음식점</option>
		  <option value="마트">마트</option>
		  <option value="쇼핑몰">쇼핑몰</option>
		  <option value="영화관">영화관</option>
		  <option value="카페">카페</option>
		</select><br>
		
        <label for="reg_num">사업자 등록 번호</label>
        <input type="text" id="reg_num" name="reg_num" required>

        <button type="button" onclick="goMain()">메인으로 돌아가기</button>
		<script>
		    function goMain() {
		        location.href = "main.jsp";
		    }
		</script>
        <button type="submit">가게 등록하기</button>
      </form>
    </main>
  </body>
</html>