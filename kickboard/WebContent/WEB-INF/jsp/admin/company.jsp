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
  
   
    if (session.getAttribute("sessionData") != null) {
    	
    	 sessionData = (Map)session.getAttribute("sessionData");
		 member_id = sessionData.get("member_id").toString();	
		 member_no = sessionData.get("member_no").toString();	
		
       
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

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD60rwjxUjBDRiDUUfwQvNhjiP8d8hXVD8"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<script type="text/javascript">

$(document).ready(function(){
	var a = '<%=member_no%>';
	
	$('#member_no').val(a);
	var checkPage = $("#return_value").val();
	if(checkPage == "addOk"){
		alert("등록이 완료 되었습니다.");
		$("#return_value").val("");
	}
	
	$("#singUp").click(function(){
		var c_name = $("#c_name").val();
		var c_type = $("#c_type").val();
		var c_address = $("#c_address").val();
		var c_phone = $("#c_phone").val();
		var c_content = $("#c_content").val();
		var latitude = $("#latitude").val();
		var longitude = $("#longitude").val();
		
		if(c_name == null || c_name == ""){
			alert("업체명을 입력해 주세요.")
		} else if (c_type == null || c_type == ""){
			alert("업체의 종류를 입력해 주세요.(ex] 치킨, 피자 등...)")
		} else if (c_address == null || c_address == ""){
			alert("업체 주소를 입력해 주세요.")
		} else if (c_phone == null || c_phone == ""){
			alert("업체 연락처를 입력해 주세요.")
		} else if (c_content == null || c_content == ""){
			alert("업체의 상세 정보를 입력해 주세요.")
		} else if (latitude == "위도"){
			alert("정확한 주소입력 후 주소변환 버튼을 클릭해 주세요.")
		} else {
			confirm();
		}
		
	});
});

function change_address(){
	var c_address = $("#c_address").val();
	getLocation();
}

function confirm(){
    document.addCompany_form.action = '<%=cp%>/main/addCompany_form.do';
    document.addCompany_form.submit();
}



 //위도 경도 구하기
var geocoder = new google.maps.Geocoder(); 
function getLocation() {
		
	var address = $("#c_address").val();
	
	geocoder.geocode({'address': address,region: 'ko'}, function(results, status) {
	
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
 
<body>


<div data-role="page">
	  <jsp:include page="header.jsp"></jsp:include>
  <div data-role="main" class="ui-content">
  <input type="hidden" value="${return_value}" id="return_value">
    <h2 style=" text-align: center">맛집 등록</h2>
   	<form role="form" method="post" id="addCompany_form" name="addCompany_form" style="margin-top: 1em;">
			<div>
			<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no" name="member_no">
			
			  <div class="form-group">
			    <label for="c_name">업체명</label>
			    <input type="text" class="form-control" id="c_name" name="c_name">
			  </div>
			  
			  <div class="form-group">
			    <label for="c_type">업종</label>
				<select class="form-control" id="c_type" name="c_type">
				  <option selected="selected" value="">업종 선택</option>
				  <option value="한 식"> 한 식</option>
				  <option value="일 식"> 일 식</option>
				  <option value="중 식"> 중 식</option>
				  <option value="기 타"> 기 타</option>
				</select>
			  </div>
			  
			   <div class="form-group">
			    <label for="c_address">주소</label>
			    <input type="text" class="form-control" id="c_address" name="c_address" onchange="change_address()">
			  </div>
			  <div class="ui-grid-a">
			  	<div class="ui-block-a">
					<input type="text" value="위도" id="latitude" name="c_latitude" readonly="readonly">
				</div>
				<div class="ui-block-b">
					<input type="text" value="경도" id="longitude" name="c_longitude" readonly="readonly">
				</div>				  
			  </div>

			  <div class="form-group">
			    <label for="c_phone">연락처</label>
			    <input type="number" class="form-control" id="c_phone" name="c_phone">
			  </div>
			  
			  <div class="form-group">
				<label for="c_content">상세 정보</label>
				<textarea class="form-control" rows="10" id="c_content" style="resize:none;" name="c_content"></textarea>
			  </div>
			  <input type="button" value="등록" id="singUp" class="btn btn-default">
			  </div>
		</form>

            
  
     
 
  </div>
  
     <jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>