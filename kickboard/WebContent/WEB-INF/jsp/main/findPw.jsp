<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="/css/public.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">
$(document).ready(function(){
	//window.myAndorid.locations();
	
	
});
//로그인
 function findPw(){
	 var member_id = $("#member_id").val();
	 var email = $("#email").val();
		
		if(member_id == ''){
			alert("아이디는 필수입력사항 입니다.");
			return false;
		}
		
		if(email == ''){
			alert("이메일은 필수입력사항 입니다.");
			return false;
		}
		
	 	

		var params = "member_id="+member_id+"&email="+email;
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "<%=cp%>/cmd/findPwEmail.do"
	      , data        : params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	  	    alert("작업 도중 오류가 발생하였습니다.");
			
	      }
	      , success     : function(data) {
			
	    	  alert("이메일을 전송하였습니다.");
	    	  location.href="<%=cp%>/cmd/main.do";  
	      }
 	});
 }


</script>
<title>자전거</title>
</head>
	<body>
		<div data-role="page">
	<div data-role="header" class="header  ui-icon-carat-l ui-btn-icon-left" onclick="history.go(-1);">	비밀번호 찾기	</div>
		  <div data-role="main" class="ui-content">
		    <div class="ui-grid-solo">
		    	  <input type="text" value="" id="member_id" placeholder="아이디">
		     	  <input type="text" value="" id="email" placeholder="이메일">
		     	  
		    </div><!-- /grid-a -->
		    <fieldset class="ui-grid-a">
		  		<div class="ui-block-a" style="width: 100%; "><button type="button" data-theme="b" style="background-color: #2ad !important;" onclick="findPw();">찾기</button></div>
			</fieldset>
			<div data-role="footer" data-position="fixed" >
           	 <h1 style="height: 60px;">자전거 앱.</h1>
        	</div>
			
		  </div>
		
		</div>
	</body>
</html>