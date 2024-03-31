$(document).ready(function() {
	let check = 0
	
	let filenames = new Array(5)
	let changenames = new Array(5)
	let nochangefiles = new Array(5)
	for (let i=0; i<5; i++) {
		console.log($("#filevalue"+(i+1)).text())
		filenames[i] = $("#filevalue"+(i+1)).text()
	}
	console.log('filenames : ' + filenames)
	
	//submit 버튼 클릭할 때 이벤트 부분
	$("form[name=modifyform]").submit(function() {
		const $inf_subject = $("#inf_subject");
		if ($.trim($inf_subject.val())=="") {
			alert("제목을 입력하세요");
			$inf_subject.focus();
			return false;
		}
		
		const $inf_content = $("#inf_content");
		if ($.trim($inf_content.val()) == "") {
			alert("내용을 입력하세요");
			$inf_content.focus();
			return false;
		}
		
		
		const html_origin = "<input type='hidden' value='" + filenames + "' name='originvalue'>"
		console.log(html_origin)
		$("form").append(html_origin);
		
		
		//파일변동이 없는 경우
		if (check == 0) {
			for (let i=1; i<=5; i++) {
				
				if ($('#filevalue'+i).text() != '0') {
					console.log('전송될 filevalue : ' + $('#filevalue'+i).text())
					const html = "<input type='hidden' value='" + $('#filevalue'+i).text() + "' name='filevalue"+i+"'>"
					console.log(html)
					$("form").append(html);
				}
			}
		} 
	});//submit end
	
	function show() {
		//파일 이름이 있는 경우 remove 이미지를 보이게 하고
		//파일 이름이 없는 경우 remove 이미지 보이지 않게 한다.
		for (let i=0; i<$("c:forEach").attr("varStatus"); i++) {
			
		if ($('#filevalue'+i).text() == '') {
			$(".remove").css('display', 'none');
		} else {
			$(".remove").css({'display' : 'inline-block',
							  });
		}
		}
	}
	
	show();
	
	
	//remove 이미지를 클릭하면 파일명을 ''로 변경하고 remove 이미지를 보이지 않게 한다.
	
	$(".remove1").click(function() {
		$("#filevalue1").text('');
		$(".uploadedfile1").attr('src','');
		$("#preview1").attr('src','')
		$(".remove1").css('display','none')
	})
	$(".remove2").click(function() {
		$("#filevalue2").text('');
		$(".uploadedfile2").attr('src','');
		$("#preview2").attr('src','')
		$(".remove2").css('display','none')
	})
	$(".remove3").click(function() {
		$("#filevalue3").text('');
		$(".uploadedfile3").attr('src','');
		$("#preview3").attr('src','')
		$(".remove3").css('display','none')
	})
	$(".remove4").click(function() {
		$("#filevalue4").text('');
		$(".uploadedfile4").attr('src','');
		$("#preview4").attr('src','')
		$(".remove4").css('display','none')
	})
	$(".remove5").click(function() {
		$("#filevalue5").text('');
		$(".uploadedfile5").attr('src','');
		$("#preview5").attr('src','')
		$(".remove5").css('display','none')
	})
	
	

	
	$("input[type=file]").change(function() {
		check++
		console.log($(this).val())
		let thisid = $(this).attr("id")
		console.log(thisid)
		const inputfile = $(this).val().split('\\');
		let change = inputfile[inputfile.length - 1]
		$('#preview'+thisid.substr(6,1)).css('display','inline-block')
		$('#filevalue'+thisid.substr(6,1)).text(change)
		$('.uploadedfile'+thisid.substr(6,1)).css('display','none')
		$('.remove'+thisid.substr(6,1)).css('display','inline-block')
		console.log('change : '+change);
		changenames[thisid.substr(6,1)-1] = change
		console.log('changenames : ' + changenames)
		console.log(changenames)


		for (let i=0; i<5; i++) {
			if (changenames[i] == null) {
				nochangefiles[i] = filenames[i]
			} else {
				nochangefiles[i] = ""
			}
		}
			console.log('nochangefiles : ' + nochangefiles);
			console.log(nochangefiles)
	})//input[type=file].change end
	
	
	
	$("#postcode").click(function () {
//		window.open("post.html", "post", "width=400,height=500,scrollbars=yes");
		Postcode();
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
                $("#inf_loc").val(fullRoadAddr);
            }
        }).open();
	} //Postcode() end
 }) //$("#postcode").click end
})// ready end

	function readURL(input) {
		console.log((input.id).substr(6,1))
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview'+(input.id).substr(6,1)).src = e.target.result;
			}
			reader.readAsDataURL(input.files[0]);
		} else {
			document.getElementById('preview'+(input.id).substr(6,1)).src = "";
		}
	}