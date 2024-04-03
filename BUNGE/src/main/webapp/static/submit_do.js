function checkSubmit(){
	
	if($('#write-photo').val() == ''){
		alert('사진을 업로드해주세요.');
		return;
	}
	
	// 최소 문자열 길이 검사
	if ($('#write-title').val().length < 3){
		alert('제목을 3자 이상 입력해주세요');
		return;
	}
	
	if ($('#write-desc').val().length < 1){
		alert('설명을 1자 이상 입력해주세요');
		return;
	}
	
	// if ($('#write-author').val().length < 2){
	// 	alert('작성자를 2자 이상 입력해주세요');
	// 	return;
	// }
	

	
	$('#write-form').submit();
}

function cancel(){
	if(confirm('정말 취소하시겠습니까?')){
		history.back();
	}
}