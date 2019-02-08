<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<style>
#wth_locSelectcity{
	 width:120px; display: inline-block;
}
#wth_locSelectdistrict{
width:180px; display: inline-block;
}
</style>
<script type="text/javascript">
$(function(){
	initYearList = [{"wth_year" : "0", "wth_pre" : ""}];
	drawChart_year(initYearList);
	
	$("#wth_locSelectcity").change(function() {
		var text_shi = $("#wth_locSelectcity option:selected").val();
	
		var selected_shi = "shiname="+text_shi;
		
		 $.ajax({
			 type:"post",
			 url: "${path}/getWthYearDistrict.do",
			 dataType:"json",
			 data : selected_shi,
			 success:function(data){
				 var districtList = data.wthYearDistrict;
		       	 console.log(districtList);
		    	 $("#wth_locSelectdistrict > ").remove();
		    	 $("#wth_locSelectdistrict").append("<option value=''>지역 선택</option>");
		    	 for(var i=0; i<districtList.length; i++){
			    	 $("#wth_locSelectdistrict").append(
		    			 "<option value="+districtList[i].code_name+">"+districtList[i].code_name+"</option>"
		    		 );
		    	 }
	         }
		 });	
	 });
	
	 $("#wth_locSelectdistrict").change(function() {
		 var text_district = $("#wth_locSelectdistrict option:selected").val();
		 var selected_district = "code_name="+text_district;
		 
		 $.ajax({
		    type:"post",
		    url: "${path}/getWthYear.do",
		    dataType:"json",
		    data : selected_district,
		    success:function(data){
		    	var yearList = data.wthYear;
		    	console.log(yearList);
		    	drawChart_year(yearList);
		    	
		    } 
   		});
	 });
});
function drawChart_year(yearList) {
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawYear);
	function drawYear(){
		var data = new google.visualization.DataTable();
		data.addColumn('string','Year');
		data.addColumn('number','강수량');
		data.addRows(yearList.length);
		for(i=0; i<yearList.length; i++){
			data.setCell(i,0,yearList[i].wth_year);
			data.setCell(i,1,yearList[i].wth_pre);
		}
		var options = {
				height: 450,
		        lineWidth: 5,
	  			pointSize: 20,
	  			dataOpacity: 0.01,
	  			animation: { startup: true, duration: 2500, easing: 'out' },
	        	crosshair: { 
	        		orientation:'both',
	        		trigger:'both'
	        		},
	        	backgroundColor: {
	        		fill:'transparent'
	        		},
	        	curveType: 'function',
	        	hAxis: {
	        		title : '연도',
	        		titleTextStyle: {
	    				fontName:'Jeju Gothic',
		    		    color: 'white',
		    		    fontSize: 16,
		    		    bold: false,
		    		    italic: false
		    		  },
	        		textStyle: {
	   					fontName:'Jeju Gothic',
	    		    	color: 'white',
	    		    	fontSize: 12,
	    		    	bold: false,
	    		    	italic: false
	   		  			}
	        		},
				vAxis : {
					title : "강수량",
					titleTextStyle: {
	    				fontName:'Jeju Gothic',
		    		    color: 'white',
		    		    fontSize: 16,
		    		    bold: false,
		    		    italic: false
		    		  },
					textStyle : {
						fontName:'Jeju Gothic',
	 		    		color: 'white',
	  		    		fontSize: 12,
	  		    		bold: false,
	  		    		italic: false
						}
	        		},
				chartArea:{
					width: '80%',
					height: '60%'
					},
		        legend: { 
	     	   		position: 'top',
	     	   		textStyle: {
						fontName:'Jeju Gothic',
	  		    		color: 'white',
	  		    		fontSize: 16,
	  		    		bold: false,
	  		    		italic: false
	  		  			}
	       			}
	      		};
		var chart = new google.visualization.LineChart(document.getElementById('year_chart'));
		chart.draw(data, options);
		
	}
	
 }
</script>

<body>
	<div class="panel panel-default anal-back">
		<div class="panel-heading anal-head">
			<h3 class="panel-title anal-title">
				<i class="fa fa-bar-chart-o"></i> 
				지역별 연도 강수량
			</h3>
		</div>
		
		<div class="panel-body anal-body show">
			<select id="wth_locSelectcity" class="form-control">
	            <option value="" selected="selected">시/도 선택</option>
	            <option value="강원도">강원도</option>
	            <option value="경기도">경기도</option>
	            <option value="경상남도">경상남도</option>
	            <option value="경상북도">경상북도</option>
	            <option value="광주광역시">광주광역시</option>
	            <option value="대구광역시">대구광역시</option>
	            <option value="대전광역시">대전광역시</option>
	            <option value="부산광역시">부산광역시</option>
	            <option value="서울특별시">서울특별시</option>
	            <option value="세종특별자치시">세종특별자치시</option>
	            <option value="울산광역시">울산광역시</option>
	            <option value="인천광역시">인천광역시</option>
	            <option value="전라남도">전라남도</option>
	            <option value="전라북도">전라북도</option>
	            <option value="제주도">제주특별자치도</option>
	            <option value="충청남도">충청남도</option>
	            <option value="충청북도">충청북도</option>	                
            </select>
            <select id="wth_locSelectdistrict" class="form-control">
            	<option value="" selected="selected" >지역 선택</option>
            </select>
		 	 <div id="year_chart" style="position:relative;"></div>
		</div>
	</div>
</body>
</html>