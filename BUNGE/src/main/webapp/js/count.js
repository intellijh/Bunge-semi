function infolikecnt(){
	  $.ajax ({
	  url : "InfoLikeCnt.com",
	  type : 'post',
	  dataType : 'json',
	  success : function(rdata) {
		  $(rdata.popularpostlist).each(function(index, item) {
			  $('#postlikecnt'+index).text(item.postlikecnt)
			  $('#postcommcnt'+index).text(item.postcommcnt)
		  })
	  },
  })
    } //infolikecnt() end