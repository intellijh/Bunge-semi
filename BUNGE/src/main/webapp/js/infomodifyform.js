$(document).ready(function() {
	let check=0;
	
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
		
		const html = "<input type='hidden' value='" + filenames + "' name='check'>";
		console.log(html);
		$(this).append(html);
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
	
	
	let filenames = new Array(5)
	let changenames = new Array(5)
	for (let i=0; i<5; i++) {
		console.log($("#filevalue"+(i+1)).text())
		filenames[i] = $("#filevalue"+(i+1)).text()
	}
	console.log(filenames)
	
	$("input[type=file]").change(function() {
		console.log($(this).val())
		let thisid = $(this).attr("id")
		console.log(thisid)
		const inputfile = $(this).val().split('\\');
		let change = inputfile[inputfile.length - 1]
		$('#filevalue'+thisid.substr(6,1)).text(change)
		$('.uploadedfile'+thisid.substr(6,1)).attr('src','')
		console.log('change : '+change);
		changenames[thisid.substr(6,1)-1] = change
		console.log('changenames : ' + changenames)
		console.log(changenames)


		for (let i=0; i<5; i++) {
			if (filenames[i] != changenames[i] && changenames[i]!=null) {
				filenames[i] = changenames[i]
			} else {
				filenames[i] = filenames[i]
			}
		}
			console.log(filenames);
	})//input[type=file].change end
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