<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 -->
<script type="text/javascript">
//테이블 그리기(연도)

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart_Y);

//차트그리기(년도별)
function drawChart_Y() {
	var data = new google.visualization.DataTable();
	data.addColumn('string','Year');
	data.addColumn('number','빈도수');
	data.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	data.addRows([
		<c:forEach var="earthYear" items="${earthYear}">
        	['${earthYear.eq_year}', ${earthYear.eq_countyear}, selectHandler_Year('${earthYear.eq_year}','${earthYear.eq_countyear}')],
      	</c:forEach>
	]);
	var options = {
			height: 400,
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
        		textStyle: {
   					fontName:'Jeju Gothic',
    		    	color: 'white',
    		    	fontSize: 12,
    		    	bold: false,
    		    	italic: false
   		  			}
        		},
			vAxis : {
				textStyle : {
					fontName:'Jeju Gothic',
 		    		color: 'white',
  		    		fontSize: 12,
  		    		bold: false,
  		    		italic: false
					}
        		},
			chartArea:{
				width: '90%',
				height: '75%'
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
       			},
     		tooltip: {
     			isHtml: true
     			}
      		};
	var chart = new google.visualization.LineChart(document.getElementById('y_chart'));
	chart.draw(data, options);
 }
function selectHandler_Year(selectedYear, cnt) {
	//에이젝스이용 표 그리기
	var show= "";
	
	$.ajax({
   		type:"post",
		url: "${path}/clickYear_detail.do?select_year="+selectedYear,
		dataType:"json",
		async:false,
		success:function(fromcontroller){
			var list=fromcontroller.year_detail; // controller에 모델이름..
			show +='<div class="tooltip-title">'+selectedYear+'년도 최고 진도 지진 ('+cnt+') </div><table class="detailTbl" border="1">';
			show +='<tr><th style="height:20px; width:35px;">순서</th><th style="width:130px;">발생 시간</th><th>발생 장소</th><th style="width:35px;">진도</th></tr>';
			
			for(var idx=0;idx<list.length;idx++)
				show +='<tr><td>'+(idx+1)+'</td><td>'+list[idx].time+'</td><td>'+list[idx].title+'</td><td>'+list[idx].degree+'</td></tr>';
			show +='</table>';
		}	
	});
	return show;
}
</script>

<body>
	<div class="panel panel-default anal-back">
		<div class="panel-heading anal-head">
			<h3 class="panel-title anal-title">
				<i class="fa fa-bar-chart-o"></i> 연도별 지진 빈도
			</h3>
		</div>
		<div class="panel-body anal-body show">
			<div id="y_chart"></div>
		</div>
	</div>
</body>
</html>