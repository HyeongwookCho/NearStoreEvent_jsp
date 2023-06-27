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
<title>���������� : �� ����</title>

</head>
<body onload="checkStoreInfo()">
	<% pageContext.include("header.jsp"); %>
    
        <div class="content">
            <div class="sidenav">
	           	<h2>����������</h2>
	             <a href="mypage.jsp">�� ����</a>
	             <a href="mypage_myStore.jsp">�� ����</a>
	             <a href="mypage_myEvent.jsp">�� �̺�Ʈ</a>
	          </div>
	        <div class="myInfo">
          		<h1>�� ����</h1>
    <jsp:useBean id="str" class="javabean.store.StoreEntity" scope="page" />
	<jsp:useBean id="strdb" class="javabean.store.StoreDAO" scope="page" />
	
	<%
		int user_id = (Integer) session.getAttribute("user_id");
		int store_id = strdb.getStoreId(user_id);
		
		if(store_id == -1){
	    	%>
	    	<script>
	    		alert("��ϵ� ���԰� �����ϴ�.");
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
<!-- menu : ���, ���� �Ǵ� ���� ������ ���� �Ű������� �̿� -->
<input type=hidden name="menu" value="update">
<!-- ���� �Ǵ� ������ ���� �Խ� id�� hidden���� ���� -->
<input type=hidden name="user_id" value=<%=user_id %>>

<table border="1">
	<tr>
		<td>���Ը�</td>
		<td>
			<input type=text name=name value="<%=name %>" maxlength=50 >
		</td>
	</tr>
	<tr>
		<td>��ȭ��ȣ</td>
		<td>
			<input type=text name=number value="<%=number %>" maxlength=255 >
		</td>
	</tr>
	<tr>
		<td>�ּ�</td>
		<td>
			<input type="text" id="address_kakao" name="location" value="<%=location %>" readonly required/>
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
				window.onload = function(){
				    document.getElementById("address_kakao").addEventListener("click", function(){ //�ּ��Է�ĭ�� Ŭ���ϸ�
				        //īī�� ���� �߻�
				        new daum.Postcode({
				            oncomplete: function(data) { //���ý� �Է°� ����
				                document.getElementById("address_kakao").value = data.address; // �ּ� �ֱ�
				            }
				        }).open();
				    });
				}
			</script>
		</td>
	</tr>
	<tr>
		<td>ī�װ�</td>
		<td>
			<label for="category"></label>
			<select id="category" name="category" required>
			  <option value="" selected>�����ϼ���</option>
			  <option value="������">������</option>
			  <option value="��Ʈ">��Ʈ</option>
			  <option value="���θ�">���θ�</option>
			  <option value="��ȭ��">��ȭ��</option>
			  <option value="ī��">ī��</option>
			</select><br>
		</td>
	</tr>
	<tr>
		<td>����� ��Ϲ�ȣ</td>
		<td>
			<input type=text name=reg_num value="<%=reg_num %>" maxlength=100 >
		</td>
	</tr>
	
   	
</table>
	<input type=button value="�����Ϸ�" onClick="updateStore()">
	<input type="button" value="���� ���� ����" onClick="deleteStore()">
</form>
          	</div>
        </div>
        <footer>
        <div class="footer-container">
            <div class="footer-info">
                <p>���������� ������Ʈ</p>
                <p>mhhu200@naver.com</p>
                <p>��2023. HyeongwookCho. all rights reserved. </p>
            </div>
        </div>
    </footer>
</body>
</html>