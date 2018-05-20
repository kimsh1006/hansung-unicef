<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Map" %>
<%@page import="cmd.vo.CmdVO"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	Map sessionData = null;
	  
    boolean isSession = true;
    CmdVO vo = null;
    String member_id="";
    String member_no ="";
  	String 	money = "";
  	String bike_no = "";
  	String nm = "";
  	String hp = "";
  	String password = "";
  	 String email="";
    if (session.getAttribute("sessionData") != null) {
    	
    	 sessionData = (Map)session.getAttribute("sessionData");
		 member_id = sessionData.get("member_id").toString();	
		 member_no = sessionData.get("member_no").toString();	
		 money = sessionData.get("money").toString();	
		 bike_no = sessionData.get("bike_no").toString();
		 nm = sessionData.get("nm").toString();
		 hp = sessionData.get("hp").toString();
		 password = sessionData.get("password").toString();
		 email = sessionData.get("email").toString();	
       
    } else {
        isSession = false;
        session.removeAttribute("sessionData");
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

</head>
<script type="text/javascript">
var money = "<%=money%> ";
var nm = "<%=nm%>";
var hp = "<%=hp%>";
var password = "<%=password%>";
var member_id = "<%=member_id%>";
var email = "<%=email%>";
var member_no = "<%=member_no%>";
$(document).ready(function(){
	
	$("#member_id").val(member_id);
	$("#nm").val(nm);
	$("#email").val(email);
	$("#hp").val(hp);
	
	
	$("#money").html(numberWithCommas(money));

	
	
	
});

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//정보수정
function updateMember(){
	
	
	var nm_n = $('#nm').val();
	var hp_n = $('#hp').val();
	var password_n = $('#password').val();
	var password_origin = $('#password-origin').val();
	var password_chk = $('#password_chk').val();
	var email_n = $('#email').val();


	
	
	if(email_n == ''){
		alert("이메일은 필수입력사항 입니다.");
		return false;
	}
	if(nm_n == ''){
		alert("이름은 필수입력사항 입니다.");
		return false;
	}
	if(hp_n == ''){
		alert("핸드폰번호는 필수입력사항 입니다.");
		return false;
	}
	
	var params = "member_no="+member_no+"&nm="+nm_n+"&hp="+hp_n+"&email="+email_n;
	
	
	if(password_n != ''){
		
		if(password != password_origin){
			alert("기존비밀번호가 틀렸습니다.");
			return false;
		}
		

		if(password_n != password_chk){
			alert("비밀번호를 정확히 입력해주세요.");
			return false;
		}
		
		params += "&password="+password_n
		
	}
	
	
	
	
    $.ajax({
        type        : "POST" 
      , async       : false
      , url         : "/cmd/update_member.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
               alert( "작업 도중 오류가 발생하였습니다. " );
                
      }
      , success     : function(data) {
    
      		alert("정보수정 완료.");
      		password = password_n;
                
      }
	});
	
}



function pwChg(){
	$('#pwChg').css("display","");
}





</script>
 
<body>

<div data-role="page">


	<jsp:include page="../header.jsp"></jsp:include>
	
  <div data-role="main" class="ui-content">

  <div id="map-canvas" style="width: 100%; height: 250px;"></div>
  <div class="ui-grid-solo">
   <div style="height: 70px;">
   		<h2 style=" text-align: center;" class="title">정보</h2><div style="text-align: right;"><a href="<%=cp%>/cmd/logout.do" rel="external" class="logout">로그아웃</a></div>
 	</div>
 	<label for="member_id">아이디</label>
   	  <input type="text" value="" id="member_id" placeholder="아이디" readonly="readonly" disabled="disabled">
   	  <label for="nm">이름</label>
   	  <input type="text" value="" id="nm" placeholder="이름">
   	  <label for="email">이메일</label>
   	   <input type="text" value="" id="email" placeholder="이메일">     	
   	   <label for="hp">핸드폰번호</label> 
   	    <input type="text" value="" id="hp" placeholder="핸드폰번호">
   	     <button type="button" data-theme="b" style="background-color: #2ad !important;" onclick="pwChg();">비밀번호변경</button>
   	  <div id="pwChg" style="display: none;">
   	  <label for="password-origin">기존 비밀번호</label>
   	 <input  type="password" value="" id="password-origin" placeholder="기존 비밀번호">
   	 <label for="member_id">비밀번호</label>
   	  <input  type="password" value="" id="password" placeholder="비밀번호">
   	  <label for="password_chk">비밀번호 확인</label>
   	  <input  type="password" value="" id="password_chk" placeholder="비밀번호 확인">
   	 
   	  </div>
   	   <button type="button" data-theme="b" style="background-color: #2ad !important;" onclick="updateMember();">수정</button>
	    </div><!-- /grid-a -->
   
  
   	<label for="money">잔액</label>
    <div id="money"></div>
  
 
   
  </div>
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>