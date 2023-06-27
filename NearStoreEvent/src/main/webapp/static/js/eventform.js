function checkInput() {
    const title = document.getElementById('title').value;
    const content = document.getElementById('content').value;
    const periodStart = document.getElementById('period_start').value;
    const periodEnd = document.getElementById('period_end').value;
    const imagePath = document.getElementsByName('image_path')[0];
    
    if (title === '' || content === '') {
        alert('제목과 내용을 모두 입력해주세요.');
        return false;
    }

    // 이벤트 시작일과 종료일 확인 코드
    if (periodStart > periodEnd) {
        alert('이벤트 종료일은 시작일보다 이른 날짜를 선택할 수 없습니다.');
        return false;
    }
    
    // 이미지 업로드 확인 코드
    if (imagePath.files.length === 0) {
        alert('이미지를 업로드해주세요.');
        return false;
    }
   
    return true;
}

