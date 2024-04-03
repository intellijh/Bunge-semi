$(function () {
	
	let searchword = prompt('책 제목을 입력하세요')
	console.log('searchword : ' + searchword)
	
	$.ajax ({
		url : "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx",
		data : {"ttbkey" : "ttbyyy24941308001",
			    "Query" : searchword,
			    "QueryType" : "Title",
			    "SearchTarget" : "Book",
			    "start" : "1",
			    "MaxResults" : "20",
			    "Sort" : "Title",
			    "Cover" : "Big",
			    "output" : "JS",
			    "Version" : "20131101"},
		dataType : "json",
		cache : false,
		success : function(rdata) {
		
		let i=0;
		$(rdata.item).each(function() {
			let subject = rdata.item.at(i)
			let output = "<form action='InfoWrite.com' method='post'>"
					   + "  <button type='submit'>선택하기</button>"
				       + "  <img class='bookcover' src='"+subject.cover+"'>"
				       + "    <input type='hidden' name='bookcover' value='"+subject.cover+"' "
				       + "  <div>책 제목 : '"+subject.title+"'</div>"
				       + "    <input type='hidden' name='booktitle' value='"+subject.title+"' "
				       + "  <div>지은이 : '"+subject.author+"'</div>"
				       + "  <div>카테고리분류 : '"+subject.categoryName+"'</div>"
				       + "  <div>출간일 : '"+subject.pubDate+"'</div><br><br>"
					   + "</form>"
			$('body').append(output)
			i++
			})
		} //success end
	}) //ajax end
}) //ready end