<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD60rwjxUjBDRiDUUfwQvNhjiP8d8hXVD8"></script>
<script language="javascript">

function getAddr(){
	
	console.log($("#form").serialize());
	
	$.ajax({
		 url :"http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
		,type:"post"
		,data:$("#form").serialize()
		,dataType:"jsonp"
		,crossDomain:true
		,success:function(xmlStr){
			if(navigator.appName.indexOf("Microsoft") > -1){
				var xmlData = new ActiveXObject("Microsoft.XMLDOM");
				xmlData.loadXML(xmlStr.returnXml)
			}else{
				var xmlData = xmlStr.returnXml;
			}
			$("#list").html("");
			var errCode = $(xmlData).find("errorCode").text();
			var errDesc = $(xmlData).find("errorMessage").text();
			if(errCode != "0"){
				alert(errCode+"="+errDesc);
			}else{
				if(xmlStr != null){
					makeList(xmlData);
				}
			}
		}
	    ,error: function(xhr,status, error){
	    	alert("에러발생");
	    }
	});
}

function makeList(xmlStr){
	var htmlStr = "";
	var totalCount = $(xmlStr).find("totalCount").text();
	var countPerPage = $(xmlStr).find("countPerPage").text();
	var thisPage = $("#currentPage").val();
	var pageCount = totalCount/countPerPage;
		pageCount = Math.ceil(pageCount);
	var check = false;
	
	var i = 0;

	htmlStr += "<table class='table table-striped'>";
	htmlStr += " <thead><tr>";
	htmlStr += "<td>우편번호</td>";
	htmlStr += "<td>신주소</td>";
	htmlStr += "<td>구주소</td>";
	htmlStr += "</tr></thead><tbody>";
	$(xmlStr).find("juso").each(function(){
		addr_new = $(this).find('roadAddr').text();
		htmlStr += "<tr style='cursor: pointer;'>";
		htmlStr += "<td>"+$(this).find('zipNo').text()      +"</td>";
	 	htmlStr += "<td onclick='select_addr_new("+i+");' id='addr_new_"+i+"'>"+$(this).find('roadAddr').text() +"</td>";
	 	//htmlStr += "<td>"+$(this).find('roadAddrPart1').text()      +"</td>";
	 	//htmlStr += "<td>"+$(this).find('roadAddrPart2').text()      +"</td>";
	 	htmlStr += "<td onclick='select_addr_old("+i+");' id='addr_old_"+i+"'>"+$(this).find('jibunAddr').text() +"</td>";
		//htmlStr += "<td>"+$(this).find('engAddr').text()     +"</td>";
		//htmlStr += "<td>"+$(this).find('admCd').text()      +"</td>";
		//htmlStr += "<td>"+$(this).find('rnMgtSn').text()      +"</td>";
		//htmlStr += "<td>"+$(this).find('bdMgtSn').text()      +"</td>";
		//htmlStr += "<td>"+$(this).find('detBdNmList').text()      +"</td>";
		htmlStr += "</tr>";	
		i++;
	});	
	htmlStr += "</tbody></table>";
	
	
	htmlStr += "<div style='height:30px;'>";
	var start = $("#start").val();
	
	if(start == 1){
		htmlStr += "<div class='col-sm-2'>&nbsp;</div>";
	}
	
	if(start > 1){
		htmlStr += "<div class='col-sm-2'><ul class='pager' style='float: right;'><li><a href='#'  onclick='pagePrevious("+start+")'>이전</a></li></ul></div>";
	}
	
	
	var i = 0;
	var j = 0;
	htmlStr += "<div class='col-sm-8' align='center'><ul class='pagination'>";
	for(i = start; i <= pageCount; i++){
		if(check == false){
			if(thisPage == i){
				htmlStr += "<li><a href='#' class='active' onclick='pageMove("+i+")'>"+i+"</a></li>";
			} else {
				htmlStr += "<li><a href='#' onclick='pageMove("+i+")'>"+i+"</a></li>";
			}
			    j = i/10;
				j = Math.floor(j);
				
				if(i == j*10){
					check = true;
					htmlStr += "</ul></div><div class='col-sm-2'><ul class='pager' style='float: left;'><li><a href='#' onclick='paggingNext("+j+")'>다음</a></li></ul></div>";
				}
			
		}		
	}
	
	if(i <= 10){
		htmlStr += "</ul></div><div class='col-sm-2'>&nbsp;</div>";
	}
	
	
	htmlStr += "</div>";
	
	$("#list").html(htmlStr);
}

function pageMove(data){
	$("#currentPage").val(data);
	getAddr();
}

function pagePrevious(data){
	var j = data/10;
		j = Math.floor(j);
		j = j-1;
		j = j*10+1;
		$("#currentPage").val(j);
		$("#start").val(j);
		getAddr();
}

