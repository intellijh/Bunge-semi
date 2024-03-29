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
		
						
	for (let i=0; i<5; i++) {
		let html = "<input type='hidden' value='"+confimrnames[i]+"' name='check"+i+"'>";
		console.log(html);
		$(this).append(html);
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
	
	
	let filenames = new Array(5)
	let changenames = new Array(5)
	let confirmnames = new Array(5)
	for (let i=0; i<5; i++) {
		filenames[i] = $("#filevalue"+(i+1)).text()
	}
	
	$("input[type=file]").change(function() {
		console.log($(this).val())
		let thisid = $(this).attr("id")
		const inputfile = $(this).val().split('\\');
		let change = inputfile[inputfile.length - 1]
		$(this).next().text(change)
		changenames[thisid.substr(7,7)] = change
			
		})
		
	for (let i=0; i<5; i++) {
		if (filenames[i] != changenames[i]) {
			confirmnames[i] = changenames[i]
		} else {
			confirmnames[i] = filenames[i]
		}
	}
	
	console.log(confirmnames)

		
		
	
	//remove 이미지를 클릭하면 파일명을 ''로 변경하고 remove 이미지를 보이지 않게 한다.
	
	$(".remove1").click(function() {
		$("#filevalue1").remove('');
		$(".uploadedfile1").remove();
		$(".remove1").css('display','none')
	})
	$(".remove2").click(function() {
		$("#filevalue2").remove('');
		$(".uploadedfile2").remove();
		$(".remove2").css('display','none')
	})
	$(".remove3").click(function() {
		$("#filevalue3").remove('');
		$(".uploadedfile3").remove();
		$(".remove3").css('display','none')
	})
	$(".remove4").click(function() {
		$("#filevalue4").remove('');
		$(".uploadedfile4").remove();
		$(".remove4").css('display','none')
	})
	$(".remove5").click(function() {
		$("#filevalue5").remove('');
		$(".uploadedfile5").remove();
		$(".remove5").css('display','none')
	})
})