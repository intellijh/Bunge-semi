// deleteOrUpdate.js

function del(){
	if ($('#write-password').val() == ''){
		alert('비밀번호를 입력하세요.');
		return;
	} else {
		if (confirm('정말 삭제하시겠습니까?')){
			$("#delete-or-update-form").attr("action", "tradeDelete.net").submit();
		}
	}
}

function update(){
	if ($('#write-password').val() == ''){
		alert('비밀번호를 입력하세요.');
		return;
	} else {
		$("#delete-or-update-form").attr("action", "tradeUpdate.net").submit();
	}
}
