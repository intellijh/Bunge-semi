$(function() {
	
	if ($('.inf_cover').attr('src') != "") {
		$('.inf_cover').css('display', 'block')
	}
	
	$("#inputfile-btn").click(function() {
		let cntnofile = countnofile()
		console.log(cntnofile)
		let cntexistfile = existfile()
		console.log(cntexistfile)
		if (cntnofile <= 5) {
			$('.input-group'+(cntexistfile+1)).css('display', 'block')
		} 
		
		if (cntnofile == 0) {
			alert('파일 첨부는 5개까지 가능합니다...')
			const target = document.getElementById("inputfile-btn");
			target.disabled = true;
		}
		
		//console.log(inputcount)
	})
	
	
	$('#booksearch').click(function() {
		location.href = "Infobooksearch.com"
	})

	
	$("input[type=file]").change(function(){
		//console.log($(this).val())
		const inputfile = $(this).val().split('\\');
		//console.log(inputfile)
		//console.log($(this).attr('name'))
		//console.log($(this).attr('name').substr(8,1))
		$('#filevalue'+$(this).attr('name').substr(8,1)).text(inputfile[inputfile.length-1])
		const target = document.getElementById("inputfile-btn");
		target.disabled = false;
		if ($('.filename').text() != "") {
			$(".remove"+$(this).attr('name').substr(8,1)).css('display', 'inline-block')
		}
	})
	
	
	$(".remove1").click(function() {
		$("#filevalue1").text('');
		$("#preview1").attr('src','')
		$(".input-group1").css('display', 'none')
		$(this).css('display', 'none')
	})
	$(".remove2").click(function() {
		$("#filevalue2").text('');
		$("#preview2").attr('src','')
		$(".input-group2").css('display','none')
		$(this).css('display', 'none')
	})
	$(".remove3").click(function() {
		$("#filevalue3").text('');
		$("#preview3").attr('src','')
		$(".input-group3").css('display','none')
		$(this).css('display', 'none')
	})
	$(".remove4").click(function() {
		$("#filevalue4").text('');
		$("#preview4").attr('src','')
		$(".input-group4").css('display','none')
		$(this).css('display', 'none')
	})
	$(".remove5").click(function() {
		$("#filevalue5").text('');
		$("#preview5").attr('src','')
		$(".input-group5").css('display','none')
		$(this).css('display', 'none')
	})
	
$("form[name=boardform]").submit(function(e){
	
	
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
  
$(".cancel-btn").click(function(){
	location.href = "InfoList.com"
})
	
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
}) //ready end

function countnofile() {
	let nofile = 0;
	for (let i=1; i<=5; i++) {
		if ($('#filevalue'+i).text() == "") {
			nofile++
		}
	}
	return nofile;
}

function existfile() {
	let existfile = 0;
	for (let i=1; i<=5; i++) {
		if ($('#filevalue'+i).text() != "") {
			existfile++
		}
	}
	return existfile;
}

function readURL(input) {
	//console.log((input.name).substr(8,1))
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			document.getElementById('preview'+(input.name).substr(8,1)).src = e.target.result;
		}
		reader.readAsDataURL(input.files[0]);
	} else {
		document.getElementById('preview'+(input.name).substr(8,1)).src = "";
	}
}