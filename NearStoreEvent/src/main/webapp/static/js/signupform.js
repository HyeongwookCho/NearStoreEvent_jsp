function checkPassword() {
	            const password = document.getElementById("password");
	            const password_check = document.getElementById("password_check");
	
	            if (password.value !== password_check.value) {
	               	alert("비밀번호가 다릅니다."); 
	            }
			}
function goMain() {
		        location.href = "main.jsp";
		    }