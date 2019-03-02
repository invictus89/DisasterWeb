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
<script type="text/javascript">
$(function(){
	google.charts.load('current', {'packages':['line', 'corechart']});
	google.charts.setOnLoadCallback(drawChart);	
	
	function drawChart() {
		console.log("graph07 - shelter_accommodate : "+ "${shelter_accommodate}");
		
		var chartDiv = document.getElementById('accommodationChart');

		var data = new google.visualization.DataTable();
		data.addColumn('string', 'area');
		data.addColumn('number', "대피소 수용인원");
		data.addColumn('number', "인구 수");
		data.addRows([
		    <c:forEach var="shelter_accommodate" items="${shelter_accommodate}" varStatus="status">
		          ['${shelter_accommodate.localName}',
		          ${shelter_accommodate.accommodate},
		          ${population[status.index]},
		          ], 
		    </c:forEach>
		]);

			var classicOptions = {
			  height: 300,
			  backgroundColor:{fill:'transparent'},
			  animation: { startup: true, duration: 2500, easing: 'out' },
			  lineWidth: 5,
			  pointSize: 20,
			  dataOpacity: 0.01,
			  crosshair:{
					orientation:'both',
					trigger:'both'
				  },
			  // Gives each series an axis that matches the vAxes number below.
			  series: {
			    0: {targetAxisIndex: 0},
			    1: {targetAxisIndex: 1}
			  },
			  chartArea:{
					width: '75%',
					height: '60%'
				},
			  vAxes: {
			    // Adds titles to each axis.
			    0: {title: '인구수',
			    	textStyle: {
	       				fontName:'Jeju Gothic',
	   	    		    color: 'white',
	   	    		    fontSize: 11,
	   	    		    bold: false,
	   	    		    italic: false
	   	    		  },
	   	    		titleTextStyle: {
		    				fontName:'Jeju Gothic',
			    		    color: 'white',
			    		    fontSize: 11,
			    		    bold: false,
			    		    italic: true
			    		  },
			    },
			    1: {title: '대피소 수용 가능 인원',
			    	textStyle: {
	       				fontName:'Jeju Gothic',
	   	    		    color: 'white',
	   	    		    fontSize: 11,
	   	    		    bold: false,
	   	    		    italic: false
	   	    		  },
	   	    		  titleTextStyle: {
		    				fontName:'Jeju Gothic',
				    		    color: 'white',
				    		    fontSize: 11,
				    		    bold: false,
				    		    italic: true
				    		  },	
			    }
			  },
			  hAxis: {
			    ticks: ['강원','경기','경남','경북','광주','대구','대전','부산','서울','세종','울산','인천','전남','전북','제주','충남','충북'],
			         textStyle: {
		       				fontName:'Jeju Gothic',
		   	    		    color: 'white',
		   	    		    fontSize: 11,
		   	    		    bold: false,
		   	    		    italic: false
		   	    		  }
			  },
			  vAxis: {
			    viewWindow: {
			     0: {max: 2000000},
			     1: {max: 5000000}
			    }
			  },
			  legend: { 
	        	   position: 'top',
	        	   textStyle: {
	   				fontName:'Jeju Gothic',
		    		    color: 'white',
		    		    fontSize: 15,
		    		    bold: false,
		    		    italic: false
		    		  }
	           }
			};
		
	
		function drawClassicChart() {
		  var classicChart = new google.visualization.LineChart(chartDiv);
		  classicChart.draw(data, classicOptions);
		}
		drawClassicChart();
	}
});

</script>

<div class="panel panel-default anal-back">
	<div class="panel-heading anal-head">
		<h3 class="panel-title anal-title">
			<i class="fa fa-bar-chart-o"></i>
			 인구수 대비 대피소 수용 가능인원
		</h3>
	</div>	
    <div class="panel-body anal-body show">
		<div id="accommodationChart"></div>
		<h6 style="color: white; font-style: italic; position: absolute; top: 13%; left: 51%; width:500px;">
			*대피소 수용 가능인원: 3.3㎡당 4명(정부 안전기준)
		</h6>
	</div>
</div>

