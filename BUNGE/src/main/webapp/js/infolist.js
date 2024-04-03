function go(page) {
	const limit = $('#viewcount').val()
	const data = {limit:limit, state:"ajax", page:page}
	ajax(data);
}

function setPaging(href, digit) {
	let active = ""
	let gray = ""
	console.log('href : ' + href);
	if (href == "") {
		if(isNaN(digit)) { //이전 or 다음 인 경우
			gray = 'gray'  //11,20번 라인 처럼 href 속성이 없고 <a>요소의 textnode가 숫자가 아닌 경우
		} else {
			active = 'active' ////12,19번 라인 처럼 href 속성이 없고 <a>요소의 textnode가 숫자인 경우
		}
	}
	let output = "<li class='page-item " + active + "'>" 
	let anchor = "<a class='page-link " + gray + "'" + href + ">" + digit + "</a></li>"
	output += anchor
	return output
}


function ajax(sdata) {
	console.log('sdata : ' + sdata)
	
	$.ajax({
		url : "InfoList.com",
		type : "POST",
		data : sdata,
		dataType : "json",
		cache : false,
		success : function(data) {
			$("#viewcount").val(data.limit)
			$("thead").find("span").text("글 개수 : " + data.listcount)
			
			if (data.listcount > 0) {
				$("tbody").remove()
				let num = data.listcount - (data.page - 1) * data.limit;
				console.log('num : ' + num)
				let output = "<tbody>"
				$(data.boardlist).each(
					function(index, item) {
						output += '<tr><td>' + (num--) + '</td>'
						const blank_count = item.inf_lev * 2;
						let blank = "&nbsp;"
						for (let i=0; i<blank_count; i++) {
							blank += "&nbsp;"
						}
						
						let img="";
						if (item.inf_lev > 0) {
							img="<img src='image/line.gif'>"
						}
						
						let subject=item.inf_subject
						if(subject.length >= 20) {
							subject=subject.substr(0,20) + "..."
						}
						
				//		let book=item.inf_book
				//		if(book.length >= 20) {
				//			book=book.substr(0,20) + "..."
				//		}
						
						let content=item.inf_content
						if(content.length >= 20) {
							content=content.substr(0,20) + "..."
						}
						output += "<td><div>" + blank + img
						output += "  <a href='InfoDetail.com?num=" + item.inf_num + "'>"
						output += subject.replace(/</g, '&lt;').replace(/>/g, '&gt;')
						       +    '</a>[' + item.cnt + ']</div></td>'
				//	    output += "<td><div>" + book.replace(/</g, '&lt;').replace(/>/g, '&gt;') + "</div></td>"
						output += '<td><div>' + content.replace(/</g, '&lt;').replace(/>/g, '&gt;') + '</div></td>'
						output += '<td><div>' + item.m_id + '</div></td>'
						output += '<td><div>' + item.inf_reg + '</div></td>'
						output += '<td><div>' + item.inf_readcount + '</div></td>'
						if (item.inf_cover != undefined) {
							//console.log('item.inf_cover :'+ index + " : " + item.inf_cover)
						output += "<td><div><img class='cover' src='" + item.inf_cover + "'></div></td>'"
						} else {
						output += "<td><div></div></td>"
						}
						output += '<td><div>' + '좋아요자리(ajax활용?)' + '</div></td>'
						output += '<td><div>' + item.infolikecnt + '</div></td>'
					}) //function(index, item)
				output += "</tbody>"
				$('table').append(output)
				
				
				$('.pagination').empty();
				output = "";
				
				let digit = '이전&nbsp;'
				let href = "";
				if (data.page > 1) {
					href = 'href=javascript:go(' + (data.page - 1) + ')'
				}
				output += setPaging(href, digit);
				
				for (let i=data.startpage; i<=data.endpage; i++) {
					digit = i
					href = ""
					if (i != data.page) {
						href = 'href=javascript:go(' + i + ')'
					}
					output += setPaging(href, digit);
				} //for end
				
				digit = '&nbsp;다음&nbsp;'
				href = ""
				if (data.page < data.maxpage) {
					href = 'href=javascript:go(' + (data.page + 1) + ')'
				}
				output += setPaging(href, digit)
				
				$('.pagination').append(output)
				
			} //if(data.listcount) > 0 end

		}, //success end
		error : function() {
			console.log('에러')
		}
	}) //ajax end
} //function ajax end


$(function() {
	go(1)
	
	
	$("button").click(function(){
		location.href="InfoWrite.com";
	})
	
	$("#viewcount").change(function() {
		go(1);
	})
}) //ready end