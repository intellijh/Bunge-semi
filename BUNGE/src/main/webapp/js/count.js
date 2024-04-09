$(function() {
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
				console.log('rdata.cnt2 :'+ rdata.cnt); 
				likecount = rdata.check;
				console.log('rdata like :'+ likecount);
				$('#likecnt').html(rdata.cnt);
				}
			}, 
			error : function(){
				console.log('infolikecnt 실패');
			}		
		}); //ajax end
});