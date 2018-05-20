
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<meta charset= "utf-8">
<script type="text/javascript">
$(document).ready(function(){
	location.href = "<%=cp%>/cmd/get_bike_list.do";

});



</script>
<title>관리자</title>
</head>
<body>

	<div data-role="page" id="pageone">
	  <jsp:include page="header.jsp"></jsp:include>
	 
	
	</div>



</body>


 
</html>