function paggingNext(data){
	var j = data*10 + 1;
	$("#currentPage").val(j);
	$("#start").val(j);
	getAddr();
}

function enterSearch() {
	var evt_code = (window.netscape) ? ev.which : event.keyCode;
	if (evt_code == 13) {    
		event.keyCode = 0;  
		getAddr(); //jsonp사용시 enter검색 
	} 
}

function select_addr_new(addr){
	$("#addr01").val($('#addr_new_'+addr).text());
	$("#addr02").val($('#addr_detail').val());
	
	$('#cls_btn').click();
	$('#cls_btn').click();
	
	getLocation();	
}
function select_addr_old(addr){

	$("#addr01").val($('#addr_old_'+addr).text());
	$("#addr02").val($('#addr_detail').val());
	
	$('#cls_btn').click();
	$('#cls_btn').click();
	
	getLocation();	
}
//위도 경도 구하기
var geocoder = new google.maps.Geocoder();
function getLocation() {
	
	var address = $("#addr01").val()+" "+$("#addr02").val();


	geocoder.geocode({'address': address}, function(results, status) {
		
		if( status == google.maps.GeocoderStatus.OK ) {  
		
			if (results.length == 1) {
				
				var location = "" + results[0].geometry.location;
				
				location = location.substring(1, location.length-1);
				
				var array_data = location.split(", ");
			    
				var latitude = array_data[0];
				var longitude = array_data[1];
				
				
				
				$('#latitude').val(latitude);
				$('#longitude').val(longitude);
			
				
				
			} else {
				alert(results.length + "개의 위,경도 결과를 찾았습니다. 정확한 주소를 입력해주세요.");
				$('#latitude').val("N");
			}
		} else {
			alert('실패.');
			$('#latitude').val("N");
			
		}
	});
	
}
</script>
<title>위치찾기</title>
</head>
<body>



<div class="container">

<div class="form-group" style="display: none;">
  <label for="latitude">위도:</label>
 <input type="text" class="form-control" id="latitude"/>
</div>
<div class="form-group" style="display: none;">
  <label for="longitude">경도:</label>
  <input type="text" class="form-control" id="longitude"/>
</div>
<div class="form-group" >
  <label for="addr01">주소:</label>
  <input type="text" class="form-control" id="addr01" readonly="readonly" value="${list[0].addr01}"/>
</div>
<div class="form-group" style="display: none;">
  <label for="addr02">상세주소:</label>
  <input type="text" class="form-control" id="addr02" readonly="readonly" value="${list[0].addr02}"/>
</div>
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#addrModal">주소검색</button>
  <button type="button" class="btn btn-success btn-lg" onclick="getLocation();" style="display: none;">위도경도</button>

  <!-- Modal -->
  <div class="modal fade" id="addrModal" role="dialog" >
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content" style="width: 300px;">
        <div class="modal-header">
        
          <h4 class="modal-title">검색</h4>
        </div>
        <div class="modal-body">
        <form name="form" id="form" method="post">
        	도로명,건물명,지번에 대해 통합검색이 가능합니다.
        	 <div style="display:none;">
				currentPage : <input type="text" name="currentPage" value="1" id="currentPage"/>
				countPerPage : <input type="text" name="countPerPage" value="10"/>
				totalCount : <input type="text" name="totalCount" id="totalCount" value=""/>
				start : <input type="text" id="start" value="1"/>
			 </div> 
        	<input type="text" name="confmKey" id="confmKey" style="width:250px;display:none" value="U01TX0FVVEgyMDE2MDYyMDE3NDMxMzEzMTMw"/>
	        <div class="row" style="margin-bottom: 10px;">
			  <div class="col-sm-10"><input type="text" class="form-control" id="keyword" name="keyword" placeholder="(예: 테헤란로 501, 삼성동 157-27, 반포자이아파트)" value="" onkeydown="enterSearch();"></div>
			  <div class="col-sm-2">
			  	<button type="button" class="btn btn-info" onClick="getAddr();">
			 	<span class="glyphicon glyphicon-search"></span> 
			 	 검색
			 	 </button>
			 </div>
			 
			</div>
			 <div class="row" style="margin-bottom: 10px;">
			  <div class="col-sm-10">상세주소<input type="text" class="form-control" id="addr_detail" name="addr_detail" value="" ></div>
			  <div class="col-sm-2"></div>
			 
			</div>
			<div id="list">
	
	       	</div>
				
			</form>
		</div> 
			
        <div class="modal-footer" style="margin-top: 20px;">
          <button type="button" class="btn btn-default" data-dismiss="modal" id="cls_btn">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
</div>

<style>
.col-sm-2{
	width: 80%;
}
</style>
</body>
</html>