$(document).ready(function(){
  $("#myCarousel").carousel({interval: 3000 , pause: "hover"});
        
  // Enable Carousel Indicators
  $(".item1").click(function(){
    $("#myCarousel").carousel(0);
  });
  $(".item2").click(function(){
    $("#myCarousel").carousel(1);
  });
  $(".item3").click(function(){
    $("#myCarousel").carousel(2);
  });
    
  // Enable Carousel Controls
  $(".carousel-control-prev").click(function(){
    $("#myCarousel").carousel("prev");
  });
  $(".carousel-control-next").click(function(){
    $("#myCarousel").carousel("next");
  });
  
  //인기 있는 책
  $.ajax ({
	  url : "MainPopularBook.com",
	  type : 'post',
	  dataType : 'json',
	  success : function(rdata) {
		  $(rdata.popularbooklist).each(function (index, item) {
			  $('#popularbookcover' + index).attr('src', item.inf_cover)
			  $('#popularcount' + index).html("<span class='badge badge-warning'>#책마니관심도" + item.count + "</span>")
		  })
	  }
  })
  
  //인기 댓글
  $.ajax ({
	  url : "MainPopularComm.com",
	  type : 'post',
	  dataType : 'json',
	  success : function(rdata) {
		  $(rdata.popularcommlist).each(function(index, item) {
			  console.log(this.content.length)
			  $('#commcount' + index).text(item.count)
			  $('#comm_m_profile' + index).attr('src', './memberupload/' + item.m_profile)
			  if (this.content.length > 16) {
				  $('#commcontent' + index).html("<a href='InfoDetail.com?inf_num="+item.inf_num+"'>"+this.content.substr(0,15) + '...' + "</a>")
			  } else {
				  $('#commcontent' + index).html("<a href='InfoDetail.com?inf_num="+item.inf_num+"'>"+this.content + "</a>")
			  }
			  $('#comm_m_id' + index).text(this.m_id)
			  $('#commreg' + index).text(this.reg)
		  })
	  }
  })
  
  //인기 게시글
  $.ajax ({
	  url : "MainPopularPost.com",
	  type : 'post',
	  dataType : 'json',
	  success : function(rdata) {
		  $(rdata.popularpostlist).each(function(index, item) {
			  $('#m_profile'+index).attr('src', './memberupload/'+item.m_profile)
			  $('#m_id'+index).text(this.m_id)
			  $('#postsubject'+index).html("<a href='InfoDetail.com?inf_num="+item.inf_num+"'>"+item.inf_subject+"</a>")
			  $('#postreg'+index).text(item.inf_reg)
			  $('#postbook'+index).text(item.inf_book)
			  
			  //console.log(item.inf_content.length)
			  if (item.inf_content.length > 57) {
				  $('#postcontent'+index).text(item.inf_content.substr(0,56) + '...')
			  } else {
				  $('#postcontent'+index).text(item.inf_content)
			  }
			  $('#postlikecnt'+index).text(item.postlikecnt)
			  $('#postcommcnt'+index).text(item.postcommcnt)
			  $('#postreg'+index).text(item.inf_reg)
			  $('#postimg'+index).attr('src', item.inf_cover)
		  })
	  },
  })
  
  //진행 중인 거래 영역
  $.ajax ({
	  url : "MainTrade.com",
	  type : "post",
	  dataType : "json",
	  success : function(rdata) {
		  $(rdata.tradelist).each(function(index, item) {
			  $('#tradeprofile' + index).attr('src', './memberupload/' + item.m_profile)
			  $('#sellerid' + index).text(this.sellerid)
			  $('#createdate' + index).text(item.createdate)
			  $('#title' + index).html("<a href='view.net?tradeID="+item.tradeid+"'>" + item.title + "</a>")
			  if (item.description.length > 128) {
				  $('#description' + index).text(item.description.substr(0,126) + '...')
			  } else {
				  $('#description' + index).text(item.description)
			  }
			  $('#price'+index).html("<span class='badge badge-pill badge-warning'>"+item.price+"원</span>")
			  $('#category'+index).html("<span class='badge badge-pill badge-warning'>"+item.category+"</span>")
			  $('#quality'+index).html("<span class='badge badge-pill badge-warning'>"+item.quality+"급</span>")
			  $('#imageid' + index).attr('src','./image/' + item.imageid)
		  })
	  }
  })
  
  //베스트셀러
  $.ajax ({
	  url : "http://www.aladin.co.kr/ttb/api/ItemList.aspx",
	  data : {"ttbkey" : "ttbyyy24941308001",
	  		  "QueryType" : "Bestseller",
	  		  "SearchTarget" : "Book",
	  		  "MaxResults" : "5",
	  		  "Cover" : "Big",
	  		  "Output" : "JS",
	  		  "Version" : "20131101"},
	  dataType : "json",
	  cache : false,
	  success : function(rdata) {
		  
		  let i=0;
		  $(rdata.item).each(function() {
			  let subject=rdata.item.at(i)
			  console.log(subject)
			  $('#slideimg' + i).attr("src", subject.cover)
			  $('#slidelink' + i).attr("href", subject.link)
			  i++
		  })
	  }
  })
  
  //신간도서
  $.ajax ({
	  url : "http://www.aladin.co.kr/ttb/api/ItemList.aspx",
	  data : {"ttbkey" : "ttbyyy24941308001",
	  		  "QueryType" : "ItemNewSpecial",
	  		  "SearchTarget" : "Book",
	  		  "MaxResults" : "5",
	  		  "Cover" : "Big",
	  		  "Output" : "JS",
	  		  "Version" : "20131101"},
	  dataType : "json",
	  cache : false,
	  success : function(rdata) {
		  
		  let i=0;
		  $(rdata.item).each(function() {
			  let subject=rdata.item.at(i)
			  console.log(subject)
			  $('#newbestimg' + i).attr("src", subject.cover)
			  $('#newbest' + i).attr("href", subject.link)
			  i++
		  })
	  }
  })  
  
  //더보기 버튼 클릭
  $('#morelist').click(function() {
	  location.href = "InfoList.com"
  })
  
    //'진행 중인 거래' 더보기 버튼 클릭
  $('#moretradelist').click(function() {
	  location.href = "trade.net"
  })
}); //ready end