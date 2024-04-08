$(function () {
	
	let searchword = prompt('책 제목을 입력하세요')
	if (searchword == null) {
		history.back();
	}
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
			if ($('#state').val() == 'modify') {
			let output = "<form action='InfoModify.com' method='post'>"
					   + "  <button type='submit'>선택하기</button><br>"
				       + "  <img width='150px' height='200px' class='bookcover' src='"+subject.cover+"'><br>"
				       + "    <input type='hidden' name='bookcover' value='"+subject.cover+"'> "
				       + "  <div>책 제목 : '"+subject.title+"'</div>"
				       + "    <input type='hidden' name='booktitle' value='"+subject.title+"'> "
				       + "  <div>지은이 : '"+subject.author+"'</div>"
				       + "    <input type='hidden' name='bookauthor' value='"+subject.author+"'> "
				       + "  <div>카테고리분류 : '"+subject.categoryName+"'</div>"
				       + "    <input type='hidden' name='bookcategoryname' value='"+subject.categoryName+"'> "
				       + "  <div>출간일 : '"+subject.pubDate+"'</div><br><br>"
				       + "    <input type='hidden' name='bookpubdate' value='"+subject.pubDate+"'> "
				       + "  <input type='hidden' name='inf_num' value='" + $('#inf_num').val() + "'>"
					   + "</form>"
			$('body').append(output)
			i++
			} else if ($('#state').val() == 'write') {
	let output = "<form action='InfoWrite.com' method='post'>"
			   + "  <button type='submit'>선택하기</button><br>"
		       + "  <img width='150px' height='200px' class='bookcover' src='"+subject.cover+"'><br>"
		       + "    <input type='hidden' name='bookcover' value='"+subject.cover+"'> "
		       + "  <div>책 제목 : '"+subject.title+"'</div>"
		       + "    <input type='hidden' name='booktitle' value='"+subject.title+"'> "
		       + "  <div>지은이 : '"+subject.author+"'</div>"
		       + "    <input type='hidden' name='bookauthor' value='"+subject.author+"'> "
		       + "  <div>카테고리분류 : '"+subject.categoryName+"'</div>"
		       + "    <input type='hidden' name='bookcategoryname' value='"+subject.categoryName+"'> "
		       + "  <div>출간일 : '"+subject.pubDate+"'</div><br><br>"
		       + "    <input type='hidden' name='bookpubdate' value='"+subject.pubDate+"'> "
			   + "</form>"
			$('body').append(output)
			i++
			}
		}) // each end
		
		} //success end
	}) //ajax end
}) //ready end