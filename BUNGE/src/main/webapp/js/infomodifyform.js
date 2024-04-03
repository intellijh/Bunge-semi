$(document).ready(function() {
	let check1 = 0
	let check2 = 0
	let check3 = 0
	let check4 = 0
	let check5 = 0
	
	let filenames = new Array(5)
	let changenames = new Array(5)
	let nochangefiles = new Array(5)
	for (let i=0; i<5; i++) {
		console.log($("#filename"+(i+1)).text())
		filenames[i] = $("#filename"+(i+1)).text()
	}
	console.log('filenames : ' + filenames)
	
	
	for (let i=1; i<=5; i++) {
		const html_origin = "<input type='hidden' value='" + $('#filename'+i).text() + "' name='originvalue"+i+"'>"
		console.log(html_origin)
		$("form").append(html_origin);
	}
		
		
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
		
	

/*		
	 if (check1 == 0) {
		 const name = $('#filename1').text()
		 const html = "<input type='hidden' value='" + name + "' name='inf_file1'>"
		 console.log(html);
		 $(this).append(html);
	 }
	 
	 if (check2 == 0) {
		 const name = $('#filename2').text()
		 const html = "<input type='hidden' value='" + name + "' name='inf_file2'>"
		 console.log(html);
		 $(this).append(html);
	 }
	 
	 if (check3 == 0) {
		 const name = $('#filename3').text()
		 const html = "<input type='hidden' value='" + name + "' name='inf_file3'>"
		 console.log(html);
		 $(this).append(html);
	 }
	 
	 if (check4 == 0) {
		 const name = $('#filename4').text()
		 const html = "<input type='hidden' value='" + name + "' name='inf_file4'>"
		 console.log(html);
		 $(this).append(html);
	 }
	 
	 if (check5 == 0) {
		 const name = $('#filename5').text()
		 const html = "<input type='hidden' value='" + name + "' name='inf_file5'>"
		 console.log(html);
		 $(this).append(html);
	 }
*/		
		
		
		
		//수정 폼에서 최종적으로 첨부된 목록
		
		for (let i=1; i<=5; i++) {
			
			if ($('#filename'+i).text() != '0') {
				console.log('전송될 filevalue : ' + $('#filename'+i).text())
				const html = "<input type='hidden' value='" + $('#filename'+i).text() + "' name='filevalue"+i+"'>"
				console.log(html)
				$("form").append(html);
			}
		}
		
	});//submit end
	
	
	//'검색' 버튼을 눌렀을 때
	$('#booksearch').click(function() {
		location.href = "Infobooksearch.com"
	})

	
	
	$("#remove1").click(function() {
		$("#filename1").text('');
		$(".uploadedfile1").attr('src','');
		$(".uploadedfile1").css('display','none')
		$('.input-group1').css('display','none')
		$("#preview1").attr('src','')
		$("#preview1").css('display','none')
		$("#remove1").css('display','none')
	})
	$("#remove2").click(function() {
		$("#filename2").text('');
		$(".uploadedfile2").attr('src','');
		$(".uploadedfile2").css('display','none')
		$('.input-group2').css('display','none')
		$("#preview2").attr('src','')
		$("#preview2").css('display','none')
		$("#remove2").css('display','none')
	})
	$("#remove3").click(function() {
		$("#filename3").text('');
		$(".uploadedfile3").attr('src','');
		$(".uploadedfile3").css('display','none')
		$('.input-group3').css('display','none')
		$("#preview3").attr('src','')
		$("#preview3").css('display','none')
		$("#remove3").css('display','none')
	})
	$("#remove4").click(function() {
		$("#filename4").text('');
		$(".uploadedfile4").attr('src','');
		$(".uploadedfile4").css('display','none')
		$('.input-group4').css('display','none')
		$("#preview4").attr('src','')
		$("#preview4").css('display','none')
		$("#remove4").css('display','none')
	})
	$("#remove5").click(function() {
		$("#filename5").text('');
		$(".uploadedfile5").attr('src','');
		$(".uploadedfile5").css('display','none')
		$('.input-group5').css('display','none')
		$("#preview5").attr('src','')
		$("#preview5").css('display','none')
		$("#remove5").css('display','none')
	})

	
	
	for (let i=1; i<=5; i++) {
		if ($('#filename'+i).text() == '') {
			$('#remove'+i).css('display','none')
			$('.input-group'+i).css('display','none')
		}
	}
	

	
	
	//'파일추가' 버튼을 클릭하면 input할 수 있는 폼이 나온다.
	$("#inputfile-btn").click(function() {
		let checknumber = countnofile()
		console.log('checknumber : ' + checknumber)
		let first = firstdisplaynone();
		console.log('firstdisplaynone : ' + first)
		if (checknumber != 0) {
			$('.input-group'+first).css('display', 'block')
		} else {
			alert('파일 첨부는 최대 5개까지 가능합니다...')
			const target = document.getElementById("inputfile-btn");
			target.disabled = true;
		}
		//console.log(inputcount)
	})

	
	$("#upfile1").change(function() {
		//check1++
		console.log($(this).val())
		let thisid = $(this).attr("id")
		console.log('thisid:' + thisid)
		const inputfile = $(this).val().split('\\');
		let change = inputfile[inputfile.length - 1]
		$('#preview'+thisid.substr(6,1)).css('display','inline-block')
		$('#filename'+thisid.substr(6,1)).text(change)
		$('#remove'+thisid.substr(6,1)).css('display','inline-block')
		$('.uploadedfile1').css('display','none')
		console.log('change : '+change);
		changenames[thisid.substr(6,1)-1] = change
		console.log('changenames : ' + changenames)
		console.log(changenames)
	})
	
	$("#upfile2").change(function() {
		//check2++
		console.log($(this).val())
		let thisid = $(this).attr("id")
		console.log('thisid:' + thisid)
		const inputfile = $(this).val().split('\\');
		let change = inputfile[inputfile.length - 1]
		$('#preview'+thisid.substr(6,1)).css('display','inline-block')
		$('#filename'+thisid.substr(6,1)).text(change)
		$('#remove'+thisid.substr(6,1)).css('display','inline-block')
		$('.uploadedfile2').css('display','none')
		console.log('change : '+change);
		changenames[thisid.substr(6,1)-1] = change
		console.log('changenames : ' + changenames)
		console.log(changenames)
	})
	
	$("#upfile3").change(function() {
		//check3++
		console.log($(this).val())
		let thisid = $(this).attr("id")
		console.log('thisid:' + thisid)
		const inputfile = $(this).val().split('\\');
		let change = inputfile[inputfile.length - 1]
		$('#preview'+thisid.substr(6,1)).css('display','inline-block')
		$('#filename'+thisid.substr(6,1)).text(change)
		$('#remove'+thisid.substr(6,1)).css('display','inline-block')
		$('.uploadedfile3').css('display','none')
		console.log('change : '+change);
		changenames[thisid.substr(6,1)-1] = change
		console.log('changenames : ' + changenames)
		console.log(changenames)
	})
	
	$("#upfile4").change(function() {
		//check4++
		console.log($(this).val())
		let thisid = $(this).attr("id")
		console.log('thisid:' + thisid)
		const inputfile = $(this).val().split('\\');
		let change = inputfile[inputfile.length - 1]
		$('#preview'+thisid.substr(6,1)).css('display','inline-block')
		$('#filename'+thisid.substr(6,1)).text(change)
		$('#remove'+thisid.substr(6,1)).css('display','inline-block')
		$('.uploadedfile4').css('display','none')
		console.log('change : '+change);
		changenames[thisid.substr(6,1)-1] = change
		console.log('changenames : ' + changenames)
		console.log(changenames)
	})
	
	$("#upfile5").change(function() {
		//check5++
		console.log($(this).val())
		let thisid = $(this).attr("id")
		console.log('thisid:' + thisid)
		const inputfile = $(this).val().split('\\');
		let change = inputfile[inputfile.length - 1]
		$('#preview'+thisid.substr(6,1)).css('display','inline-block')
		$('#filename'+thisid.substr(6,1)).text(change)
		$('#remove'+thisid.substr(6,1)).css('display','inline-block')
		$('.uploadedfile5').css('display','none')
		console.log('change : '+change);
		changenames[thisid.substr(6,1)-1] = change
		console.log('changenames : ' + changenames)
		console.log(changenames)
	})


		for (let i=0; i<5; i++) {
			if (changenames[i] == null) {
				nochangefiles[i] = filenames[i]
			} else {
				nochangefiles[i] = ""
			}
			console.log('nochangefiles : ' + nochangefiles);
			console.log(nochangefiles)
		}
	
	
	
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

function countnofile() {
	let nofile = 0;
	for (let i=1; i<=5; i++) {
		if ($('#filename'+i).text() == "") {
			nofile++
		}
	}
	return nofile;
}

function nodisplaynone() {
	for (let i=1; i<=5; i++) {
		console.log($('.input-group'+i).attr('span'))
	}
}

function firstdisplaynone() {
	let first = 0;
	for (let i=1; i<=5; i++) {
			 first++
		if ($('#filename'+i).text() == "") {
			 break;
		}
	}
	return first;
}

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