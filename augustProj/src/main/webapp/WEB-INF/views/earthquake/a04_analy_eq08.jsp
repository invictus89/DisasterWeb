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
	google.charts.load('current', {'packages': ['corechart']});
	function drawChart() {
		var data = new google.visualization.DataTable();
		data.addColumn('string', '지역');
		data.addColumn('number', '대피소 갯수');
		
		<c:forEach var="earthquakecount" items="${earthquakecount}">
		data.addRows([['${earthquakecount.area02}', ${earthquakecount.count02}]]);
		</c:forEach>
// 		for(i=0; i<=17; i++){
// 			data.addRows([[earthquakeCountArray.earthquakecount[i].area, earthquakeCountArray.earthquakecount[i].count]]);
// 			console.log(earthquakeCountArray.earthquakecount[i].area, earthquakeCountArray.earthquakecount[i].count);
// 			}
		var options = {
				height: 300,
				animation: { startup: true, duration: 2500, easing: 'out' },
				backgroundColor: { 
					fill:'transparent'
					},
				titleTextStyle : {
					fontSize : 15
					},
				legend :{
					position : 'labeled',
					textStyle : {
						fontSize : 12,
						color: 'white',
						bold : true
						}
					},
				is3D: true,
				chartArea:{
					width: '70%',
					height: '60%'
					},
				fontSize : null,
				slices: {
					0: {offset: 0.2},//강원
					1: {offset: 0.2},//경기
					3: {offset: 0.2},//경남
					5: {offset: 0.7},//광주
					6: {offset: 0.6},//대구
					7: {offset: 0.5},//대전
					8: {offset: 0.4},//부산
					10: {offset: 0.4},//서울
					11: {offset: 0.6},//울산
					14: {offset: 0.2},//전북
					15: {offset: 0.4},//제주
					17: {offset: 0.2}//충북
					},
				tooltip : {
					text : 'value'
					}
				};
		var chart = new google.visualization.PieChart(document.getElementById('chartDiv1'));
		chart.draw(data, options);
	}
	google.charts.setOnLoadCallback(drawChart);
});
</script>

<div class="panel panel-default anal-back">
	<div class="panel-heading anal-head">
		<h3 class="panel-title anal-title">
			<i class="fa fa-bar-chart-o"></i>
			지역별 지진 비율
		</h3>
	</div>	
    <div class="panel-body anal-body show">
		<div id="chartDiv1"></div>
	</div>
</div>

