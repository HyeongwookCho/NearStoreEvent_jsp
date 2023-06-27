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
    <title>�̺�Ʈ ��� : �츮���� �̺�Ʈ�ҽ�</title>
</head>
<body>
	<jsp:useBean id="str" class="javabean.store.StoreEntity" scope="page" />
    <jsp:useBean id="evdb" class="javabean.event.EventDAO" scope="page" />
	<%request.setCharacterEncoding("UTF-8"); %>
	<main>
	<h1>�츮���� �̺�Ʈ<br>�̺�Ʈ ����ϱ�</h1>
	<form action="../controller/eventProcess.jsp" method="post" enctype="multipart/form-data" onsubmit="return checkInput();">
		<label for="title">�̺�Ʈ ����</label>
        <input type="text" id="title" name="title" required>

        <label for="content">�̺�Ʈ ����</label>
        <textarea id="content" name="content" required></textarea>
	 	<fieldset>
			<legend>�̹��� ���ε�</legend>
			<p>���ϸ� : <input type="file" name="image_path"></p> 	
	 	</fieldset>
	 	
	 	<label for="period_start">�̺�Ʈ ������</label>
        <input type="date" id="period_start" name="period_start" required>
        
        <label for="period_end">�̺�Ʈ ������</label>
        <input type="date" id="period_end" name="period_end" required>

        <button type="button" onclick="goMain()">�������� ���ư���</button>
        <script>
            function goMain() {
                location.href = "main.jsp";
            }
        </script>
        <button type="submit">�̺�Ʈ ����ϱ�</button>
	 </form>
	</main>
</body>
</html>