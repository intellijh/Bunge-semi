$(function() {
	//성별 체크
	console.log($("#m_gender").val())
	let gender = $("#m_gender").val()
	if (gender == '남') {
		$("input[type=radio]:eq(0)").prop('checked','true')
	} else if (gender == '여') {
		$("input[type=radio]:eq(1)").prop('checked','true')
	}
	
	$(".cancelbtn").click(function(){
		location.href = "mypagechange.com"
	});
	
	//비밀번호 수정 버튼
//	$('#pwdchange').click(function(){
//		$('input[name=m_pwd]').val('').prop("readonly", false);
//	});
	//비밀번호 수정 방지
//	$('form[name=changeform]').on('submit',function(e){
//		const pwd = $($("input[name=m_pwd]")).val().trim();
//		if(pwd== "") {
//			e.preventDefault();
//			$("#pwd_message").css('color','red').html("비밀번호 : 비밀번호를 입력하세요.");
//			return false;
//		}
//	});

	//pwd 유효성 검사
	$("input[name=m_pwd]").on('keyup',
	function(){
		const patternpwd =/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		const pwd = $(this).val().trim();
		let originpwd = $("#origin_m_pwd").val().trim()
		
		if(pwd == "") {
			$("#pwd_message").css('color' , ' red').html("비밀번호 : 비밀번호를 입력하세요.");
			return false
		} else if (!patternpwd.test(pwd)) {
			$("#pwd_message").css('color', 'red').html("비밀번호:8~16자의 영문 대/소문자, 특수문자를 사용해 주세요.(/제외) ");
			return false
		} else if (pwd == originpwd) {
			$("#pwd_message").css('color', 'red').html("이전 비밀번호와 동일합니다... 다른 비밀번호를 입력하세요")
			return false
		} else if (patternpwd.test(pwd)) {
			$("#pwd_message").css('color', 'green').html("비밀번호:안전 합니다.");
		}
	});//pwd 유효성 검사	end
	
	//nick 유효성 검사 
$("input[name=m_nick]").on('keyup' ,
	function(){
		const patternick = /^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$/;
		const nick = $(this).val().trim();
		let originnick = $("#origin_m_nick").val().trim()
		
		if(nick == "") {
			$("#nick_message").css('color', 'red').html("닉네임 : 닉네임을 입력하세요.");
			return false
		} else if (!patternick.test(nick)){
			$("#nick_message").css('color', 'red').html("닉네임: 닉네임은 한글, 영문, 숫자만 가능하며 2-10자리 가능합니다.");
			return false
		} else if (nick == originnick) {
			$("#nick_message").css('color', 'red').html("이전 닉네임과 동일합니다... 다른 닉네임을 입력하세요")
			return false
		} else if (patternick.test(nick)) {
			$("#nick_message").css('color', 'green').html("닉네임 : 사용 가능한 닉네임입니다.")
		}
		
		$.ajax ({
				type : "post" ,
				url : "nickcheck.com" ,
				data : {"m_nick" : nick} ,
				success : function(nick) {
					if (nick != '-1') {
						$("#nick_message").css('color', 'red').text("닉네임 : 사용할 수 없는 닉네임 입니다. 다른 닉네임를 입력해주세요.");
						return false
					}
				}
		}); //ajaxnick end
	});//nick keyup end
	
	//상세주소 유효성 검사
$("input[name=m_addr2]").on('keyup',
	function(){
		const addr2 = $(this).val();
		if(addr2 == "") {
			$("#addr2_message").css('color','red').text("상세주소 : 주소를 입력해주세요.");
			return false
		} else {
			$("#addr2_message").css('color', 'green').text("상세주소 : 주소가 입력되었습니다.")
		}
});

//전화번호 유효성 검사
$("input[name=m_phone]").on('keyup' ,
	function(){
		const phone = $(this).val().trim();
		const patterpho = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		let originpho = $("#origin_m_phone").val()
		
			if(phone == "") {
				$("#pho_message").css('color', 'red').text("전화번호 : 전화번호는 필수 입니다.");
				return false;
			} else if (!patterpho.test(phone)) {
				$("#pho_message").css('color', 'red').text("전화번호 :  전화번호 형식에 맞지 않습니다.");
				return false;
			} else if (phone == originpho) {
				$("#pho_message").css('color', 'red').text("전화번호 : 이전 전화번호와 동일합니다... 다른 전화번호를 입력해주세요");
				return false;
			} else if (patterpho.test(phone)) {
				$("#pho_message").css('color', 'green').text("전화번호 : 전화번호를 알맞게 입력되었습니다.");
			}
	});//전화번호 유효성 검사 end
	
//이메일 유효성 검사 
$("input[name=m_email]").on('keyup', 
	function(){
		const email= $(this).val().trim();
		const patteremail =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		let originemail = $("#origin_m_email").val()

		if(email == "") {
			$("#email_message").css('color', 'red').text("이메일 : 이메일은 필수 입니다.");
			return false;
		} else if (!patteremail.test(email)) {
			$("#email_message").css('color', 'red').text("이메일 : 이메일 형식에 맞지 않습니다.");
			return false;
		} else if (originemail == email) {
			$("#email_message").css('color', 'red').text("이메일 : 이전 이메일과 동일합니다... 다른 이메일을 입력해주세요")
			return false
		} else if (patteremail.test(email)) {
			$("#email_message").css('color', 'green').text("이메일 : 사용 가능한 이메일 입니다.")
		}
		
		$.ajax ({
			type : "post" ,
				url : "emailcheck.com" ,
				data : {"m_email" : email} ,
				success : function(emck) {
					if (emck != '-1') {
			$("#email_message").css('color','red').text("이메일 : 사용할 수 없는 이메일입니다. 다른 이메일을 입력해주세요.");
			}
		}	
		});
	});//이메일 유효성 검사 end

	
	
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
	
})//ready end