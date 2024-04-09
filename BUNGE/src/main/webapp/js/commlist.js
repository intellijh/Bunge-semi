$(function(){
	
	$.ajax({
		url : "mycommlistprocess.com",
		type : "post",
		dataType : "json",
		success : function(rdata) {
			//console.log(rdata)
			const a = rdata.commlist
			for (let i=0; i<a.length; i++) {
				let output = "<span class='commcount'>" + (i + 1) + "</span>"
				       + "<a href='InfoDetail.com?inf_num="+a[i].inf_num+"'><span>" + a[i].comm_content + "</span></a>"
					   + "<span class='commreg'>" + a[i].comm_reg + "</span>"
					   + "<br><br>"
				$('.contentbox').append(output)
			}
				
		}
	})//ajax end
})//ready end