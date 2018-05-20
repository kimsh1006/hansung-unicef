<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.util.Map" %>
<%@page import="cmd.vo.CmdVO"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	Map sessionData = null;
	  
    boolean isSession = true;
    CmdVO vo = null;
    String member_id="";
    String member_no="";
    
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<script type="text/javascript">



 
</script>
<body>

<div data-role="page">
	<input type="hidden" id="board_no_hidden" value="${article.board_no}">
	<jsp:include page="../header.jsp"></jsp:include>
	
  <div data-role="main" class="ui-content">
	  <a href="javascript:history.back()" style="font-size: 25px; font-weight: 600;"><img src="/css/back.png" style="width: 25px;"> </a>
   <div class="ui-grid-a" style="border-bottom:solid black 2px; padding-top:1em; width:100%; ">
   
    <h2>${article.title}</h2>
    <p>${article.content}</p>
    </div>
	<span style="color:#888; font-size:8px; padding-left:.5em;"></span>
  	<div style="padding:0 .5em;" class="input_type_more">
  	<div class="ui-grid-a" style="width:15%; text-align:left;" >
		답변
	</div>
				<c:forEach var="answer" items="${answer}">
					<div class="ui-grid-b" style="border-bottom:solid #e9e9e9 1px; padding-top:.5em;">
						<div class="ui-block-b" style="width:100%;">
							<div id="modeify_1">		
							
								<p style="margin: 0 0 .3em 0; font-size:12px;">
								${answer.member_id} 님
								
								 </p>
								<p style="margin:0; font-size:12px; width:100%;">${answer.answer_content} 
									<c:if test="${sessionScope.member_no == answer.answer_write}">
										<span style="color:#888; font-size:8px; float: right"  onclick="delete_answer('${answer.answer_no}');" >X</span>
									</c:if>
								</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>			
			
			<c:if test="${fn:length(answer) < 1}">
				<p style="font-weight:normal; text-shadow:none; font-size:14px; text-align:center; margin:0; padding:.5em 0; color:#888;"><span style="padding-right:.5em;"></span>등록된 답변이 없습니다.</p>
			</c:if>
			
			
		</div>

	
	
<jsp:include page="../footer.jsp"></jsp:include>
 
</div> 

</body>
</html>
