$(document).ready(function(){
  
  //header 상단 프로필
  $.ajax ({
	  url : "HeaderProfile.com",
	  data : {
		  m_id : $('#loginid').val() 
	  },
	  type : 'post',
	  success : function(rdata) {
		    console.log(rdata)
		 const m_profile = "./memberupload/"+rdata 
		 $('#headerprofile').attr('src', m_profile)
	  }
  })
}); //ready end