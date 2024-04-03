$(function() {
	//성별 체크
	$("input[value='${memberinfo.member.m_gender}']").prop('checked',true);
	
	$(".cancelbtn").click(function(){
		history.back();
	});
	
	//비밀번호 수정 버튼
	$('#pwdchange').click(function(){
		$('input[name=m_pwd]').val('');
	});
	
	//닉네임 수정 버튼
	$('#nickchange').click(function(){
		$('input[name=m_nick]').val('');
	});
	
	//전화번호 수정 버튼
	$('#phonechange').click(function(){
		$('input[name=m_phone]').val('');
	});
	
	//이메일 수정 버튼
	$('#emailchange').click(function(){
		$('input[name=m_email]').val('');
	});
	
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

                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

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
    
    $('input[type=file]').change(function(event) {
		const inputfile = $(this).val().split('\\');
		const filename=inputfile[inputfile.length - 1];//inputfile.length -1 = 2
		
		const pattern = /(gif|jpg|jpeg|png)$/i; //i(ignore case)는 댓문자 무시를 의미
		if(pattern.test(filename)) {
			$('#filename').text(filename);
			
			const reader = new FileReader(); //파일을 읽기 위한 객체 생성
			
			//DataURL 형식 (접두사 data:가 붇은 URL이며 바이너리 파일을 Base64로 인코딩하여 ASCII문자열 형식으로)
			//파일을 읽어옵니다. (참고-Base64 인코딩은 바이너리 데이터를 Text로 변경하는 Encoding입니다.)
			//읽어온 결과는 reader객체의 result 속성에 저장됩니다.
			//event.target.fils[0] : 파일리스트에서 첫번째 객체를 가져옵니다.
			reader.readAsDataURL(event.target.files[0]);
			
			reader.onload = function() {// 읽기에 성공했을 때 실행되는 이벤트 핸들러
				$('#showImage > img').attr('src', this.result);
			};
		} else {
			alert('이미지 파일(gif,jpg,jpeg,png)이 아닌 경우는 무시됩니다.');
			$('#filename').text('');
			$('#showImage > img').attr('src', 'image/profile.png');
			$(this).val('');
			$('input[name=check]').val('');
		}
	}); //change()
})