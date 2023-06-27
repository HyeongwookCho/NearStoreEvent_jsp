<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="../static/css/admin.css?after">
<title>������ : ����</title>
</head>
<script language=JavaScript src="../static/js/admin.js" charset="utf-8"></script>
<body>
	<%@ page import="javabean.user.*, javabean.store.*, javabean.event.*" %>
	
	<%
		/* �������� */
		String u_id = "";
		String u_password = "";
		String u_name = "";
		String u_nickname = "";
		String u_email = ""; 
		String u_created_at = ""; 

		/* ������ ���� ���� ���� */
		int store_id = -1;
		String s_name = "";
		String s_number = "";
		String s_location = "";
		String s_category = "";
		String s_reg_num = "";
		String s_created_at = "";
		
		/* ������ ���� ��� ���� */
		int event_id = -1;
		String e_title = "";
		String e_content = "";
		String e_image_path = "";
		String e_period_start = "";
	    String e_period_end = "";
		String e_created_at = "";
		
		String user_id = request.getParameter("user_id");
		
		if (user_id != null) {
			//����� �ƴ� ���, ����� ���� ������ �Խ��� �� �ʵ� ������ ���� 
			int user_idnum = Integer.parseInt(user_id);
			UserDAO usrdb = new UserDAO(); 
			UserEntity usr = usrdb.getUser(user_idnum);
			
			u_id = usr.getId();
			u_password = usr.getPassword();
			u_name = usr.getName();
			u_nickname = usr.getNickname();
			u_email = usr.getEmail();
			u_created_at= usr.getCreated_at();
			
			StoreDAO strdb = new StoreDAO();
			// ��ϵ� ���� ������ ���� ��!
			if(strdb.getStoreId(user_idnum) != -1){
				StoreEntity str = strdb.AdmingetStore(user_idnum);
				store_id = str.getStore_id();
				s_name = str.getName();
				s_number = str.getNumber();
				s_location = str.getLocation();
				s_category = str.getCategory();
				s_reg_num = str.getReg_num();
				s_created_at = str.getCreated_at();
				
				// ��ϵ� ������ �̺�Ʈ ������ ���� ��!					
				EventDAO evdb = new EventDAO();
				if(evdb.getEventId(user_idnum) != -1){
					EventEntity ev = evdb.AdmingetEvent(user_idnum);
					event_id = ev.getEvent_id();
					e_title = ev.getTitle();
					e_content = ev.getContent();
					e_image_path = ev.getImage_path();
					e_period_start = ev.getPeriod_start().toString();
					e_period_end = ev.getPeriod_end().toString();
					e_created_at = ev.getCreated_at();
				};
			};
		};
	%>
<h2>���� ���� ���� �� ����</h2>
<form name=adminform method=post action="../controller/adminProcess.jsp" >
<!-- menu : ���, ���� �Ǵ� ���� ������ ���� �Ű������� �̿� -->
<input type=hidden name="menu" value="update">
<!-- ���� �Ǵ� ������ ���� �Խ� id�� hidden���� ���� -->
<input type=hidden name="user_id" value=<%=user_id %>>

<table border="1" class=Info_wrapper>
	<tr>
		<table class=userInfo>
			<tr>
				<td>���� ID : </td>
				<td>
					<input type=text name=id value="<%=u_id %>" maxlength=50 >
				</td>
			</tr>
			<tr>
				<td>��й�ȣ : </td>
				<td>
					<input type=password name=password value="<%=u_password %>" maxlength=255 >
				</td>
			</tr>
			<tr>
				<td>�̸� : </td>
				<td>
					<input type=text name=name value="<%=u_name %>" maxlength=50 >
				</td>
			</tr>
			<tr>
				<td>�г��� : </td>
				<td>
					<input type=text name=nickname value="<%=u_nickname %>" maxlength=100 >
				</td>
			</tr>
			<tr>
				<td>email : </td>
				<td>
					<input type=text name=email value="<%=u_email %>" maxlength=100 >
				</td>
			</tr>
			<tr>
				<td>������ : </td>
				<td>
					<%=u_created_at %>
				</td>
			</tr>
		</table>
	</tr>
	<tr>
		<table class=storeInfo>
			<tr>
				<td>store_id : </td>
				<td>
					<%=store_id %>
				</td>
			</tr>
			<tr>
				<td>��ȣ�� : </td>
				<td>
					<input type=text name=s_name value="<%=s_name %>" maxlength=255 >
				</td>
			</tr>
			<tr>
				<td>��ȭ��ȣ : </td>
				<td>
					<input type=text name=s_number value="<%=s_number %>" maxlength=255 >
				</td>
			</tr>
			<tr>
				<td>���� �ּ� : </td>
				<td>
					<input type=text name=s_location value="<%=s_location %>" maxlength=250 >
				</td>
			</tr>
			<tr>
				<td>ī�װ��� : </td>
				<td>
					<input type=text name=s_category value="<%=s_category %>" maxlength=100 >
				</td>
			</tr>
			<tr>
				<td>����� ��� ��ȣ</td>
				<td>
					<input type=text name=s_reg_num value="<%=s_reg_num %>" maxlength=100 >
				</td>
			</tr>
			<tr>
				<td>���� ����� : </td>
				<td>
					<%=s_created_at %>
				</td>
			</tr>
		</table>
	</tr>
	<tr>
		<table class=eventInfo>
			<tr>
				<td>event_id : </td>
				<td>
					<%=event_id %>
				</td>
			</tr>
			<tr>
				<td>�̺�Ʈ ���� : </td>
				<td>
					<input type=text name=e_title value="<%=e_title %>" maxlength=255 >
				</td>
			</tr>
			<tr>
				<td>�̺�Ʈ ���� : </td>
				<td>
					<input type=text name=e_content value="<%=e_content %>" maxlength=255 >
				</td>
			</tr>
			<tr>
				<td>�̹��� ��� : </td>
				<td>
					<input type=text name=e_image_path value="<%=e_image_path %>" maxlength=100 >
				</td>
			</tr>
			<tr>
				<td>�̺�Ʈ �Ⱓ (������) : </td>
				<td>
					<input type=text name=e_period_start value="<%=e_period_start %>" maxlength=100 >
				</td>
			</tr>
			<tr>
				<td>�̺�Ʈ �Ⱓ (������) : </td>
				<td>
					<input type=text name=e_period_end value="<%=e_period_end %>" maxlength=100 >
				</td>
			</tr>
			<tr>
				<td>�̺�Ʈ ����� : </td>
				<td>
					<%=e_created_at %>
				</td>
			</tr>
		</table>
	</tr>
</table>


	<input type=button value="������� ����" onClick="backList()">
	<input type=button value="�����Ϸ�" onClick="updatecheck()">
   	<input type=button value="����" onClick="deletecheck()">
</form>
</body>
</html>