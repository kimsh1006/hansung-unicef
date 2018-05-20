<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Map" %>
<%@page import="cmd.vo.CmdVO"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/css/public.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>

<body>




	<div data-role="header" class="">
	   
	    <div data-role="navbar">
	      <ul>
	       <li><a href="<%=cp%>/cmd/get_bike_list.do" rel="external">자전거관리</a></li>
	        <li><a href="<%=cp%>/cmd/get_money_list.do" rel="external">충전관리</a></li>
	        <li><a href="<%=cp%>/cmd/board_admin.do" rel="external">문의관리</a></li>  
	          <li><a href="<%=cp%>/cmd/store_admin.do" rel="external">맛집관리</a></li>  
	            <li><a href="<%=cp%>/cmd/danger_admin.do" rel="external">위험지역관리</a></li>  
	        <li><a href="<%=cp%>/cmd/logout.do" rel="external">로그아웃</a></li>
	        
	         
	      </ul>
	    </div>
	  </div>
  

</body>
</html>