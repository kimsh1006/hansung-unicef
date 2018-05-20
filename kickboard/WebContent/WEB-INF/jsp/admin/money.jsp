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

//금액 충전
function update_money(member_no,money){
	
	
	var params = "member_no="+member_no+"&money="+money;
	
	$.ajax({
	    type        : "POST" 
	  , async       : false
	  , url         : "/cmd/update_money.do"
	  , data        : params
	  , dataType    : "json"
	  , timeout     : 30000  
	  , cache       : false    
	  , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	  , error       : function(request, status, error) {
	           alert( "작업 도중 오류가 발생하였습니다. " );
	            
	  }
	  , success     : function(data) {
	
	  		location.href = "/cmd/get_money_list.do";	
	  	
	            
	  }
	});

}


</script>
 
<body>


<div data-role="page">
	  <jsp:include page="header.jsp"></jsp:include>
  <div data-role="main" class="ui-content">
  
    <h2 style=" text-align: center">충전관리</h2>

      
    <ul data-role="listview" data-inset="true"> 
     <table data-role="table" class="ui-responsive ui-shadow" id="myTable">
      <thead>
        <tr>
       
          <th>아이디</th>
          <th>입금자명</th>
          <th>충전요청금액</th>
           <th></th>
         
          
         
        </tr>
      </thead>
      <tbody>
    
        <c:forEach var="data" items="${list}">
            <tr>
            
			<td>${data.member_id}</td>
			<td>${data.nm}</td>
			<td>${data.money}</td>
			<td><div class="ui-block-a"  style="width: 100%" ><button type="button" data-theme="b" onclick="update_money(${data.member_no},${data.money});" >승인</button></div></td>
		
			
			</tr>
		</c:forEach>   
        
      </tbody>
    </table>
    	   
    </ul>
     
 
  </div>
  
     <jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>