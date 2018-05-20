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


<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<script type="text/javascript">

$(document).ready(function(){
	
	

	
});

//등록
function insert(){

	var bike_nm = $('#bike_nm').val();
	var price = $('#price').val();
	var password = $('#password').val();
	var addr = $('#addr01').val();
	var longitude = $('#longitude').val();
	var latitude = $('#latitude').val();
	
	if(bike_nm == ""){
		return alert("자전거명을 입력해주세요.");
	}
	
	if(price == ""){
		return alert("가격을 입력해주세요.");
	}
	
	if(password == ""){
		return alert("비밀번호를 입력해주세요.");
	}
	
	if(addr == ""){
		return alert("주소를 입력해주세요.");
	}
	
	

	var params = "bike_nm="+bike_nm+"&price="+price+"&bike_pw="+password+"&addr="+addr+"&longitude="+longitude+"&latitude="+latitude;
	
	$.ajax({
        type        : "POST" 
      , async       : false
      , url         : "/cmd/insert_bike.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
               alert( "작업 도중 오류가 발생하였습니다. " );
                
      }
      , success     : function(data) {
    
      		location.href = "/cmd/get_bike_list.do";	
      	
                
      }
	});
	
}


</script>
 
<body>


<div data-role="page">
	  <jsp:include page="header.jsp"></jsp:include>
  <div data-role="main" class="ui-content">
  
    <h2 style=" text-align: center">자전거목록</h2>
   	<label for="bike_nm">자전거명</label>
        <input type="text" name="bike_nm" id="bike_nm">   
        <label for="price">가격</label>
        <input type="text" name="price" id="price">    
        <label for="password">비밀번호</label>
        <input type="text" name="password" id="password">    
        <!--주소 -->
	<jsp:include page="address.jsp"/>
            
    <div class="ui-block-a"  style="width: 100%" ><button type="button" data-theme="b" onclick="insert();" >등록</button></div>
       
    <ul data-role="listview" data-inset="true"> 
     <table data-role="table" class="ui-responsive ui-shadow" id="myTable">
      <thead>
        <tr>
       
          <th>자전거번호</th>
          <th>자전거명</th>
           <th>가격</th>
          <th>자전거위치</th>
          
         
        </tr>
      </thead>
      <tbody>
    
        <c:forEach var="data" items="${bike_list}">
            <tr>
            
			<td>${data.bike_no}</td>
			<td>${data.bike_nm}</td>
			<td>${data.price}</td>
			<td>${data.addr}</td>
			
			</tr>
		</c:forEach>   
        
      </tbody>
    </table>
    	   
    </ul>
     
 
  </div>
  
     <jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>