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
<script type="text/javascript">
$(function(){
	var firstinput = [[" ", 0]];
	drawChart2(firstinput);
});
	//정보 받아왔을 때 에이젝스로 표그려주기
	
function weatherMonthSelect(){
	var selectYearAndMonth= weather_yearSelect.value+"-"+weather_monthSelect.value;
	var selectLocal = weather_locationSelect.value;
	$.ajax({
    type:"post",
	url: "${path}/weatherMonthSelect.do?selectYearAndMonth="+selectYearAndMonth+"&selectLocal="+selectLocal,
	dataType:"json",
	data:'',
	async: false,
	error:function(request,status,error){alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); },
	success:function(data){
	
	firstinput = data.detailweatherMonth;
	drawChart2(firstinput);
			}
		});
	}
	

function drawChart2(firstinput) {
		google.charts.load('current', {'packages':['corechart']});
	    google.charts.setOnLoadCallback(drawChart);
	    function drawChart(){
			var googleData = new google.visualization.DataTable();
			if(firstinput.length==1){
				googleData.addColumn('string','지역명');
				googleData.addColumn('number','강수량');
				googleData.addRows(firstinput);
			}
			else{
				googleData.addColumn('string','지역명');
				googleData.addColumn('number','강수량');
					for(var idx=0;idx<firstinput.length;idx++){
					googleData.addRows([[firstinput[idx].code_name,parseInt(firstinput[idx].rainfall)]]);
					}	
			}
	        var options = {
	          title: '',
	          backgroundColor:{fill:'transparent'},
	          height: 450,
	          lineWidth: 6,
			  pointSize: 20,
			  animation: { startup: true, duration: 2500, easing: 'out' },
			  dataOpacity: 0.01,
	          curveType: 'function',
	          crosshair:{
	     			orientation:'both',
	     			trigger:'both'
	     	},
	     	chartArea:{
	     		width: '92%',
	     		height: '85%'
	     	},
	     	 hAxis: {
					textStyle: {
	   				fontName:'Jeju Gothic',
		    		    color: 'white',
		    		    fontSize: 15,
		    		    bold: false,
		    		    italic: false
		    		  }
			  },
			vAxis : {
					textStyle : {
						fontName:'Jeju Gothic',
		    		    color: 'white',
		    		    fontSize: 15,
		    		    bold: false,
		    		    italic: false
					}
				},
			legend: { 
			       	position: 'top',
			       	   textStyle: {
			  				fontName:'Jeju Gothic',
				    		color: 'white',
				    		fontSize: 20,
				    		bold: false,
				    		italic: false
			       	   }
			}		
	       };

	 var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
	     chart.draw(googleData, options);
	    }

	}
</script>
</head>


<body>
	<div class="panel panel-default anal-back">
		<div class="panel-heading anal-head">
			<h3 class="panel-title anal-title">
				<i class="fa fa-bar-chart-o"></i> 
				지역별 연도,월  강수량
			</h3>
		</div>
		
		<div class="panel-body anal-body show">
			<div>
				<select class="form-control" id="weather_yearSelect" style=" width:120px; display: inline-block;">
		            <option value="1970" selected="selected" >연도 선택</option>
		           	<%for(int i=1970; i<=2016; i++){ %>
		           	<option value="<%=i%>"><%=i+"년"%></option>
		           	<%} %>              
	            </select>
	            <select class="form-control" id="weather_monthSelect" style="width:120px; display: inline-block;">
		            <option value="1" selected="selected">월 선택</option>
		           	<%for(int i=1; i<=12; i++){ %>
		           	<option value="<%=i%>"><%=i+"월"%></option>
		           	<%} %>              
	            </select>
				<select class="form-control" id="weather_locationSelect" style=" width:180px; display: inline-block;">
		            <option value="강원도" selected="selected">시/도</option>
		            <option value="강원도">강원도</option>
		            <option value="경기도">경기도</option>
		            <option value="경상남도">경상남도</option>
		            <option value="경상북도">경상북도</option>
		            <option value="광역시">특별·광역시</option>
		            <option value="전라남도">전라남도</option>
		            <option value="전라북도">전라북도</option>
		            <option value="제주도">제주특별자치도</option>
		            <option value="충청남도">충청남도</option>
		            <option value="충청북도">충청북도</option>	                
	            </select>
	                <input type="button" class="btn" style="background-color:black; color:white;" value="검색" onclick="weatherMonthSelect()"/>
		 	</div>
		 	<div id="curve_chart" ></div> 
		</div>
	</div>
</body>
</html>