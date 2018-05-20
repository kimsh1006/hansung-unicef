<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">

<script src="../js/bootstrap.js"></script>
<link rel="stylesheet" href="../css/mobile.css">
<link rel="stylesheet" href="../css/bootstrap.css">
<!-- 세션 없으면 메인페이지로 강제 이동 -->

<script type="text/javascript">
$(document).ready(function(){	
	
	
	
	
	dangerArea_check();
});



function dangerArea_check(){
	var latitude = $("#latitude").val();
	var longitude = $("#longitude").val();
	var member_no = $("#member_no").val();
	var params = "latitude="+latitude+"&longitude="+longitude+"&member_no="+member_no;
	
	$.ajax({
        type        : "POST"  
      , async       : false 
      , url         : "<%=cp%>/main/dangerArea_check.do"
      , data        : params
      , dataType    : "json" 
      , timeout     : 30000   
      , cache       : false     
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
  	    alert("작업 도중 오류가 발생하였습니다.");
		
      }
      , success     : function(data) {
    	  var html = "";
    	  var check = "";
    	  $.each(data.dangerAreaList, function (index, dangerAreaList) {
//     		  html += dangerAreaList.distance;
    		  if(dangerAreaList.distance < 5){
    			  check = "위험지역";
    		  }
    	  });
    	  if(check == "위험지역"){
    		  html += "<img src='../img/notsafe.png' style='margin-top: 3em;'>";
    		  html += "<p style='margin-top: 1em;'>위험지역이 5km안에 존재 합니다.</p>";
    	  } else {
    		  html += "<img src='../img/safe.png' style='margin-top: 3em;'>";
    		  html += "<p style='margin-top: 1em;'>위험지역이 5km안에 존재하지 않습니다.</p>";
    	  }
    	  $("#test").html(html).trigger("create");
      }
	});	
}
</script>

</head>
<body>
	<div data-role="page">
	
		<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no" name="member_no">
		
		
		<jsp:include page="../header.jsp"></jsp:include>
		
		<div data-role="content">
			
			<div id="test" align="center">
				<img src="../img/safe.png" id="" style="margin-top: 3em;">
				<p style="margin-top: 1em;">위험지역이 아닙니다.</p>
			</div>
		</div>		
		
		<jsp:include page="../footer.jsp"></jsp:include>
				
	</div>
</body>
</html>