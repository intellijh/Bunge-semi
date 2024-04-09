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
			  $('#popularcount' + index).text('#책마니관심도' + item.count)
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
			  if (item.inf_content.length > 60) {
				  $('#postcontent'+index).text(item.inf_content.substr(0,59) + '...')
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
  
  $('#morelist').click(function() {
	  location.href = "InfoList.com"
  })
}); //ready end