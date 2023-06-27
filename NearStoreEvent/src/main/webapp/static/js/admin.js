function deletecheck() {
    ok = confirm("삭제하겠습니까?");
    if (ok) {
        document.adminform.menu.value='delete';
        document.adminform.submit();
    } else {
        return;
    }           
}

function updatecheck() {
    ok = confirm("수정하겠습니까?");
    if (ok) {
        document.adminform.menu.value='update';
        document.adminform.submit();
    } else {
        return;
    }           
}

function backList() {
    location.href = "adminUserList.jsp"; 
}