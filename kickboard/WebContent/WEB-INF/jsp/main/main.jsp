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

	
	
});


//로그인
 function loginMember(){
	
	 	var member_id = $("#member_id").val();
		var password = $("#password").val();
		if(member_id == ""){
			return alert("아이디를 입력해주세요.");
		}
		if(password == ""){
			return alert("비밀번호를 입력해주세요.");
		}
		var params = "member_id="+member_id+"&password="+password;
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "<%=cp%>/cmd/doMember_login.do"
	      , data        : params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	  	    alert("작업 도중 오류가 발생하였습니다.");
			
	      }
	      , success     : function(data) {
				
	    	   if(data.resultCode == 0) {
                 alert("ID 또는 비밀번호가 틀렸습니다.");
                 return;
             }else {
            	
            	 if(data.member_id=="admin"){
            		<%--  var latitude = $('#latitude').val();
            		 var longitude = $('#longitude').val();
            		 location.href="<%=cp%>/cmd/car_user.do?latitude="+latitude+"&longitude="+longitude;	  --%>
            		 location.href="<%=cp%>/cmd/admin.do";
            	 }else{
       
            		 location.href="<%=cp%>/cmd/info.do";
            	 }
            	
             	
             }   
	      }
 	});
 }




</script>
<title>자전거</title>
</head>
	<body>
		<div data-role="page">
			<div data-role="header" class="header" onclick="bgmStop();">
		   		로그인
		   
		  	</div>
		  	
		  	<div>
		  		<!-- <img src="/css/logo.png" style="width: 100%;  position: relative;  top: -1px;"> -->
		  	</div>
		  <div data-role="main" class="ui-content">
		    <div class="ui-grid-solo">
		     	  <input type="text" value="" id="member_id" placeholder="아이디">
		     	  
		     	 <input  type="password" value="" id="password" placeholder="비밀번호">
		    </div><!-- /grid-a -->
		    <fieldset class="ui-grid-a">
		  		<div class="ui-block-a" style="width: 100%; "><button type="button" data-theme="b" style="background-color: #2ad !important;" onclick="loginMember();">로그인</button></div>
		  		<div class="ui-block-a" style="width: 100%; "><button type="button" data-theme="b" style="background-color: #2ad !important;" onclick="location.href='<%=cp%>/cmd/join.do'" >회원가입</button></div>
		  
		  		<div class="ui-block-a" style="width: 50%; float: left; " onclick="location.href='<%=cp%>/cmd/findId.do'" >아이디 찾기</div><div class="ui-block-b" style="width: 50%; float: left; text-align: right;" onclick="location.href='<%=cp%>/cmd/findPw.do'" >비밀번호찾기</div>
			</fieldset>
			<div data-role="footer" data-position="fixed" >
           	 <h1 style="height: 60px;">자전거 앱.</h1>
        	</div>
			
		  </div>
	
		</div>
	</body>
</html>