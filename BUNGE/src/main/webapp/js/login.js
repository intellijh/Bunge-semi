$(function(){
	$(function() {
	$(".join").click(function () {
		location.href = "index.jsp";
	});
//아이디 저장
	const m_id = '${cookie_id}';
	if (m_id) {
		$("input=[name=m_id]").val(id);
		$("input=[name=checkid]").prop('checked', true);
	}
})
});