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
			  $('#popularcount' + index).text('태그된 횟수 : ' + item.count)
		  })
	  }
  })
}); //ready end