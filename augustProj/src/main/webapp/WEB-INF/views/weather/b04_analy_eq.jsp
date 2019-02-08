<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="UTF-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
</style>
<script>
$(function(){

	//대쉬보드
	$(".panel-body.anal-panel").eq(0).append("${total_num_eq}");
	$(".panel-body.anal-panel").eq(1).append("${total_num_sh}");
	$(".panel-body.anal-panel").eq(2).append("${has_num_eq}");
	$(".panel-body.anal-panel .degree-div").eq(0).append("${max_eq}");
	$(".panel-body.anal-panel .degree-div").eq(1).append("${avg_eq}");
	$(".panel-body.anal-panel .degree-div").eq(2).append("${min_eq}");
	
});
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="page-wrapper">
 	<div class="container-fluid">
 		<div class="row">
 			<div class="col-lg-12">&nbsp;</div>
 		</div>	
 		<div class="row">
   			<div class="col-lg-3 centered">
   				<div class="panel-body anal-panel panel-dash">
   					<img src="img/calendarimg.png" style="height:240px; width:200px;"><br>
	   				  전국 평균 강수 일수 : ${rainyday}일
   				</div>
   			</div>
			<div class="col-lg-3 centered">
   				<div class="panel-body anal-panel panel-dash">
   					<img src="img/seoul_img.png" style="height:240px; width:200px;"><br>
	   				서울 강수 지수 : ${manyweather}%
   				</div>
   			</div>
 			<div class="col-lg-3 centered">
   				<div class="panel-body anal-panel panel-dash">
   					<img src="img/rain_img.png" style="height:240px; width:200px;"><br>
	   				  1회 평균 강수량 : ${avgRainAmount}mm
   				</div>
   			</div>
   			<div class="col-lg-3 centered">
   				<div class="panel-body anal-panel panel-dash">
   					<img class="dash-img01" src="img/database.png" style="height:240px; width:200px;"><br>
	   				 보유 날씨 데이터량 : ${countDataWeather }
   				</div>
   			</div>
   		</div>
 		<div class="row">
   			<div class="col-lg-12 centered">
   				<div class="panel-body anal-panel">
	   				<span class="glyphicon glyphicon-info-sign"></span>
	   				지역·연도 분석
   				</div>
   			</div>
   		</div>
 		
 		<div class="row">
			 <div class="col-lg-6">
			 	<jsp:include page="b04_analy_eq01.jsp" flush="false" />
    		</div>    		
   			<div class="col-lg-6" >
   				<jsp:include page="b04_analy_eq02.jsp" flush="false" />
   			</div>

   		</div>
   		<div class="row">
   			<div class="col-lg-6">
   				<div class="panel-body anal-panel">
			   		<jsp:include page="b04_analy_eq03.jsp" flush="false" />
   				</div>
   			</div>
   			<div class="col-lg-6">
   				<div class="panel-body anal-panel">
			   		<jsp:include page="b04_analy_eq04.jsp" flush="false" />
   				</div>
   			</div>
   		</div>
    </div>
</div>