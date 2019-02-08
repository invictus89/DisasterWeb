<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="UTF-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
%>
<style>
</style>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
$(function() {
	
	// 왼쪽 리스트 대피소 목록 보이도록
	 showSelectShelter();

	$("#vari_graph").hide();
	$("#settingButton").click(function() {
		$(".preferencesView").removeClass("hide-loading").addClass("show-loading");
		$("#settingButton").removeClass("show-loading").addClass("hide-loading");
	});

	$("#settingDeleteButton").on("click",function() {
		$("#settingButton").removeClass("hide-loading").addClass("show-loading");
		$(".preferencesView").removeClass("show-loading").addClass("hide-loading");
	});

	//클립버틴 누르면 디스크립션 나오게하기
	$("#descriptionButton").click(function() {
		$("#descriptionButton").removeClass("show-loading").addClass("hide-loading");
		$("#description").removeClass("hide-loading").addClass("show-loading");
	});

	//엑스표시 눌렀을 때 description사라지게하기
	$("#descripttionRemove").click(function() {
		$("#description").removeClass("show-loading").addClass("hide-loading");
		$("#descriptionButton").removeClass("hide-loading").addClass("show-loading");
	});
	
	var circle;
	var circles = [];
	var fcst_markers = [];
	$.ajax({
		type : 'GET',
		url : 'forecast.do',
		dataType : 'json',
		success : function(data) {
			var data = data.forecastEdata;
			for (var i = 0; i < data.length; i++) {
				var lat = parseFloat(data[i].lat_op);
				var lng = parseFloat(data[i].lng_op);
				
				var marker = new google.maps.Marker({
					map : map,
					position : {
						lat : lat,
						lng : lng
					},
					date : data[i].date,
					distM : data[i].month_dist,
					distD : data[i].day_dist,
					loc : data[i].loc,
					title : data[i].op_name
				});
				infoEqForecast(marker, data, i);
				fcst_markers[i] = marker;
				marker.setMap(null);
			}
		}
	}); // ajax 끝

	$('#eq_forecast_loc_btn')
			.on(
					"click",
					function() {

						for ( var i in circles) {
							circles[i].setMap(null);
						}
						circles = [];

						for (var i = 0; i < fcst_markers.length; i++) {
							fcst_markers[i].setMap(null);
						}

						if ($('#eq_forecast_loc option:selected').val() == '전체') {
							for (var i = 0; i < fcst_markers.length; i++) {
								fcst_markers[i].setMap(map);

								//drawCircles(map, fcst_markers[i], fcst_markers[i].distM, '#FF0000');
								circle = new google.maps.Circle(
										{
											strokeColor : '#FF0000',
											strokeOpacity : 1,
											strokeWeight : 0.3,
											fillColor : '#FF0000',
											fillOpacity : 0.25,
											map : map,
											center : {
												lat : fcst_markers[i].position
														.lat(),
												lng : fcst_markers[i].position
														.lng()
											},
											radius : parseFloat(fcst_markers[i].distM) * 1000
										});

								circles.push(circle);

								circle = new google.maps.Circle(
										{
											strokeColor : '#F7FE2E',
											strokeOpacity : 1,
											strokeWeight : 0.3,
											fillColor : '#F7FE2E',
											fillOpacity : 0.25,
											map : map,
											center : {
												lat : fcst_markers[i].position
														.lat(),
												lng : fcst_markers[i].position
														.lng()
											},
											radius : parseFloat(fcst_markers[i].distD) * 1000
										});

								circles.push(circle);

							}

						} else {

							for (var i = 0; i < fcst_markers.length; i++) {
								if ($('#eq_forecast_loc option:selected')
										.val() == fcst_markers[i].loc) {
									fcst_markers[i].setMap(map);

									//drawCircles(map, fcst_markers[i], fcst_markers[i].distM, '#FF0000');
									circle = new google.maps.Circle(
											{
												strokeColor : '#FF0000',
												strokeOpacity : 1,
												strokeWeight : 0.3,
												fillColor : '#FF0000',
												fillOpacity : 0.25,
												map : map,
												center : {
													lat : fcst_markers[i].position
															.lat(),
													lng : fcst_markers[i].position
															.lng()
												},
												radius : parseFloat(fcst_markers[i].distM) * 1000
											});

									circles.push(circle);

									circle = new google.maps.Circle(
											{
												strokeColor : '#F7FE2E',
												strokeOpacity : 1,
												strokeWeight : 0.3,
												fillColor : '#F7FE2E',
												fillOpacity : 0.25,
												map : map,
												center : {
													lat : fcst_markers[i].position
															.lat(),
													lng : fcst_markers[i].position
															.lng()
												},
												radius : parseFloat(fcst_markers[i].distD) * 1000
											});

									circles.push(circle);
								}
							}
						}
					});

});

