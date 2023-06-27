<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../static/css/loginandregi.css">
    <script language=JavaScript src="../static/js/eventform.js" charset="utf-8"></script>
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1:700" rel="stylesheet">
    <title>이벤트 등록 : 우리동네 이벤트소식</title>
</head>
<body>
	<jsp:useBean id="str" class="javabean.store.StoreEntity" scope="page" />
    <jsp:useBean id="evdb" class="javabean.event.EventDAO" scope="page" />
	<%request.setCharacterEncoding("UTF-8"); %>
	<main>
	<h1>우리동네 이벤트<br>이벤트 등록하기</h1>
	<form action="../controller/eventProcess.jsp" method="post" enctype="multipart/form-data" onsubmit="return checkInput();">
		<label for="title">이벤트 제목</label>
        <input type="text" id="title" name="title" required>

        <label for="content">이벤트 내용</label>
        <textarea id="content" name="content" required></textarea>
	 	<fieldset>
			<legend>이미지 업로드</legend>
			<p>파일명 : <input type="file" name="image_path"></p> 	
	 	</fieldset>
	 	
	 	<label for="period_start">이벤트 시작일</label>
        <input type="date" id="period_start" name="period_start" required>
        
        <label for="period_end">이벤트 종료일</label>
        <input type="date" id="period_end" name="period_end" required>

        <button type="button" onclick="goMain()">메인으로 돌아가기</button>
        <script>
            function goMain() {
                location.href = "main.jsp";
            }
        </script>
        <button type="submit">이벤트 등록하기</button>
	 </form>
	</main>
</body>
</html>