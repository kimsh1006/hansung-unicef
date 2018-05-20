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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript">
$(document).ready(function(){

	
});

//글수정
function update_board(){
	var title = $("#title").val();
	var content = $("#content").val();
	
	var member_no = "<%=member_no%>";
	var board_no = $("#board_no_hidden").val();
	
	
	if(title== "" || title == "null" || title == null){
		alert("제목을 입력하세요!");
		return false;
	}
	if(content == "" || content == "null" || content == null){
		alert("내용을 입력하세요!");
		return false;
	}
	
	if(member_no == "" || member_no == "null" || member_no == null){
		alert("로그인후 이용하세요!");
		location.href = "/cmd/main.do";
		return false;
	}
	
	
	var params = "title="+title+"&content="+content+"&member_no="+member_no+"&board_no="+board_no;
	
	    $.ajax({
	        type        : "POST" 
	      , async       : false
	      , url         : "/cmd/update_board.do"
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
	      		alert("수정성공!");
	      		location.href = "/cmd/board.do";	
	      	}else{
	      		alert("수정실패!");
	      		location.href = "/cmd/board.do";	
	      		return false;
	      	}
	                
	      }
		});
 }
</script>
<title>커뮤니티</title>
</head>
<body>
<input tppe = "hidden" id="board_no_hidden" value="${article.board_no}"/>
<div data-role="page">
<div data-role="header">
	
	    <div data-role="navbar">
	      <ul>
					<li ><a href="/cmd/list.do">고민채팅방</a></li>
					<li style="background-color: #ffa1a1;"><a href="/cmd/board.do" >고민게시판</a></li>
				</ul>
	    </div>
	  </div>
  <div data-role="main" class="ui-content">
    
      <div class="ui-field-contain">
        <label for="title">제목</label>
        <input type="text" name="title" id="title" value="${article.title}">       
       <label for="content">내용 </label>
        <textarea name="content" id="content">${article.content}</textarea>
        
      </div>
        <div class="ui-block-a" style="width:100%;" ><button type="button" data-theme="b" onclick="update_board();" >수정</button></div>
    
  </div>
</div>





</body>
</html>