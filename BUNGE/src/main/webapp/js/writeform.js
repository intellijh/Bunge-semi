$(function() {
/*	
	$("input[type=file]").change(function(){
		console.log($(this).val())
		const inputfile = $(this).val().split('\\');
		$(this).append(inputfile[inputfile.length -1]);
	});
*/	
	(/*att_zone : 이미지들이 들어갈 위치 id, btn : file tag id*/
	imageView = function imageView(att_zone, btn) {
		let attZone = document.getElementById(att_zone);
		let btnAtt = document.getElementById(btn);
		let sel_files = [];
		
		//이미지와 체크 박스를 감싸고 있는 div 속성
		let div_style = 'display:inline-block;position:relative;'
					  + 'width:150px;height:200px;margin:5px;border:1px solid #00f;z-index:1';
		//미리보기 이미지 속성
		let img_style = 'width:100%;height:90%;z-index:none';
		//첨부파일명
		let filename_style = 'width:120px;height:20px;position:absolute;right:10px;bottom:0px;z-index:999'
		//이미지안에 표시되는 체크박스 속성
		let chk_style = 'width:30px;height:30px;position:absolute;font-size:24px;'
					  + 'right:0px;bottom:0px;z-index:999;background-color:rgba(255,255,255,0.1);'
					  + 'color:#f00';
		
		btnAtt.onchange = function(e){
			let files = e.target.files;
			let fileArr = Array.prototype.slice.call(files)
			for (f of fileArr) {
				imageLoader(f);
			}
		}
		
		attZone.addEventListener('dragenter', function(e) {
			e.preventDefault();
			e.stopPropagation();
		}, false)
		
		attZone.addEventListener('dragover', function(e) {
			e.preventDefault();
			e.stopPropagation();
		}, false)
		
		attZone.addEventListener('drop', function(e) {
			let files = {};
			e.preventDefault();
			e.stopPropagation();
			let dt = e.dataTransfer;
			files = dt.files;
			for(f of files) {}
			imageLoader(f);
		}, false)
		
		/*첨부된 이미지들을 배열에 넣고 미리보기*/
		imageLoader = function(file) {
			sel_files.push(file);
			let reader = new FileReader();
			reader.onload = function(ee) {
				let img = document.createElement('img')
				img.setAttribute('style', img_style)
				img.src = ee.target.result;
				attZone.appendChild(makeDiv(img, file));
			}
			
			reader.readAsDataURL(file);
		}
		
		/*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환*/
		makeDiv = function(img, file) {
			let div = document.createElement('div')
			div.setAttribute('style', div_style)
			
			let filenamediv = document.createElement('div')
			let filename = document.createTextNode((file.name).substr(0,7)+'...')
			filenamediv.setAttribute('style', filename_style)
			
			let btn = document.createElement('input')
			btn.setAttribute('type', 'button')
			btn.setAttribute('value', 'x')
			btn.setAttribute('delFile', file.name)
			btn.setAttribute('style', chk_style);
			btn.onclick = function(ev) {
				let ele = ev.srcElement;
				let delFile = ele.getAttribute('delFile');
				for (var i=0; i<sel_files.length; i++) {
					if(delFile==sel_files[i].name) {
						sel_files.splice(i, 1);
					}
				}
			dt = new DataTransfer();
			for (f in sel_files) {
				let file = sel_files[f];
				dt.items.add(file);
			}
			btnAtt.files = dt.files;
			let p = ele.parentNode;
			attZone.removeChild(p)
		  }
		  div.appendChild(img)
		  div.appendChild(btn)
		  div.appendChild(filenamediv)
		  filenamediv.appendChild(filename)
		  return div
	   }
    }
	)('att_zone', 'btnAtt')
	
$("button").click(function(){
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
  
$("input[type=button]:eq(1)").click(function(){
	console.log('abcd');
	location.href="InfoList.com";
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
                $("#address").val(fullRoadAddr);
            }
        }).open();
	} //
 })
})
	
