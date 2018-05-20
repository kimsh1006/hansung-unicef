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

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<script src="/js/bootstrap.js"></script>



<script type="text/javascript">
$(document).ready(function(){
	

	
});

function details(c_no){
	location.href="<%=cp%>/main/details.do?c_no="+c_no;
}
</script>

</head>
<body>
	<div data-role="page">		
				
		<jsp:include page="../header.jsp"></jsp:include>
		
		<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no" name="member_no">
		<input type="hidden" value="${latitude}" id="latitudeL">
		<input type="hidden" value="${longitude}" id="longitudeL">
		
		<div data-role="content">
			<div align="center">
				
			</div>
			<c:forEach var="data" items="${companyList}">
				<div onclick="details('${data.c_no}')" style="border:solid 2px #2ad; padding:.3em; position:relative; margin-bottom:.5em;">
					<p>업 체 명 : ${data.c_name}</p>
					<p>거    리 : ${data.distance} Km</p>
					<p>주    소 : ${data.c_address}</p>
					<p>연 락 처 : ${data.c_phone}</p>
				</div>
			</c:forEach>
			
		</div>	
		<jsp:include page="../footer.jsp"></jsp:include>
		
	</div>
</body>
</html>