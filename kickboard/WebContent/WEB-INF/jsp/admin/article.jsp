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


//글등록
function insert_answer(){

	var answer_content = $("#answer_content").val();
	var answer_write = "<%=member_no%>";
	var board_no  = $('#board_no_hidden').val();
	
	
	
	if(answer_content == "" || answer_content == "null" || answer_content == null){
		alert("내용을 입력하세요!");
		return false;
	}
	
	
	if(answer_write == "" || answer_write == "null" || answer_write == null){
		alert("로그인후 이용하세요!");
		return false;
	}
	
	
	var params = "answer_content="+answer_content+"&answer_write="+answer_write+"&board_no="+board_no;
	
	    $.ajax({
	        type        : "POST" 
	      , async       : false
	      , url         : "/cmd/insert_answer.do"
	      , data        : params
	      , dataType    : "json"
	      , timeout     : 30000  
	      , cache       : false    
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	               alert( "작업 도중 오류가 발생하였습니다. " );
	                
	      }
	      , success     : function(data) {
	           
	      	if(data.result_code=="1"){
	      		alert("등록성공!");
	      		location.href = "/cmd/get_article_admin.do?board_no="+board_no;
	      			
	      	}else{
	      		alert("등록실패!");
	      		location.href = "/cmd/get_article_admin.do?board_no="+board_no;
	      	}
	                
	      }
		});
 }
 
 
</script>
<body>

<div data-role="page">
	<input type="hidden" id="board_no_hidden" value="${article.board_no}">
	<jsp:include page="header.jsp"></jsp:include>
	<a href="javascript:history.back()" style="font-size: 25px; font-weight: 600;"><img src="/css/back.png" style="   margin-left: 15px;margin-top: 15px; width: 25px;"> </a>
  <div data-role="main" class="ui-content">
	
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

	<div data-role="footer" class="input_margin" data-position="" style="padding:.5em; background-color:#fff; boder:none !important;">
		<div class="ui-grid-b">
				<div class="ui-block-b" style="width:68% !important;">
					<input type="text" id="answer_content" placeholder="댓글쓰기" style="background-color:#e5e5e5; color:#000; text-shadow:none; font-weight:normal; font-size:14px; font-family:'godom';">
				</div>
				<div class="ui-block-c" style="width:25% !important; padding:0 0 0 .3em;">
				   <button type="button" data-theme="c" onclick="insert_answer();" style="float: right;">답변등록 </button>
	
				</div>
			</div>
	</div>
	
<jsp:include page="../footer.jsp"></jsp:include>
 
</div> 

</body>
</html>
