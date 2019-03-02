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
//시간
$(function() {
	
 		/* var time = new Date("2017-08-06 09:12:55");
 		console.log(typeof(time.getHours())); */
 		
 		$.ajax({
 			type : 'GET',
 			url : 'getPerHour.do',
 			dataType : 'json',
 			success : function(d) {
 				jdata = d.analy;
 				var sort = "analy";
 				google.charts.load('current', {
 					'packages' : [ 'corechart' ]
 				});

 				setTimeout(function() {
 					google.charts.setOnLoadCallback(drawChart_time());
 				}, 1000);

 				
 				function drawChart_time() {
 					var data = new google.visualization.DataTable();
 					data.addColumn('number', 'HOURS');
 					data.addColumn('number', '규모 2.5 ▽');
 					data.addColumn('number', '규모 2.5 ▲ 3.5 ▼ ');
 					data.addColumn('number', '규모 3.5 △');
 					data.addRows(jdata.length);
 					for (i = 0; i < jdata.length; i++) {
 						data.setCell(i, 0, jdata[i].hour);
 						data.setCell(i, 1, jdata[i].deg1);
 						data.setCell(i, 2, jdata[i].deg2);
 						data.setCell(i, 3, jdata[i].deg3);
 					}

 					var options = {
 						height : 300,
 						color : 'white',
 						animation: { startup: true, duration: 2500, easing: 'out' },
 						crosshair:{
 							orientation:'both',
 							trigger:'both'
 						  },
 						legend:{
 							position: 'top',
							  textStyle:{
 							  	fontName:'Jeju Gothic',
 				    		    color: 'white',
 				    		    fontSize: 12,
 				    		    bold: false,
 				    		    italic: false
 							  }
 						  },
 						 lineWidth: 5,
 						  pointSize: 20,
 						  dataOpacity: 0.01,
 						backgroundColor: { fill:'transparent' },
 						chartArea:{
 							width: '50%',
 							height: '75%'
 						},
 						hAxis : {
 							title : '시간',
 							textStyle : {
 								fontName:'Jeju Gothic',
 				    		    color: 'white',
 				    		    fontSize: 11,
 				    		    bold: false,
 				    		    italic: false
 							},
 							titleTextStyle: {
 			    				fontName:'Jeju Gothic',
 				    		    color: 'white',
 				    		    fontSize: 13,
 				    		    bold: false,
 				    		    italic: true
 				    		  },
 							gridlines : {
 								color : 'lightgrey',
 								count : 9
 							},

 						},
 						vAxis : {
 							title : "빈도수",
 							textStyle : {
 								fontName:'Jeju Gothic',
 				    		    color: 'white',
 				    		    fontSize: 11,
 				    		    bold: false,
 				    		    italic: false
 							},
 							gridlines : {
 								color : 'lightgrey',
 								count : 9
 							},
 							titleTextStyle: {
 			    				fontName:'Jeju Gothic',
 				    		    color: 'white',
 				    		    fontSize: 13,
 				    		    bold: false,
 				    		    italic: true
 				    		  }
 						}
 					};

 					var chart = new google.visualization.LineChart(document
 							.getElementById('placeholder2'));
 					chart.draw(data, options);
 				}
 		
 			}
 		});
 	});
    
</script>

<body>
    <div class="panel panel-default anal-back">
	  <div class="panel-heading anal-head" >
		<h2 class="panel-title anal-title"><i class="fa fa-bar-chart-o"></i> 시간/진도별 지진 빈도 그래프</h2>
	  </div>
	  <div class="panel-body anal-body show">
		<div id="placeholder2"></div>
	  </div>
	</div> 
</body>
</html>