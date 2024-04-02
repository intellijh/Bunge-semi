let option = 1; // 선택한 등록순과 최신순을 수정, 삭제,추가 후에도 유지되도록 하기 위한 변수로 사용합니다.

function getList(state){//현재 선택한 댓글 정렬방식을 저장합니다. 1=>등록순, 2=>최신순
	    console.log(state)
	    option=state;
	    
	    $.ajax({
			type:"post",
			url : "CommentList.com",
			data: {inf_num : $("#inf_num").val(), state:state},
			dataType : "json",
			success : function(rdata){
				$('#count').text(rdata.listcount).css('font-family','arial,sans-serif')
				let red1 = 'red';
				let red2 = 'red';
				if(state == 1) {
					red2 = 'gray';
				}else if(state == 2) {
					red1 = 'gray';
				}
				let output = "";
				
			if(rdata.commentlist.length > 0) {
				output += '<li class="comment-order-item ' + red1 + '">'
					   + '	<a href="javascript:getList(1)" class="comment-order-button">등록순 </a>'
					   + ' </li>'
					   + ' <li class="comment-order-item ' + red2 + '">'
					   + '	<a href="javascript:getList(2)" class="comment-order-button">최신순 </a>'
					   + ' </li>'
					   + ' <li id=comm_num>'
				$('.comment-order-list').html(output);
				
				output = '';
				$(rdata.commentlist).each(function (){
					const lev = this.comm_lev;
					let comment_reply = '';
					 if(lev == 1) {
						 comment_reply = ' comment-list-item--reply lev1';
					 }else if(lev == 2) {
						 comment_reply = ' comment-list-item--reply lev2';
					}
					const profile = this.memberfile;
					let src = 'image/profile.png';
					if(profile) {
						src = 'memberupload/' + profile;
					}
					
				output += '<li id="' + this.comm_num + '" class="comment-list-item' + comment_reply + '">   '
	     		   	   + '	<div class="comment-nick-area">' 
	      			   + '    <img src="' + src + '" alt="프로필 사진" width="36" height="36">'    
	       			   + '    <div class="comment-box"> '     
	         		   + '		<div class="comment-nick-box">'            
	               	   + '			<div class="comment-nick-info">'               
	         	       + '				<div class="comment-nickname">' + this.m_id + '</div>'
	          	       + '			</div>'       
	         	       + '		</div>'    
	    		       + '	  </div>'
	    		       + '<div class="comment-like">'
					   + '    <button class="like" id="like" data-comm_num=' + this.comm_num + '>좋아요</button>'
					   + '    <span class="likecount"></span>'
					   + '	  <button class="hate" id="hate" data-comm_num=' + this.comm_num + '>싫어요</button>'	
					   + '    <span class="hatecount"></span>'
					   + '</div>'    
		      	       + '	  <div class="comment-text-box">'       
		      		   + '	    <p class="comment-text-view">'         
	       		       + '		   <span class="text-comment">' + this.comm_content + '</span>'       
	         	       + '		</p>'    
	     		       + '	  </div>'    
	         	       + '	  <div class="comment-info-box">' 
	         	       + ' 		<span class="comment-info-date">' + this.comm_reg + '</span> ' 
	        if (lev < 2) {
				output += ' <a href="javascript:replyform(' + this.comm_num +','
					   + lev + ',' + this.comm_seq + ','	
					   + this.comm_ref + ')" class="comment-info-button">답글쓰기</a>'   
				}
				output += '	  </div>'
				
			if($("#loginid").val() == this.m_id) {    

				output +='<div class="comment-tool">'
					   + '	<div title="더보기" class="comment-tool-button">'
					   + '		<div>&#46;&#46;&#46;</div>'
					   + '	</div>'		
					   + '	<div id="comment-list-item-layer' + this.comm_num + '" class="LayerMore">'		
					   + '	 <ul class="layer-list">'		
					   + '	  <li class="layer-item">'		
					   + '	   <a href="javascript:updateForm('+ this.comm_num +')"' 
					   + '		  class="layer-button">수정</a>&nbsp;&nbsp;'		
					   + '	   <a href="javascript:del('+ this.comm_num +')"' 
					   + '	      class="layer-button">삭제</a></li></ul>'	
					   + '	</div>'
					   + ' </div>'
					}
					
					output += '</div>'
						   + '</li>'	
				})
				
				$('.comment-list').html(output);
			}
			else {	//댓글 1개가 있는 상태에서 삭제하는 경우 갯수는 0이라 if문을 수행하지 않고 이곳으로 옵니다
					//이곳에서 아래의 두 영역을 없앱니다.
				$('.comment-list').empty();
				$('.comment-order-list').empty();
			}
		}
		})
	}//function(getList) end
	
