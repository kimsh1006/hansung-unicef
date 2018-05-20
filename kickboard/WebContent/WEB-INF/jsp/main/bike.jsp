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
    String bike_no = "";
   
    if (session.getAttribute("sessionData") != null) {
    	
    	 sessionData = (Map)session.getAttribute("sessionData");
		 member_id = sessionData.get("member_id").toString();	
		 member_no = sessionData.get("member_no").toString();	
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
<link rel="stylesheet" href="/css/public.css">
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>


<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<script type="text/javascript">
$(document).ready(function(){
	
	var bike_no = '<%=bike_no%>';
	if(bike_no > 0){
		alert("이미 사용중인 자전거가 있습니다.");
		location.href = "/cmd/info.do";	
	}
	
});

//자전거사용
function use_bike(bike_no,price){
	

	var member_no = '<%=member_no%>';
	
	var params = "bike_no="+bike_no+"&member_no="+member_no+"&use_yn=Y"+"&price="+price;
	
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


</script>
 
<body>


<div data-role="page">

<jsp:include page="../header.jsp"></jsp:include>
  <div data-role="main" class="ui-content">
  
  <div style="height: 70px;">
   		<h2 style=" text-align: center;" class="title">자전거</h2><div style="text-align: right;"><a href="<%=cp%>/cmd/logout.do" rel="external" class="logout">로그아웃</a></div>
 	</div>   
   
       
    <ul data-role="listview" data-inset="true"> 
     <table data-role="table" class="ui-responsive ui-shadow" id="myTable">
      <thead>
        <tr>
       
          <th>자전거번호</th>
          <th>자전거명</th>
           <th>가격</th>
          <th>자전거위치</th>
          <th> </th>
         
        </tr>
      </thead>
      <tbody>
    
        <c:forEach var="data" items="${bike_list}">
            <tr style="border-bottom : 1px solid #000;">
            
			<td>${data.bike_no}</td>
			<td>${data.bike_nm}</td>
			<td>${data.price}</td>
			<td>${data.addr}</td>
			<td>
			<button type="button" data-theme="b" style="background-color: #2ad !important;"  onclick="use_bike('${data.bike_no}','${data.price}');" >사용</button>
			</td>
			</tr>
		</c:forEach>   
        
      </tbody>
    </table>
    	   
    </ul>
     
 
  </div>
  
   <jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>