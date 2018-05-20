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
   
    if (session.getAttribute("sessionData") != null) {
    	
    	 sessionData = (Map)session.getAttribute("sessionData");
		 member_id = sessionData.get("member_id").toString();	
		 member_no = sessionData.get("member_no").toString();	
		 money = sessionData.get("money").toString();	
		 bike_no = sessionData.get("bike_no").toString();
       
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
<link rel="stylesheet" href="/css/public.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<script type="text/javascript">

$(document).ready(function(){

	var money = "<%=money%>";
	var bike_no = "<%=bike_no%>";
	
	$("#money").html(numberWithCommas(money));

	if(bike_no === '0'){
	
		$("#bike").html("미사용");
		$("#bike_btn").css("display",'none');
	}else{
		
		$("#bike").html("사용중");
		$("#bike_btn").css("display",'');
		var params = "bike_no="+bike_no;
		 $.ajax({
		        type        : "POST" 
		      , async       : false
		      , url         : "/cmd/get_bikeInfo.do"
		      , data        : params
		      , dataType    : "json"
		      , timeout     : 30000  
		      , cache       : false    
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
		               alert( "작업 도중 오류가 발생하였습니다. " );
		                
		      }
		      , success     : function(data) {
		    
		    	  /* $("#bikePW").html("자전거 패스워드: "+data.bikePW); */
		      	
		                
		      }
			});
		 
		//7초에 한번씩 실행..
		 playAlert = setInterval(function() {
			   selectOutChk();
			}, 7000);
		
	}
	
	
	
});

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


//금액 충전
function insert_money(){
	var member_no = "<%=member_no%>";
	var money = $('#add_money').val();
	var acountNm = $('#acountNm').val();
	
	
	var params = "member_no="+member_no+"&money="+money+"&nm="+acountNm;
	$.ajax({
	    type        : "POST" 
	  , async       : false
	  , url         : "/cmd/insert_money.do"
	  , data        : params
	  , dataType    : "json"
	  , timeout     : 30000  
	  , cache       : false    
	  , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	  , error       : function(request, status, error) {
	           alert( "작업 도중 오류가 발생하였습니다. " );
	            
	  }
	  , success     : function(data) {
	
	  		location.href = "/cmd/info.do";	
	  	
	            
	  }
	});

}

//자전거반납
function use_bike(){
	
	var bike_no = "<%=bike_no%>";
	var member_no = '<%=member_no%>';
	var latitude = $("#latitude").val();
	var longitude = $("#longitude").val();
	var params = "bike_no="+bike_no+"&member_no="+member_no+"&use_yn=N"+"&price=0"+"&latitude="+latitude+"&longitude="+longitude;
 
    $.ajax({
        type        : "POST" 
      , async       : false
      , url         : "/cmd/use_bike.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
               alert( "작업 도중 오류가 발생하였습니다. " );
                
      }
      , success     : function(data) {
    		if(data.result == '-1'){
    			alert("금액이 부족합니다!");
    			return false;
    		}else{
    			location.href = "/cmd/money.do";	
    		}
      		
      	
                
      }
	});
	
}



var bgm = new Audio(' '); //오디오 엘리먼트 생성
var bgm_url = ''; //mp3파일을 스트리밍 해올 주소
function bgmStart(){

		bgm_url = '/mp3/alram.mp3'; //mp3파일을 스트리밍 해올 주소
		bgm = new Audio(bgm_url); //위에서 생성한 bgm 변수에 url값 대입
		bgm.volume = (1.0); // 재생할때 볼륨 설정
		bgm.play(); //재생
	
	
}

function bgmStop(){
	bgm.pause();
	bgm_url = "";
}

//5km 밖 확인
function selectOutChk(){
	
	var latitude = $("#latitude").val();
	var longitude = $("#longitude").val();
	
	var params = "latitude="+latitude+"&longitude="+longitude;
	
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "<%=cp%>/main/selectOutChk.do"
	      , data        : params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	  	    alert("작업 도중 오류가 발생하였습니다.");
			
	      }
	      , success     : function(data) {
				if(data.check === "OUT"){
					bgmStart();
					
					
				}else{
					
				}	
	    	
	      }
	});
}

</script>
 
<body>

<div data-role="page">


	<jsp:include page="../header.jsp"></jsp:include>
  <div data-role="main" class="ui-content">
 
   <div style="height: 70px;">
   		<h2 style=" text-align: center;" class="title">충전</h2><div style="text-align: right;"><a href="<%=cp%>/cmd/logout.do" rel="external" class="logout">로그아웃</a></div>
 	</div>
   	<label for="money">잔액</label>
    <div id="money"></div>
    <label for="acountNm">입금자명</label>
    <input type="text" name="acountNm" id="acountNm">    
    <label for="add_money">충전금액</label>
    <input type="text" name="add_money" id="add_money">    
    <div class="ui-block-a"  style="width: 100%" >
     <button type="button" data-theme="b" style="background-color: #2ad !important;" onclick="insert_money();">충전</button>
    
    </div>
    
    <label for="bike">자전거유무</label>
    <div id="bike"></div>
   <!--  <h1 id="bikePW"></h1>    -->
   
    <div class="ui-block-a"  style="width: 100%" id="bike_btn" >
  
     <button type="button" data-theme="b" style="background-color: #2ad !important;" onclick="use_bike();">반납</button>
     <button type="button" data-theme="b" style="background-color: #2ad !important;" >ON</button>
     <button type="button" data-theme="b" style="background-color: #2ad !important;" >OFF</button>
  
    </div>

     
  </div>
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>