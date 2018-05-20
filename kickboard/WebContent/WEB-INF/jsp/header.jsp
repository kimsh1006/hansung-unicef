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
 <link rel="stylesheet" href="/css/reset.css">
  <link rel="stylesheet" href="/css/style.css">
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD60rwjxUjBDRiDUUfwQvNhjiP8d8hXVD8"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
 <script type="text/javascript">
        jQuery(document).ready(function($) {
            // hide the menu when the page load
            $("#navigation-list").hide();
            // when .menuBtn is clicked, do this
            $(".menuBtn").click(function() {
                // open the menu with slide effect
                $("#navigation-list").slideToggle(0);
            });
            
            
        	$("#pageMove_list").click(function(){
        		var member_no = $("#member_no").val();
        		var latitude = $("#latitude").val();
        		var longitude = $("#longitude").val();
        		location.href="<%=cp%>/main/move_list.do?latitude="+latitude+"&longitude="+longitude+"&member_no="+member_no;
        	});
        	
        
        	
        	$("#pageMove_dangerArea").click(function(){
        		location.href="<%=cp%>/main/dangerArea.do"
        	});
            
        	window.myAndorid.locations();
        });
        
      //위치 위도,경도 저장
        function receiveLocation(location) {
        	
        	var array_data = location.split("$");  // 위도 경도 문자열로 잘라 배열넣기
        	
        	//히든에 위도 경도 저장하기
        	$("#latitude").val(array_data[0]);
        	$("#longitude").val(array_data[1]);
        	initialize();
      }

        function initialize() {
        	var latitude = $("#latitude").val();
        	var longitude = $("#longitude").val();
            var mapLocation = new google.maps.LatLng(latitude, longitude); // 지도에서 가운데로 위치할 위도와 경도 
            var markLocation = new google.maps.LatLng(latitude, longitude); // 마커가 위치할 위도와 경도         

            var mapOptions = {
              center: mapLocation, // 지도에서 가운데로 위치할 위도와 경도(변수)
              zoom: 18, // 지도 zoom단계
              mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            var map = new google.maps.Map(document.getElementById("map-canvas"), // id: map-canvas, body에 있는 div태그의 id와 같아야 함
                mapOptions);
            var size_x = 60; // 마커로 사용할 이미지의 가로 크기
            var size_y = 60; // 마커로 사용할 이미지의 세로 크기         

            // 마커로 사용할 이미지 주소
            var image = new google.maps.MarkerImage( 'http://www.larva.re.kr/home/img/boximage3.png',
                                new google.maps.Size(size_x, size_y),
                                '',
                                '',
                                new google.maps.Size(size_x, size_y));
            var marker = "";
            marker = new google.maps.Marker({ 
                   position: markLocation, // 마커가 위치할 위도와 경도(변수)
                   map: map,
                   icon: image, // 마커로 사용할 이미지(변수)
                info: '바로 여기~!',
//                 title: '' // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
            });        

//             var content = ""; // 말풍선 안에 들어갈 내용         

            // 마커를 클릭했을 때의 이벤트. 말풍선 뿅~
//             var infowindow = new google.maps.InfoWindow({ content: content});
//             google.maps.event.addListener(marker, "click", function() {
//                 infowindow.open(map,marker);
//             });
          }

          google.maps.event.addDomListener(window, 'load', initialize);
        	
    </script>

<style type="text/css">
	.ui-navbar{
		height: 65px;
	}
	#navigation-list{
		height: 100px;
    margin-top: 26px;
	}
</style>


</head>

<body>
  <input type="hidden" value="37.615246" id="latitude">
		<input type="hidden" value="126.71563300000003" id="longitude">

	<div data-role="header" class="">
	   
	    <div data-role="navbar">
	     <span class="menuBtn"><img src="/css/icon.svg" alt="Menu icon"></span>
                <nav id="navigation-list">
                  <ul>
                      
			       <li><a href="<%=cp%>/cmd/info.do" rel="external" class="btn-blue">내정보</a></li>
			           <li><a href="<%=cp%>/cmd/money.do" rel="external" class="btn-blue">충전</a></li>
			        <li><a href="<%=cp%>/cmd/get_bike_list_member.do" rel="external" class="btn-blue">자전거</a></li>
			         <li><a href="" id='pageMove_list' rel="external" class="btn-blue">맛집</a></li>
			          <li><a href="" id='pageMove_dangerArea' rel="external" class="btn-blue">위험지역</a></li>
			        <li><a href="<%=cp%>/cmd/board.do" rel="external" class="btn-blue">게시판</a></li>                   
				         
                  </ul>  
	         
	    
	    </div>
	  </div>
  

</body>
</html>