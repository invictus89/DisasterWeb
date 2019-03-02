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
		var chartDiv = document.getElementById('shelter_earthcnt');

		var data = new google.visualization.DataTable();
		data.addColumn('string', 'area');
		data.addColumn('number', "대피소의 수");
		data.addColumn('number', "지진 발생 횟수");
		data.addRows([
		 	<c:forEach var="sheltercount" items="${sheltercount}" varStatus="status">
				 <c:if test="${sheltercount.area01=='강원도'||sheltercount.area01=='경기도'||sheltercount.area01=='경상남도' ||sheltercount.area01=='경상북도'||sheltercount.area01=='광주광역시'||sheltercount.area01=='대구광역시'||sheltercount.area01=='대전광역시'  ||sheltercount.area01=='부산광역시'||sheltercount.area01=='서울특별시'}">
			          ['${sheltercount.area01}',${sheltercount.count01},${earthquakecount[status.index].count02}],
			     </c:if>
			     <c:if test="${sheltercount.area01== '세종특별자치시'}">
			          ['${sheltercount.area01}', ${sheltercount.count01}, 0],
			     </c:if>
			     <c:if test="${sheltercount.area01== '울산광역시'||sheltercount.area01=='인천광역시'||sheltercount.area01=='전라남도' ||sheltercount.area01=='전라북도'||sheltercount.area01=='제주특별자치도'||sheltercount.area01=='충청남도'||sheltercount.area01=='충청북도'}">
			       	  ['${sheltercount.area01}',${sheltercount.count01},${earthquakecount[(status.index)-1].count02}],  
			 	 </c:if>          
		    </c:forEach>
		]);

		var classicOptions = {
		  is3D: true,
		  animation: { startup: true, duration: 2500, easing: 'out' },
		  height: 300,
		  backgroundColor: { fill:'transparent' },
		  lineWidth: 5,
		  pointSize: 20,
		  dataOpacity: 0.01,
		  crosshair:{
			orientation:'both',
			trigger:'both'
		  },
		  chartArea:{
				width: '75%',
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
		    		title: '대피소의 수',
		    		titleTextStyle: {
		    			fontName: 'Jeju Gothic',
		    		    color: 'white',
		    		    fontSize: 14,
		    		    bold: false,
	    		    	italic: false
		    		  }
	    		},
		    1: {
		    		title: '지진발생횟수',
	    			titleTextStyle: {
	    				fontName:'Jeju Gothic',
		    		    color: 'white',
		    		    fontSize: 14,
		    		    bold: false,
		    		    italic: false
		    		  }
		    	}
		  },
		  hAxis: {
		    ticks: ['강원','경기','경북','광주','대구','대전','부산','서울','세종','울산','인천','전남','전북','제주','충남','충북'],
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
				<i class="fa fa-bar-chart-o">
				</i> 지진 발생 별 대피소 수
			</h3>
		</div>	
		<div class="panel-body anal-body show">
			<div id="shelter_earthcnt"></div>
		</div> 	
	</div>   