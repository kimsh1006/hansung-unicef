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
   
    if (session.getAttribute("sessionData") != null) {
    	
    	 sessionData = (Map)session.getAttribute("sessionData");
		 member_id = sessionData.get("member_id").toString();	
		
       
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
<link rel="stylesheet" href="/css/public.css">
</head>
<script type="text/javascript">

$(document).ready(function(){
	
	
});



//검색
function search(){
	var search = $('#search').val();

	location.href = "/cmd/board.do?search="+search;
}
</script>

<body>


<div data-role="page" id="pa  eone">
	<jsp:include page="../header.jsp"></jsp:include>
  <div data-role="main" class="ui-content">
    <div style="height: 70px;">
   		<h2 style=" text-align: right;" class="title">게시판</h2><div><a href="<%=cp%>/cmd/logout.do" rel="external" class="logout" style="height: 35px;">로그아웃</a></div>
 	</div>
 	<div class="ui-block-a" style="width: 100%;" ><button type="button" data-theme="b" style="background-color: #2ad !important; margin-top: 1px;" onclick="location.href='/cmd/get_write.do';" style="float: right;">글쓰기</button></div>
 	
    <div  class="ui-block-a" style="margin-top: 0px; width: 60%; ">
  	  <input type="text" value="" id="search" placeholder="검색">    
    </div>
    <div class="ui-block-b" style="float: left; width: 30%; max-width: 70px;" ><button type="button" data-theme="b" style="background-color: #2ad !important; float: margin-top: 7px; height: 36px;line-height: 12px; width: 100%;" onclick="search();" style="float: right;">검색</button></div>
 	
 	
    <ul data-role="listview" data-inset="true" style="margin-top: 130px;"> 
    	<c:forEach var="data" items="${board_list}">
			<li><a href="#" style="text-align: center;"  onclick="location.href='/cmd/get_article.do?board_no=${data.board_no}';">
			 ${data.member_id}-
			 ${data.title}</a></li>
			
		</c:forEach>      
    </ul>
     
 
  </div>
  
  <jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>