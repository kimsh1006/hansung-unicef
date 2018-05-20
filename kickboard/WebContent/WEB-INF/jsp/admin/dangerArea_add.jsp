<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>

<title>Location</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD60rwjxUjBDRiDUUfwQvNhjiP8d8hXVD8"></script>
<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/web/login.do";
	</script>
</c:if>
<script type="text/javascript">
$(document).ready(function(){
	
	var checkPage = $("#return_value").val();
	if(checkPage == "addOk"){
		alert("등록이 완료 되었습니다.");
		$("#return_value").val("");
	}
	$("#singUp").click(function(){
		var d_name = $("#d_name").val();
		var d_address = $("#d_address").val();
		var d_content = $("#d_content").val();
		var latitude = $("#latitude").val();
		var longitude = $("#longitude").val();
		
		if(d_name == null || d_name == ""){
			alert("위험지역 이름을 입력해 주세요.")
		} else if (d_address == null || d_address == ""){
			alert("위험지역 주소(위치)를 정확하게 입력해 주세요.")
		} else if (d_content == null || d_content == ""){
			alert("위험지역 상세 정보를 입력해 주세요.")
		} else if (latitude == null || latitude == ""){
			alert("정확한 주소입력 후 위도 경도값을 확인하세요.")
		} else {
			confirm();
		}
		
	});
	
});
function logout(){
	location.href="<%=cp%>/web/logout.do";
}
function company_add(){
	location.href="<%=cp%>/web/company_add.do";
}
function company_modify_delete(){
	location.href="<%=cp%>/web/company_modify_delete.do";
}
function dangerArea_add(){
	location.href="<%=cp%>/web/dangerArea_add.do";
}
function dangerArea_delete(){
	location.href="<%=cp%>/web/dangerArea_delete.do";
}

function change_address(){
	var c_address = $("#d_address").val();
	getLocation();
}

function confirm(){
    document.addDangerArea.action = '<%=cp%>/web/addDangerArea.do';
    document.addDangerArea.submit();
 }

//위도 경도 구하기
var geocoder = new google.maps.Geocoder(); 
function getLocation() {
		
	var address = $("#d_address").val();

	geocoder.geocode({'address': address}, function(results, status) {
		
		if( status == google.maps.GeocoderStatus.OK ) {  
			
			if (results.length == 1) {
				
				var location = "" + results[0].geometry.location;
				
				location = location.substring(1, location.length-1);
				
				var array_data = location.split(", ");
			    
				var latitude = array_data[0];
				var longitude = array_data[1];
				
				$('#latitude').val(latitude);
				$('#longitude').val(longitude);
				
			} else {
				alert(results.length + "개의 결과를 찾았습니다.");
			}
		} else {
			alert('실패.');
		}
	});
}
</script>
</head>

<body>
<div class="container-fluid" style="background-color:#2196F3;color:#fff;height:100px;">
  <h1>관리자 PAGE <input type="button" value="로그아웃" onclick="logout()" class="btn btn-default" style="right: 1em; position: absolute;"></h1>
</div>
<br>

<div class="container">
  <div class="row">
    <nav class="col-sm-3">
      <ul class="nav nav-pills nav-stacked" data-spy="affix" data-offset-top="205">
<!--         <li class="active"><a href="#" onclick="">맛집 등록</a></li> -->
		<li><a href="#" onclick="company_add()">맛집 등록</a></li>
        <li><a href="#" onclick="company_modify_delete()">맛집 수정 및 삭제</a></li>
        <li class="active"><a href="#" onclick="dangerArea_add()">위험지역 등록</a></li>
        <li><a href="#" onclick="dangerArea_delete()">위험지역 삭제</a></li>
      </ul>
    </nav>
    <div class="col-sm-9">   
      <h1>위험지역 등록</h1>
      	<input type="hidden" value="${return_value}" id="return_value">		
          <form role="form" method="post" id="addDangerArea" name="addDangerArea" style="margin-top: 1em;">
			
			<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no" name="member_no">
				
			  <div class="form-group">
			    <label for="d_name">위험지역 이름</label>
			    <input type="text" class="form-control" id="d_name" name="d_name">
			  </div>
			  
			  <div class="form-group">
			    <label for="d_address">주소(위치)</label>
			    <input type="text" class="form-control" id="d_address" name="d_address" onchange="change_address()">
			  </div>
			  
			  <div style="margin-bottom: 1em;">
				<input type="text" id="latitude" name="d_latitude" readonly="readonly" placeholder="위도">
				<input type="text" id="longitude" name="d_longitude" readonly="readonly" placeholder="경도">
			  </div>
			  
			  <div class="form-group">
				<label for="d_content">상세 정보</label>
				<textarea class="form-control" rows="10" id="d_content" style="resize:none;" name="d_content"></textarea>
			  </div>
			  <input type="button" value="등록" id="singUp" class="btn btn-default">
		</form> 
      
      
    </div>
  </div>
</div>
</body>
</html>