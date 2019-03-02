<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<style>
</style>
<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 --> <script type="text/javascript">
//지역별
$(function(){   
	var areaCount = 
		$.ajax({
			type : 'GET',
			url : 'getAreaJson.do',		
			dataType : 'json',	
			success : function(area){
				console.log("getAreaJson "+ area);
				google.charts.load('current', {
					'packages': ['geochart'],
				    'mapsApiKey': 'AIzaSyBjfJ0rSlM7lMO19WnF8qg-joorUAod76M'
				    });
		 		google.charts.setOnLoadCallback(drawMarkersMap);
		
			  function drawMarkersMap() {
				var data = new google.visualization.DataTable();
				data.addColumn('string','도시');
				data.addColumn('number','지진 발생횟수');
				var magnitude = new Array();
				console.log(parseInt(area.areaanalysis[0].eqCountArea));
			
				var code = ['KR-42','KR-41','KR-48','KR-47','KR-29','KR-27','KR-30','KR-26','북한','KR-11','KR-31','KR-28','KR-46','KR-45','KR-49','KR-44','KR-43'];
				var regions = ['강원','경기','경남','경북','광주','대구','대전','부산','북한','서울','울산','인천','전남','전북','제주','충남','충북'];
				for(i=0;i<=16;i++){
					if(i!=8){				
						data.addRows([[{v:code[i],f:regions[i]},parseInt(area.areaanalysis[i].eqCountArea)]]);
						magnitude[code[i]] =
							'<span style="font-size:12px; font-weight:800;">'+regions[i]+'</span>'
							+'<table border=1; class="overTbl">'
							+'<tr><th style="text-align:center">규모</th><th style="text-align:center">지진 발생횟수</th></tr> <tr><td> '
											+'규모 0~1 </td><td >'+area.areaanalysis[i].magnitudeUnderOne+'</td></tr> <tr><td>'
											+'규모 1~2 </td><td>'+area.areaanalysis[i].magnitudeUnderTwo+'</td></tr> <tr><td>'
											+'규모 2~3 </td><td>'+area.areaanalysis[i].magnitudeUnderThree+'</td></tr> <tr><td>'
											+'규모 3~4 </td><td>'+area.areaanalysis[i].magnitudeUnderFour+'</td></tr> <tr><td>'
											+'규모 4~5 </td><td>'+area.areaanalysis[i].magnitudeUnderFive+'</td></tr> <tr><td>'
											+'규모 5~6 </td><td>'+area.areaanalysis[i].magnitudeUnderSix+'</td></tr> <tr><td>'
											+'규모 6~ </td><td>'+area.areaanalysis[i].magnitudeAndOverSix+'</td></tr>';
					}
					
				}
				console.log(magnitude);
			  var options = {
				height: 300,
				backgroundColor: {fill:'transparent',stroke:'#FFFFFF' ,strokeWidth:0 },
				backgroundColor: {fill:'transparent',stroke:'#FFFFFF' ,strokeWidth:0 },	
			    region: 'KR',
			    displayMode: 'regions', 
			    enableRegionInteractivity: true, 
			    resolution : 'provinces',
			    keepAspectRatio: false,
			    colorAxis: {colors: ['yellow', 'red']}
			  };
			
			  var chart = new google.visualization.GeoChart(document.getElementById('chart_div1'));
			  google.visualization.events.addListener(chart, 'select', function() {
				  var selection = chart.getSelection();
				  if (selection.length == 1) {
				  var selectedRow = selection[0].row;
				  var selectedRegion = data.getValue(selectedRow, 0);
				 		 if(magnitude[selectedRegion] != '') {
					 			 document.getElementById('chart_inf').innerHTML = magnitude[selectedRegion]; }
					  }
				  });
			  chart.draw(data, options);
			};
		}
	});
});
</script>

<body>
	<div class="panel panel-default anal-back">
		<div class="panel-heading anal-head">
	 		<h3 class="panel-title anal-title">
	 			<i class="fa fa-bar-chart-o"></i> 
	 			 지역별 지진 빈도
 			</h3>
	    </div>
	    <div class="panel-body anal-body show">
			<div class="underc" id="chart_div1" ></div>
			<div class="overt" id="chart_inf"></div> 
		</div>
	</div>
</body>
</html>