//더보기-수정 클릭한 경우에 수정 폼을 보여줍니다.
function updateForm(num){ //num : 수정할 댓글 글번호
	//수정 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겨요
	$(".comment-tool").hide();
	
	$(".LayerMore").hide(); //수정 삭제 영역도 숨겨요
	
	let $num = $('#'+num);
	
	//선택한 내용을 구합니다.
	const content = $num.find('.text-comment').text();
	
	const  selector = '#'+num + '> .comment-nick-area'
	$(selector).hide(); //selector 영역 숨겨요 - 수정에서 취소를 선택하면 보여줄 예정입니다.
	
	//$('.comment-list+.comment-write').clone() : 기본 글쓰기 영역 복사합니다.
	//글이 있던 영역에 글을 수정할 수 있는 폼으로 바꿉니다.
	$num.append($('.comment-list+.comment-write').clone());
	
	//수정 폼의 <textarea>에 내용을 나타냅니다.
	$num.find('textarea').val(content);
	
	//'.btn-register' 영역에 수정할 글 번호를 속성 'data-id'에 나타내고 클래스 'update'를 추가합니다.
	$num.find('.btn-register').attr('data-id',num).addClass('update').text('수정완료');
	
	//폼에서 취소를 사용할 수 있도록 보이게 합니다.
	$num.find('.btn-cancel').css('display','block');
	
	const count = content.length;
	$num.find('.comment-write-area-count').text(count+"/200");
}//function(updateForm) end

	
	
//더보기 -> 삭제 클릭한 경우 실행하는 함수
function del(num){//num : 댓글 번호
  	 if(!confirm('정말 삭제하시겠습니까?')) {
		   $('#comment-list-item-layer' + num).hide(); //'수정 삭제' 영역 숨겨요
		   return;
	   }
	   	$.ajax({
			url : 'CommentDelete.com', //원문 등록
			data : {inf_num : num},
			success : function(rdata) {
				if(rdata == 1) {
					getList(option);
				}
			} 			
		})
}//function(del) end


//답글 달기 폼
function replyform(num,lev,seq,ref){
	//수정 삭제 영역 선택 후 답글 쓰기를 클릭한 경우
	$(".LayerMore").hide(); //수정 삭제 영역 숨겨요
	
	let output = '<li class="comment-list-item comment-list-item--reply lev'  +  lev + '"></li>'
	const $num = $('#'+num);
	//선택한 글 뒤에 답글 폼을 추가합니다.
	$num.after(output);
	
	//글쓰기 영역을 복사합니다.
	 output = $('.comment-list+.comment-write').clone();
	 
	 const $num_next = $num.next();
	 //선택한 글 뒤에 답글 폼 생성합니다.
	 $num_next.html(output);
	 
	 //답글 폼의 <textarea>의 속성 'placeholder'를 '답글을 남겨보세요'로 바꾸어 줍니다.
	 $num_next.find('textarea').attr('placeholder','답글을 남겨보세요');
	 
	 //답글 폼의 '.btn-cancel'을 보여주고 클래스 'reply-cancel' 를 추가합니다.
	  $num_next.find('.btn-cancel').css('display','block').addClass('reply-cancel');
	  
	  //답글 폼의 '.btn-cancel'에 클래스 'reply' 추가합니다.
	  //속성 'data-ref'에 ref,'data-lev'에 lev,'data-seq'에 seq 값을 설정합니다.
	  //등록된 답글 완료로 변경합니다.
	  $num_next.find('.btn-register').addClass('reply')
	  		   .attr('data-ref',ref).attr('data-lev',lev).attr('data-seq',seq).text('답글완료');
	  		   
	  
}//function(replyform) end

