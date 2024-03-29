// 해당 video id 전역변수 설정
videoId = $('#videoId').val();
// 페이지 로드할 때 댓글 로드
$(document).ready(getCommentList());

function commentSubmit(){
	const author = $('#comment-write-author').val();
	const password =  $('#comment-write-password').val();
	const desc = $('#comment-write-desc').val();
	
	// 유효성 검사
	if (author.length < 2 || author.length > 15){
		alert('작성자는 2자 이상 15자 이하로 입력해주세요');
		return;
	}
	
	if (password.length < 2 || password.length > 15){
		alert('비밀번호는 2자 이상 15자 이하로 입력해주세요');
		return;
	}
	
	if (desc.length < 2 || desc.length > 100){
		alert('내용은 2자 이상 100자 이하로 입력해주세요');
		return;
	}
	
	// ajax 요청
	$.ajax({
        type:"POST",
        url:"comment.jsp",
        data:{
			"query":"insert",
			"videoId": videoId,
			"author":author,
			"password":password,
			"desc":desc
		},
        success:function(data){
			if(data.success){
				// 댓글 입력창 초기화
				$('#comment-write-desc').val('');
				// 댓글 재로딩
            	getCommentList();
			} else{
				alert('에러가 발생했습니다.');
			}
        },
		error:function(){
			alert('에러가 발생했습니다.');
		}
    });
}

// 댓글 가져오기
function getCommentList(){
	var listDiv = $('#comment-list');
	
	$.ajax({
        type:"POST",
        url:"comment.jsp",
        data:{
			"query":"getList",
			"videoId": videoId
		},
        success:function(data){
        	// 댓글 리스트 초기화
			listDiv.empty();
            $.each(data,function (_,value) {
				listDiv.append(`
					<div id="comment-box">
		  				<div id="comment-info">
		  					<span id="comment-author">${value.author}</span>
		  					<span id="comment-delete-button" onclick="deleteComment(${value.id})">[X]</span>
		  				</div>
		  				<hr>
		  				<div id="comment-desc">${value.desc}</div>
		  			</div>
				`);
			});
        }
    });
}

// 댓글 삭제
function deleteComment(id){
	const password = prompt('비밀번호를 입력하세요');
	
	$.ajax({
		type:"POST",
		url: "comment.jsp",
		data: {
			"query":"delete",
			"id": id,
			"password": password
		},
		success:function(data){
			if(data.success){
				alert('삭제에 성공했습니다');
			} else {
				alert('비밀번호가 다르거나 존재하지 않는 댓글입니다');
			}
			// 댓글 재로딩
			getCommentList();
		}
	})
}