$(function() {
	$("#upfile").change(function(){
		console.log($(this).val())
		const inputfile = $(this).val().split('\\');
		$('#filevalue').text(inputfile[inputfile.length -1]);
	});
	
	if($.trim($("#inf_subject").val()) == "") {
		alert("제목을 입력하세요.");
		$("inf_subject").focus();
		return false;
	}
	
	if($.trim($("#inf_content").val()) == "") {
		alert("내용을 입력하세요.");
		$("inf_content").focus();
		return false;
	}
  });