$(function() {
	let likecount = 0;
	
	getList(option);  //처음 로드 될때는 등록순 정렬
	
	$('.comment-area').on('keyup','.comment-write-area-text', function() {
		const length = $(this).val().length;
		$(this).prev().text(length+'/200');
	});// keyup','.comment-write-area-text', function() {
	
	
	//댓글 등록을 클릭하면 데이터베이스에 저장 -> 저장 성공 후에 리스트 불러옵니다.
	$('ul+.comment-write .btn-register').click(function() {
		const comm_content = $('.comment-write-area-text').val();
		if(!comm_content) { //내용 없이 등록 클릭한 경우
			alert("댓글을 입력하세요");
			return;
		}
		
		$.ajax({
			url : 'CommentAdd.com', //원문 등록
			dataType : "json",
			cache : "false",
			data : {
				m_id : $("#loginid").val(),
				comm_content : comm_content,
				inf_num : $("#inf_num").val(),
				comm_lev : 0, //원문인 경우 comment_re_seq는 0,
									//comment_re_ref는 댓글의 원문 글번호
				comm_seq : 0
			},
			type : 'post',
			success : function(rdata) {
				console.log('commentaddaction 성공!!')
				if(rdata.ok == 1) {
					getList(option);
				}
				
				console.log('rdata.comm_num :' + rdata.comm_num)
				if(rdata.comm_num != -1) {
					
				}
			},
			error : function() {
				console.log('commentadd 댓글 등록 ajax 실패')
			}
		})
		
		$('.comment-write-area-text').val('');	//textarea 초기화
		$('.comment-write-area-text').text('0/200'); //입력한 글 카운트 초기화
		
	})// $('.btn-register').click(function(){
	
	
	//더보기를 클릭한 경우
	$(".comment-list").on('click', '.comment-tool-button', function() {        		
	//더보기를 클릭하면 수정과 삭제 영역이 나타나고 다시 클릭하면 사라져요
	$(this).next().toggle();
	
	//클릭 한 곳만 수정 삭제 영역이 나타나도록 합니다.
	$(".comment-tool-button").not(this).next().hide();
	})
	
	//수정 후 수정완료를 클릭한 경우
	$('.comment-area').on('click','.update',function(){
		const comm_content = $(this).parent().parent().find('textarea').val();
		if(!comm_content){ //내용없이 등록 클릭한 경우
			alert("수정할 글을 입력하세요.");
			return;	
		}
		const comm_num = $(this).attr('data-id'); 
		$.ajax({
			url : 'CommentUpdate.com',
			data : {comm_num:comm_num, comm_content:comm_content},
			success : function(rdata) {
				if(rdata == 1) {
					getList(option);
				}
			}
		})		
	})//수정 후 수정완료를 클릭한 경우
	
	
	//수정 후 취소 버튼을 클릭한 경우
	$('.comment-area').on('click','.btn-cancel',function(){
		//댓글 번호를 구합니다
		const comm_num = $(this).next().attr('data-id');
		const selector = '#' + comm_num;
		
		//.comment-write 영역 삭제합니다.
		$(selector + '.comment-write').remove();
		
		//숨겨두었던  .comment-nick-area 영역 보여줍니다.
		$(selector + '>.comment-nick-area').css('display','block');
		
		//수정 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더보기 영역을 숨겼는데 취소를 선택하면 보여주도록 합니다.
		$(".comment-tool").show();
	})//수정 후 취소 버튼을 클릭한 경우
	
	
	//답글완료 클릭한 경우
	$('.comment-area').on('click','.reply',function(){
		
		const comm_content = $(this).parent().parent().find('.comment-write-area-text').val();
		if(!comm_content) {//내용없이 답글 완료한 경우
		alert("답글을 입력하세요");
		return;
		}
		const comm_ref = $(this).attr('data-ref');
		const comm_lev = $(this).attr('data-lev');
		const comm_seq = $(this).attr('data-seq');
		
		$.ajax({
			url : "CommentReply.com",
			data : {
					m_id :$('#loginid').val(), 
					comm_content : comm_content,
					inf_num : $("#inf_num").val(),
					comm_lev : comm_lev,
					comm_ref : comm_ref,
					comm_seq : comm_seq
					},
			type : 'post',
			success : function(rdata) {
				if(rdata == 1) {
					getList(option);
				}
			}
		})	
	})//답글완료 클릭한 경우
	
	//답글쓰기 후 취소 버튼을 클릭한 경우
	$('.comment-area').on('click','.reply-cancel',function(){
		$(this).parent().parent().parent().remove();
		$(".comment-tool").show(); //더 보기 영역 보이도록 합니다.
	})//답글쓰기  후 취소 버튼을 클릭한 경우
	
	//답글쓰기 클릭 후 계속 누르는 것을 방지하기 위한 작업
	$('.comment-area').on('click','.comment-info-button',function(event){
	//답볍쓰기 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더보기 영역을 숨겨요
	$(".comment-tool").hide();		
	
	//답글쓰기 폼의 갯수를 구합니다.
	const length = $(".comment-area .btn-register.reply").length;
	if(length == 1) { //답글 쓰기 폼이 한개가 존재하면 anchor 태그 (<a>)의 기본 이벤트를 막아
					  //또 다른 답글쓰기 폼이 나타나지 않도록 합니다.
		event.preventDefault();				  
		}
	})//답글쓰기 클릭 후 계속 누르는 것을 방지하기 위한 작업
	
	//댓글 좋아요 버튼 클릭시(좋아요 추가 또는 좋아요 철회)
	$('.comment-list').on('click', '.like', function() {
		console.log('클릭중');
		$.ajax({
			url : "InfocommLike.com",
			type : "POST",
			data : {
				comm_num : $(this).attr("data-comm_num"),
				m_id : $("#loginid").val()
			},
			success : function () {
				console.log('댓글 좋아요 데이터 받아 왔다')
				commlikecount();
			},
			error : function() {
				console.log('댓글 좋아요 버튼 실패')
			}
		})
		
		$.ajax ({
			url : "InfocommLikeCount.com",
			type : "POST",
			data : {
				comm_num : $(this).attr("data-comm_num"),
				m_id : $("#loginid").val()
			},
			success : function (rdata) {
				console.log('댓글 카운트 ajax 성공')
				if (rdata) {
					$(this).find('span').html(rdata)
				}
			}
		})
		
	//댓글 싫어요 버튼 클릭시
		
	})
	infolikecnt();
	
	$('#likeclick').click(function(){
		let url = "";
		if(likecount == 1) {
			url = "InfoLikeDelete.com";
		}else if(likecount == 0) {
			url = "InfoLikeAdd.com";
		}
		$.ajax({
			url : url,
			type : 'post',
			data : { 
				m_id :$('#loginid').val(),
				inf_num : $("#inf_num").val()
			},
			async : false,
			success : function(rdata) {
				if (rdata == 1) 
				console.log("rdata.add : " + rdata);
				$('#likecnt').html(rdata);
				infolikecnt();
			}, 
			error : function(){
				console.log('infolikecnt 실패');
			}		
		});
	})

	function infolikecnt(){
		$.ajax({
			url : "InfoLikeCnt.com",
			type : 'post',
			data : { 
				m_id :$('#loginid').val(),
				inf_num : $("#inf_num").val()
			},
			dataType : 'json',
			success : function(rdata) {
				
				if (rdata.cnt != -1) {
				console.log('rdata.cnt2 :'+ rdata.cnt); 
				likecount = rdata.check;
				console.log('rdatalike :'+ likecount);
				$('#likecnt').html(rdata.cnt);
				}
				
				if(rdata.check == 1){
					console.log('rdata.check :' + rdata.check);
					$('.imglike img').attr('src',"./image/like_on.png");
				}else if(rdata.check == 0) {
					$('.imglike img').attr('src',"./image/like_off.png");
				}
				}, 
			error : function(){
				console.log('infolikecnt 실패');
			}		
	});
}
})//ready
/*
function commlikecount() {
	$.ajax ({
		url : "InfocommLikeCount.com",
		type : "POST",
		data : {
			comm_num :
			m_id :
		}
	})
}

*/
	/*
	//댓글 좋아요 카운트
	function likeCount() {
		$.ajax ({
			url : "InfocommLikeCount.com",
			type : "POST",
			data : {
				comm_num : $().attr("data-comm_num"),
				m_id : $("#loginid").val()
			},
			success : function (rdata) {
				console.log('댓글 카운트 ajax 성공')
				if (rdata) {
					$(".likecount").html(rdata);
				}
			}
		})
	}
	*/
