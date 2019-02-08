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
#wth_locSelectyear{
	 width:120px; display: inline-block;
}
#wth_locSelectshiname{
width:180px; display: inline-block;
}
</style>
<script type="text/javascript">
$(function(){
	var selected_year = "";
	var selected_city = "";
	
	initCountList = [{"location" : " ", "count" : "0", "wth_pre" : ""}];
	drawChart_count(initCountList);
	
	$.ajax({
		 type:"post",
		 url: "${path}/getWthYearCount.do",
		 dataType:"json",
		 success:function(data){
			 var yearList = data.wthYear;
	       	 console.log(yearList);
	    	 $("#wth_locSelectyear > ").remove();
	    	 $("#wth_locSelectyear").append("<option value=''>연도 선택</option>");
	    	 for(var i=0; i<yearList.length; i++){
		    	 $("#wth_locSelectyear").append(
	    			 "<option value="+yearList[i].wth_year+">"+yearList[i].wth_year+"</option>"
	    		 );
	    	 }
        }
	 });

	$("#wth_locSelectyear").change(function() {
		var text_year = $("#wth_locSelectyear option:selected").val();
		selected_year = "wth_year="+text_year;
		exeAjax(selected_year, selected_city);
	 }); 
	
	$("#wth_locSelectshiname").change(function() {
		if(selected_year != "" && selected_year != null){
			 var text_city = $("#wth_locSelectshiname option:selected").val();
			 selected_city = "shiname="+text_city;
			 exeAjax(selected_year, selected_city);
		} 
	 });
});

function exeAjax(selected_year, selected_city){
	$.ajax({
	    type:"post",
	    url: "${path}/getWthCount.do",
	    dataType:"json",
	    data : selected_year+"&"+selected_city,
	    success:function(data){
	    	var countData = data.wthCount;
	    	console.log(countData);
	    	drawChart_count(countData);
	    } 
	}); 
}
function drawChart_count(countList) {
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawCount);
	function drawCount(){
		var data = new google.visualization.DataTable();
		data.addColumn('string','area');
		data.addColumn('number','강수일수');
		data.addColumn('number','강수량');
		data.addRows(countList.length);
		for(i=0; i<countList.length; i++){
			data.setCell(i,0,countList[i].location);
			data.setCell(i,1,countList[i].count);
			data.setCell(i,2,countList[i].wth_pre);
		}
		var classicOptions = {
				  is3D: true,
				  animation: { startup: true, duration: 2500, easing: 'out' },
				  height: 450,
				  backgroundColor: { fill:'transparent' },
				  lineWidth: 5,
				  pointSize: 20,
				  dataOpacity: 0.01,
				  crosshair:{
					orientation:'both',
					trigger:'both'
				  },
				  chartArea:{
						width: '80%',
						height: '60%'
					},
				  // Gives each series an axis that matches the vAxes number below.
				  series: {
				    0: {targetAxisIndex: 0},
				    1: {targetAxisIndex: 1}
				  },
				  vAxes: {
				    // Adds titles to each axis.
				    0: {
				    		title: '연 강수일수',
				    		titleTextStyle: {
				    			fontName: 'Jeju Gothic',
				    		    color: 'white',
				    		    fontSize: 16,
				    		    bold: false,
			    		    	italic: false
				    		  }
			    		},
				    1: {
				    		title: '연 강수량',
			    			titleTextStyle: {
			    				fontName:'Jeju Gothic',
				    		    color: 'white',
				    		    fontSize: 16,
				    		    bold: false,
				    		    italic: false
				    		  }
				    	}
				  },
				  hAxis: {
					  title : '지역',
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
				  legend:{
					  textStyle:{
					  	fontName:'Jeju Gothic',
		    		    color: 'white',
		    		    fontSize: 12,
		    		    bold: false,
		    		    italic: false
					  }
				  },
				  vAxis: {
				  	textStyle: {color: 'white'},
				    viewWindow: {
				     0:	{max: 1800},
				     1: {max: 300}
				    }
				  }
				};
		var chart = new google.visualization.LineChart(document.getElementById('count_chart'));
		chart.draw(data, classicOptions);
	}
 }	     
</script>

<body>
	<div class="panel panel-default anal-back">
		<div class="panel-heading anal-head">
			<h3 class="panel-title anal-title">
				<i class="fa fa-bar-chart-o"></i> 
				연도별 강수일수에 따른 강수량
			</h3>
		</div>
		
		<div class="panel-body anal-body show">
			<select id="wth_locSelectyear" class="form-control">
            	<option value="" selected="selected" >연도 선택</option>
            </select>
			<select id="wth_locSelectshiname" class="form-control">
	            <option value="" selected="selected">시/도 선택</option>
	            <option value="강원도">강원도</option>
	            <option value="경기도">경기도</option>
	            <option value="경상남도">경상남도</option>
	            <option value="경상북도">경상북도</option>
	            <option value="광역시">특별/광역시</option>
	         <!--    <option value="광주광역시">광주광역시</option>
	            <option value="대구광역시">대구광역시</option>
	            <option value="대전광역시">대전광역시</option>
	            <option value="부산광역시">부산광역시</option>
	            <option value="서울특별시">서울특별시</option>
	            <option value="울산광역시">울산광역시</option>
	            <option value="인천광역시">인천광역시</option> -->
	            <option value="전라남도">전라남도</option>
	            <option value="전라북도">전라북도</option>
	            <option value="제주특별자치도">제주특별자치도</option>
	            <option value="충청남도">충청남도</option>
	            <option value="충청북도">충청북도</option>	                
            </select>
		 	 <div id="count_chart" style="position:relative;"></div>
		</div>
	</div>
</body>
</html>