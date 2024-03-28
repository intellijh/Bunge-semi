$(function() {

	//submit 버튼 클릭할 때 이벤트 부분
	$("form[name=replyform]").submit(function(){
		
		const $inf_subject = $("#inf_subject");
		if($.trim($("#inf_subject").val()) == "") {
		alert("제목을 입력하세요.");
		$inf_subject.focus();
		return false;
	}
	
	const $inf_content = $("#inf_content");
	if($.trim($("#inf_content").val()) == "") {
		alert("내용을 입력하세요.");
		$inf_content.focus();
		return false;
	}
  });
});