function appearGraph() {
	$("#vari_graph").show();

}
function disappearGraph() {
	$("#vari_graph").hide();
}



</script>


<div id="map">
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBjfJ0rSlM7lMO19WnF8qg-joorUAod76M&callback=initMap"
		async defer></script>
</div>
<!-- 디스크립션 지웠을 때 나오게할 이모티콘 -->
<button style="z-index: 4" type="button" id="descriptionButton"
	class="btn btn-default btn-sm preferencesButton hide-loading">
	<span class="glyphicon glyphicon-paperclip"></span>
</button>

<!--  디스크립션 -->
<div id="description">
	<button type="button" id="descripttionRemove"
		class="glyphicon glyphicon-remove descriptionRemove show-loading"></button>
	<h4><span class="glyphicon glyphicon-dashboard"></span> 시계열분석을 이용한 지진 발생 위치 예측</h4>
	특정 관측소에서 지진이 발생한 위치의 거리를 계산하여 시간에 흐름에 따른 지진 발생 거리를 예측하는 모델입니다. 각 지역의 특정
	관측소 위치에서 예측된 거리를 반경으로 표시하여 반경이 겹치는 부분이 지진이 발생 시, 지진이 발생할 확률이 높은 곳으로
	예측하고 있습니다.
</div>

<!-- 톱니무늬 설정-->
<button style="z-index: 4" type="button" id="settingButton"
	class="btn btn-default btn-sm preferencesButton show-loading">
	<span class="glyphicon glyphicon-cog"></span>
</button>

<!-- 톱니무늬 클릭하면 나오는 애 -->
<div class="preferencesView hide-loading">
	<button type="button" class="glyphicon glyphicon-remove preferencesRemove" id="settingDeleteButton"></button>
	<h4><span class="glyphicon glyphicon-dashboard"></span> 거리 예측 모델</h4>
	<div style="text-align:center;">
		<select id="eq_forecast_loc">
		<option value="전체" selected="selected">시/도</option>
		<option value="전체">전체</option>
		<option value="강원" id="KR-42">강원도</option>
		<option value="경기" id="KR-41">경기도</option>
		<option value="경남" id="KR-48">경상남도</option>
		<option value="경북" id="KR-47">경상북도</option>
		<option value="광주" id="KR-29">광주광역시</option>
		<option value="대구" id="KR-27">대구광역시</option>
		<option value="대전" id="KR-30">대전광역시</option>
		<option value="부산" id="KR-26">부산광역시</option>
		<option value="서울" id="KR-11">서울특별시</option>
		<option value="울산" id="KR-31">울산광역시</option>
		<option value="인천" id="KR-28">인천광역시</option>
		<option value="전남" id="KR-46">전라남도</option>
		<option value="전북" id="KR-45">전라북도</option>
		<option value="제주" id="KR-49">제주특별자치도</option>
		<option value="충남" id="KR-44">충청남도</option>
		<option value="충북" id="KR-43">충청북도</option>
	</select>
	<button type="button" class="glyphicon glyphicon-map-marker oKbtn" id='eq_forecast_loc_btn'></button>
	</div>
	<div style="text-align:center;">
		<button type="button" class="glyphicon glyphicon glyphicon-folder-open graph-btn" onclick="appearGraph();"></button>	
		<button type="button" class="glyphicon glyphicon glyphicon-folder-close graph-btn" onclick="disappearGraph();"></button>
	</div>
</div>
<div id="vari_graph">
	<h3><span class="glyphicon glyphicon-dashboard"></span> 거리 예측 모델 변수</h4>
	
	<div class="panel-body anal-panel panel-vari">
		<img class="dash-img01" src="img/stopwatch.png"><br>
		시간
	</div>
	<div class="panel-body anal-panel panel-vari">
		<img class="dash-img01" src="img/route.png"><br>
		거리
	</div>
</div>

