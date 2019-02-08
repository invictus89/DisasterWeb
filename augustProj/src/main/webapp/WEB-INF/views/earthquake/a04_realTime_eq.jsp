<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="UTF-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
$(function(){
	var clusterStyles=[
		 {
			 url : './img/s1.png',
			 height : 26,
			 width : 26,
			
		 },
		 {
			 url : './img/s2.png',
			 height : 38,
			 width : 38,
		 },
		 {
			 url : './img/s3.png',
			 height : 49,
			 width : 49,
			
		 },
		 {
			 url : './img/s4.png',
			 height : 61,
			 width : 61,
			
		 },
		 {
			 url : './img/s5.png',
			 height : 73,
			 width : 73,
			
		 }
	];
	var mcOptions = {
	         gridSize : 100,
	         styles : clusterStyles,
	         maxZoom : 15
	  };
	
	$("#year").change(function(){
		var year = $("#year option:selected").val();
		makerToMapOnYear(year, mcOptions);
	});
	
	$.ajax({
		type:'get',
		url : 'getMapJsonCurrent.do',
		dataType : 'json',
		success : function(d){
			var realEq = d.realEq_ctrl;
			console.log(realEq);
			for(var i=0; i<realEq.length; i++){
		            var marker = new google.maps.Marker({
	            	  position : {
							lat : parseFloat(realEq[i].lat),
							lng : parseFloat(realEq[i].lng)
	            	  },
		               map : map,
		               icon : './img/placeholder_current.png'
		            });
		            $(marker).data("URI", realEq[i].url);
		            $(marker).data("TAG", realEq[i].tag);
		            markers_current[i] = marker;
		            showInfor(marker, realEq[i].title, realEq[i].degree, realEq[i].time, realEq[i].tag);
			}
		
		}
	});
	
$.ajax({
		type : 'GET',
		url : 'getShelterJson.do',
		dataType : 'json',
		success : function(d) {
			var data = d.shelter;
			console.log(data);
			try{
				for (var i = 0; i < data.length; i++) {
					var lng01 = parseFloat(data[i].lng);
					var lat01 = parseFloat(data[i].lat);
					// 마커찍어줌
					var marker = new google.maps.Marker(
							{
								map : map,
								position : {
									lat : lat01,
									lng : lng01
								},
								name : data[i].name,
								address : data[i].address,
								area : data[i].area,
								firstAdd : data[i].firstAdd,
								secondAdd : data[i].secondAdd,
								icon : "./img/placeholder_shelter.png"
							});
					showInfor2(marker, data, i);
					markers[i] = marker;
				}	
			}
			finally{
				// for문으로 모인 markercluster
				 markerCluster = new MarkerClusterer(map,markers, mcOptions);
			}
			selectShelter(data, data.length);
			
			google.maps.event.addListener(map, 'zoom_changed', function() {
			    startLat = pixelToLatlng(0,$('#map').height()).lat();
			    startLng = pixelToLatlng(0,$('#map').height()).lng();
			    endLat = pixelToLatlng($('#map').width(),0).lat();
			    endLng = pixelToLatlng($('#map').width(),0).lng();
				
			    viewMarkerOnEvent(map, data.length);
			});
			google.maps.event.addListener(map, 'dragend', function() {
			    startLat = pixelToLatlng(0,$('#map').height()).lat();
			    startLng = pixelToLatlng(0,$('#map').height()).lng();
			    endLat = pixelToLatlng($('#map').width(),0).lat();
			    endLng = pixelToLatlng($('#map').width(),0).lng();

				viewMarkerOnEvent(map, data.length);
			    markerCluster = new MarkerClusterer(map,markers, mcOptions);

			});
		}
	}); 
	
 	$(".buttonShowGraph").click(function(){
		$(".hideShow").animate({
			height:["toggle","swing"]
		},1000);
		if(checkValue==0){
			$(".buttonShowGraph").animate({
				bottom:'25px'
			},1000);
			$(".buttonShowGraph").html("Show Graph");
			checkValue=1;
		}else{
			$(".buttonShowGraph").animate({
				bottom:'275px'
			},1000);
			$(".buttonShowGraph").html("Hide Graph");
			checkValue=0;
		}
	});
 	$(".preferencesButton").click(function(){
		$(".preferencesView").animate({
			height:["toggle","swing"]
		},1000);
		$(".preferencesButton").css('display','none');
	});
	$(".preferencesRemove").click(function(){
		$(".preferencesView").animate({
			height:["toggle","swing"]
		},1000);
		$(".preferencesButton").css('display','block');
		$(".preferencesButton").delay(1000).css('display','block');
	});
});

</script>

	<jsp:include page="a05_realTimeYear.jsp" flush="false" />
	<div id="map">
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBjfJ0rSlM7lMO19WnF8qg-joorUAod76M&callback=initMap" async defer></script>
	</div>
	<button class="buttonShowGraph">Graph</button>
	<div class="hideShow">
		<div id="placeholder"></div>
	</div>
	