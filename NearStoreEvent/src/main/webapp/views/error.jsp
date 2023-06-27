<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Error</title>
<style>
    body{
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .error-container {
        text-align: center;
        background-color: #ffffff;
        padding: 2rem;
        border-radius: 5px;
        box-shadow: 0px 2px 10px rgba(0,0,0,0.1);
    }

    h1 {
        font-size: 48px;
        margin-bottom: 10px;
        color: #ff6b81;
    }

    p {
        font-size: 16px;
        margin-bottom: 10px;
    }

    a {
        text-decoration:none;
        color: #2196F3;
    }

</style>
</head>
<body>
    <div class="error-container">
        <h1>Error</h1>
        <p>요청한 작업을 처리할 수 없습니다. 관리자에게 문의하세요.</p>
        <p><a href="main.jsp">메인화면으로 돌아가기</a></p>
    </div>
</body>
</html>