$(function(){
	let checkid= false;
	let checkmail= false;
	
	$("input[name=m_id]").on('keyup',
			function(){
		if(!$("input[name=m_id]")){
				$("#id_message").css('color' , 'red').html('아이디 : 아이디는 필수 입니다.');
				($("input[name=m_id]")).focus();
			checkid= false;
			return 
		}
	});
	$("input[name=m_id]").on('keyup',
		function(){
			
			const pattern = /^\w{5,15}$/;
			const id = $(this).val();
			
			if(id.trim() == '') {
				$("#id_message").css('color' , 'red').html('아이디 : 아이디는 필수 입니다.');
				($("input[name=m_id]")).focus();
				checkid= false;
			} else if(!pattern.test(id)) {
				$("#id_message").css('color' , 'red').html('아이디 : 5~15자의 영문, 소문자, 숫자로만 사용 가능합니다.');
				checkid = false;
				return
			} //id 유효성 검사
		
		$.ajax({
				type : "post" ,
				url : "idcheck.com" ,
				data : {"m_id" : m_id} , 
				success : function(idck) {
					if (idck == '1') {
						$("#id_message").css('color', 'green').html("사용 가능한 아이디입니다.");
						checkid = true;
					}else {
						$("#id_message").css('color', 'red').html("아이디 : 사용할수 없는 아이디입니다. 다른 아이디를 입력해주세요.");
						checkid = false;
					}
				}
		}); //ajaxid end
	})//id keyup end

		//우편번호 검색 버튼 클릭
	$("input[name=postcode]").click(function() {
		//window.open('post.html','post','width=500,height=200 ,scrollbars=yes');
		Postcode();
	});//$('#postcode').click
	
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
 function Postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
            	console.log(data.zonecode)
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
               $("input[name=m_zipcode]").val(data.zonecode);
               $("input[name=m_addr1]").val(fullRoadAddr);
            }
        }).open();
    }//function Postcode()
});