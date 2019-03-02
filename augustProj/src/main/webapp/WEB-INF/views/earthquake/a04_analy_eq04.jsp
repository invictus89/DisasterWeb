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
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawChart_M);
});

//차트그리기(월별)
function drawChart_M() {
	var data = new google.visualization.DataTable();
	data.addColumn('string','Month');
	data.addColumn('number','빈도수');
	data.addColumn({'type': 'string', 'role': 'tooltip', 'p': {'html': true}});
	data.addRows([
		<c:forEach var="earthMonth" items="${earthMonth}">
        	['${earthMonth.eq_year}', ${earthMonth.eq_countyear}, selectHandler_Month('${earthMonth.eq_year}','${earthMonth.eq_countyear}')],
      	</c:forEach>
	]);
	var options = {
			backgroundColor:{
				fill:'transparent'
				},
           	height: 300,
           	lineWidth: 5,
 		  	pointSize: 20,
 		  	dataOpacity: 0.01,
           	curveType: 'function',
           	animation: { startup: true, duration: 2500, easing: 'out' },
           	crosshair:{
   				orientation:'both',
   				trigger:'both'
   		  	},
   			chartArea:{
				width: '90%',
				height: '80%'
			},
           	hAxis: {
  				textStyle: {
	    			fontName:'Jeju Gothic',
	  	    		color: 'white',
	  	    		fontSize: 11,
					bold: false,
					italic: false
				}
			},
  			vAxis : {
				textStyle : {
					fontName:'Jeju Gothic',
	    		    color: 'white',
	    		    fontSize: 11,
	    		    bold: false,
	    		    italic: false
				}
			},
          	legend: { 
       	   		position: 'top',
       	   		textStyle: {
  					fontName:'Jeju Gothic',
	    		    color: 'white',
	    		    fontSize: 14,
	    		    bold: false,
	    		    italic: false
    		    }
          	},
          	tooltip: {
     			isHtml: true
     		}
		};
       
	var chart = new google.visualization.LineChart(document.getElementById('m_chart'));
	chart.draw(data, options);
 }  
function selectHandler_Month(selectedMonth, cnt) {
	//에이젝스이용 표 그리기
	var show= "";
	
	$.ajax({
   		type:"post",
   		url: "${path}/clickmonth_detail.do?select_month="+selectedMonth,
		dataType:"json",
		async:false,
		success:function(fromcontroller){
			var list=fromcontroller.month_detail; // controller에 모델이름..
			show +='<div class="tooltip-title">'+selectedMonth+'월 최고 진도 지진 ('+cnt+') </div><table class="detailTbl" border="1">';
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
				<i class="fa fa-bar-chart-o"></i> 
				월별 지진 빈도
			</h3>
		</div>
		<div class="panel-body anal-body show">
		 	<div id="m_chart"></div> 
		</div>
	</div>
</body>
</html>