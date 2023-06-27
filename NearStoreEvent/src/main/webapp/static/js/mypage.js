function updateUser() {
    ok = confirm("수정하시겠습니까?");
    if (ok) {
        document.mypageform.menu.value='update';
        document.mypageform.submit();
    } else {
        return;
    }           
}
function deleteUser() {
    ok = confirm("탈퇴하시겠습니까?");
    if (ok) {
        document.mypageform.menu.value='delete';
        document.mypageform.submit();
    } else {
        return;
    }           
}

function updateStore() {
    ok = confirm("가게 정보를 수정하시겠습니까?");
    if (ok) {
        document.mypageform.menu.value='update';
        document.mypageform.submit();
    } else {
        return;
    }           
}

function deleteStore() {
    ok = confirm("가게정보를 삭제하시겠습니까?");
    if (ok) {
        document.mypageform.menu.value='delete';
        document.mypageform.submit();
    } else {
        return;
    }           
}

function updateEvent() {
    ok = confirm("이벤트를 수정하시겠습니까?");
    if (ok) {
        document.mypageform.menu.value='update';
        document.mypageform.submit();
    } else {
        return;
    }           
}

function deleteEvent() {
    ok = confirm("이벤트를 삭제하시겠습니까?");
    if (ok) {
        document.mypageform.menu.value='delete';
        document.mypageform.submit();
    } else {
        return;
    }           
}
