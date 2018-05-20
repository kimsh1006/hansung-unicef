
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


 //회원가입
function join(){
	
		var member_id = $("#member_id").val();
		var password = $("#password").val();
		var password_chk = $("#password_chk").val();
		var eqYN =  $("#eqYN").val();
		var email = $("#email").val();
		var nm = $("#nm").val();
		var hp = $("#hp").val();
		if(member_id == ''){
			alert("아이디는 필수입력사항 입니다.");
			return false;
		}
		if(eqYN == 'N'){
			alert("아이디 중복체크를 해주세요.");
			return false;
		}
		if(password == ''){
			alert("비밀번호는 필수입력사항 입니다.");
			return false;
		}
	
		if(password != password_chk){
			alert("비밀번호를 정확히 입력해주세요.");
			return false;
		}
		if(email == ''){
			alert("이메일은 필수입력사항 입니다.");
			return false;
		}
		if(nm == ''){
			alert("이름은 필수입력사항 입니다.");
			return false;
		}
		if(hp == ''){
			alert("핸드폰번호는 필수입력사항 입니다.");
			return false;
		}
	
		var params = "member_id="+member_id+"&password="+password+"&email="+email+"&nm="+nm+"&hp="+hp;
		
	    $.ajax({
	        type        : "POST" 
	      , async       : false
	      , url         : "/cmd/insertMember_join.do"
	      , data        : params
	      , dataType    : "json"
	      , timeout     : 30000  
	      , cache       : false    
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	               alert( "작업 도중 오류가 발생하였습니다. " );
	                
	      }
	      , success     : function(data) {
	           
	                 if(data.member_join_chk== "1"){
	                      alert( "회원가입이 완료되었습니다.");
	                      location.href="<%=cp%>/cmd/main.do"; 	
	                }
	                
	      }
	});
}
 

//아이디 중복체크
function eqChk(){
	
		var member_id = $("#member_id").val();
		
		
		if(member_id == ''){
			alert("아이디는 필수입력사항 입니다.");
			return false;
		}
		
	
		var params = "member_id="+member_id;
		
	    $.ajax({
	        type        : "POST" 
	      , async       : false
	      , url         : "/cmd/eqChk.do"
	      , data        : params
	      , dataType    : "json"
	      , timeout     : 30000  
	      , cache       : false    
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	               alert( "작업 도중 오류가 발생하였습니다. " );
	                
	      }
	      , success     : function(data) {
	           
	                 if(data.eqChk== "1"){
	                      alert( "사용하실 수 있는 아이디입니다.");
	                      $("#eqYN").val("Y");
	                }else if(data.eqChk== "9"){
	                    alert( "이미 등록된 아이디입니다.");
	                    return false;	
	                	
	                } 
	                
	      }
	});
}
</script>
<title>회원가입</title>
</head>

<body>
	<div data-role="page">
	<div data-role="header" class="header  ui-icon-carat-l ui-btn-icon-left" onclick="history.go(-1);">	회원가입	</div>
		
    <div data-role="main" class="ui-content">
	    <div class="ui-grid-solo">
	    <input type="hidden" name="" id="eqYN" value="N">
	     	  <input type="text" value="" id="member_id" placeholder="아이디">
	     	  <button type="button" data-theme="b" style="background-color: #2ad !important;" onclick="eqChk();">중복확인</button>
	     	  <input type="text" value="" id="nm" placeholder="이름">
	     	 <input  type="password" value="" id="password" placeholder="비밀번호">
	     	  <input  type="password" value="" id="password_chk" placeholder="비밀번호 확인">
	     	    <input type="text" value="" id="email" placeholder="이메일">     	 
	     	    <input type="text" value="" id="hp" placeholder="핸드폰번호">
	    </div><!-- /grid-a -->
	    <fieldset class="ui-grid-a">
  		<div class="ui-block-a" style="width: 100%; "><button type="button" data-theme="b" style="background-color: #2ad !important;" onclick="join();">회원가입</button></div>
		</fieldset>
		<div data-role="footer" data-position="fixed" >
          	 <h1 style="height: 60px;">자전거 앱.</h1>
       	</div>
		
	  </div>
	
	</div>
</body>


</html>