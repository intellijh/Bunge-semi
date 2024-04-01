$(function(){
	
	$("input[name=m_pwd").on('keyup',
	function(){
		const patternpwd =/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		const pwd = $(this).val().trim();
		
		if(pwd == "") {
			$("#pwd_message").css('color' , ' red').text("비밀번호: 비밀번호는 필수입니다.");
			($("input[name=m_pwd]")).focus();
			 return false;
			
		} else if (!patternpwd.test(pwd)) {
			$("#pwd_message").css('color', 'red').text("비밀번호:8~16자의 영문 대/소문자, 특수문자를 사용해 주세요.(/제외) ");
			 return false;
		}else {
			$("#pwd_message").css('color', 'green').text("비밀번호:안전 합니다.");
			return true;
		}
	});//pwd 유효성 검사	end
	//중복 검사
	$("input[name=m_pwd_check]").on('keyup',
		function(){
				const pwd = $("input[name=m_pwd]").val().trim();
				const pwd_check = $(this).val().trim();
				if(pwd != pwd_check) {
						$("#pwd_check_message").css('color', 'red').test("비밀번호가 일치하지 않습니다.");
						return	false;
				}else {
					$("#pwd_check_message").css('color', 'green').text("비밀번호가 일치합니다.");
				}
		})
});