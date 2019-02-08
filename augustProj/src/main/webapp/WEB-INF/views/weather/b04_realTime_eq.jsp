<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="UTF-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>

var weatherMarkers = [];
var wMarker=[];

$(function(){

	var yearForWeather = 0;
	var monthForWeather = 0;
	var yearAndMonth = 0;
	
	$("#settingButton").click(function() {
		$(".preferencesView").removeClass("hide-loading").addClass("show-loading");
		$("#settingButton").removeClass("show-loading").addClass("hide-loading");
	});

	$("#settingDeleteButton").on("click",function() {
		$("#settingButton").removeClass("hide-loading").addClass("show-loading");
		$(".preferencesView").removeClass("show-loading").addClass("hide-loading");
	});
	
	$(".eq_loc.year").on("change",function(){
		yearForWeather = $(".eq_loc.year option:selected").val();
	});
	$(".eq_loc.month").on("change",function(){
		monthForWeather = $(".eq_loc.month option:selected").val();
	});
	$("#eq_loc_btn").on("click",function(){
		if(yearForWeather != "" && monthForWeather != ""){
			if(wMarker.length!=0){
	      		for(var i = 0; i<wMarker.length;i++){
	      			wMarker[i].setMap(null);
	      			weatherMarkers[i].setMap(null);
      			}
			}
		}else{
			alert("날짜를 정확히 선택해주세요");
		}
      	wMarker=[];
      	weatherMarkers=[];
      	console.log(wMarker);
		console.log(weatherMarkers);
		yearAndMonth = yearForWeather + "." + monthForWeather;
		console.log(yearAndMonth);
		var weatherFordate = "weatherFordate="+yearAndMonth;
		console.log(weatherFordate);
		$.ajax({
			type : 'GET',
			url : 'weatherRealTIme.do',
			data : weatherFordate,			
			dataType : 'json',
			success : function(weather) {
				console.log(weather.weatherRealTIme);
				var weather = weather.weatherRealTIme;
				try{
					for (var i = 0; i < weather.length; i++) {
						var lng01 = parseFloat(weather[i].lng);
						var lat01 = parseFloat(weather[i].lat);						
						wMarker = new google.maps.Marker({
									map : map,
									position : {
										lat : lat01,
										lng : lng01
									},
									location : weather[i].location,
									date : weather[i].date,
									cloud_1 : weather[i].cloud_1,
									cloud_2 : weather[i].cloud_2,
									dew : weather[i].dew,
									hum : weather[i].hum,
									pre : weather[i].pre,
									snow : weather[i].snow,
									temper : weather[i].temper,
									wind : weather[i].wind,
									sumpre : weather[i].sumpre,
									visible : true,
									icon: './img/rain.png'
								});
						showInForWeather(wMarker);
						weatherMarkers[i] = wMarker;
					}					
				}			
				finally{
// 					var markerCluster = new MarkerClusterer(map, weatherMarkers,
// 							{
// 								imagePath : 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
// 							}
// 					);
				}				
				google.maps.event.addListener(map, 'zoom_changed', function() {
				    startLat = pixelToLatlng(0,$('#map').height()).lat();
				    startLng = pixelToLatlng(0,$('#map').height()).lng();
				    endLat = pixelToLatlng($('#map').width(),0).lat();
				    endLng = pixelToLatlng($('#map').width(),0).lng();
					
				    viewMarkerOnEvent(map, weather.length);
				});
				google.maps.event.addListener(map, 'dragend', function() {
				    startLat = pixelToLatlng(0,$('#map').height()).lat();
				    startLng = pixelToLatlng(0,$('#map').height()).lng();
				    endLat = pixelToLatlng($('#map').width(),0).lat();
				    endLng = pixelToLatlng($('#map').width(),0).lng();

					viewMarkerOnEvent(map, weather.length);
				});
			}
		}); 
	});
	
	function showInForWeather(wMarker) {		
		var infowindow = new google.maps.InfoWindow({
			content : '<div class="weatherInfRain">'+	
					  '<div>'+
					  '월 누적 강수량: '+wMarker.sumpre+					 
					  '</div>'+	
					  '</div>'			
		});
		wMarker.addListener('mouseover', function() {
			infowindow.open(map, wMarker);
		});
		wMarker.addListener('mouseout', function() {
			infowindow.close(map, wMarker);
		});
	}
});
</script>
	<div id="map">
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBjfJ0rSlM7lMO19WnF8qg-joorUAod76M&callback=initMap" async defer></script>
	</div>
	<button style="z-index:4" type="button" id="settingButton" class="btn btn-default btn-sm preferencesButton show-loading">
		<span class="glyphicon glyphicon-cog"></span>
	</button>
	<div class="preferencesView hide-loading eq">
		<h4><span class="glyphicon glyphicon-dashboard"></span> 실시간 날씨 현황 </h4>
		<button type="button" id="settingDeleteButton" class="glyphicon glyphicon-remove preferencesRemove"></button>
		<div class="preferencesView3">
		<select class="eq_loc year">
			<option value="" selected="selected">년도</option>
			<option value="2017">2017</option>		          						
			<option value="2016">2016</option>		          						
			<option value="2015">2015</option>		          						
		</select>
		<select class="eq_loc month">
			<option value="" selected="selected">월</option>
			<option value="01">01</option>		    		          						
			<option value="02">02</option>		    		          						
			<option value="03">03</option>		    		          						
			<option value="04">04</option>		    		          						
			<option value="05">05</option>		    		          						
			<option value="06">06</option>		    		          						
			<option value="07">07</option>		    		          						
			<option value="08">08</option>		    		          						
			<option value="09">09</option>		    		          						
			<option value="10">10</option>		    		          						
			<option value="11">11</option>		    		          						
			<option value="12">12</option>						
		</select>
		<button type="button" class="glyphicon glyphicon-map-marker oKbtn" id='eq_loc_btn'></button>
		</div>		
	</div>
	<div class="hideShow">
		<div id="placeholder"></div>
	</div>