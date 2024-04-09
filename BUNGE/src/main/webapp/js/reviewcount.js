$(function() {
/*
	$.ajax({
			url : "mypageLikecnt.com",
			type : 'post',
			data : { 
				m_id :$('#loginid').val(),
				inf_num : $("#inf_num").val()
			},
			dataType : 'json',
			success : function(rdata) {
				if (rdata.cnt != -1) {
				console.log('rdata.cnt :'+ rdata.boardlist.cnt); 
	
				console.log('rdata like :'+ likecount);
				$('#likecnt').html(rdata.cnt);
				
			 let output = "";
            $(rdata.boardlist).each(function(index, item) {
                output += "<div class='user_board'>";
                output += "<div class='board-section'>";
                output += "<div class='board'>";
                output += "<div class='board_box'>";
                output += "<div class='board_subject'><a href='InfoDetail.com?inf_num=" + item.inf_num + "'>";
                output += "<h3 class='board_inf_subject_title'>제목 : " + item.board.inf_subject + "</h3></a></div>";
                output += "<div class='board_content'><p class='board_inf_contet_text'>내용 :" + item.inf_content + "</p></div>";
                output += "</div>";
                output += "<div class='board_img'><div class='img'><img src='" + item.inf_cover + "'></div></div>";
                output += "</div>";
                output += "<div class='like_comm_box'>";
                output += "<div class='inf_like_num'>";
                output += "<img src='./image/like_on.png'><span class='likecnt'>" + item.infolikecnt + "</span>";
                output += "</div>";
                output += "<div class='inf_comm_num'>";
                output += "<img width='50px' height='50px' alt='talk' src='./image/talk.jpg'><span class='commcnt'>"+item.cnt+"</span>";
                output += "</div>";
                output += "</div>";
                output += "</div>";
                output += "</div>";
            });
            $('body').append(output);
            }
        },
        error: function() {
            console.log('infolikecnt 실패');
        }
    });
*/  
}); //readey end