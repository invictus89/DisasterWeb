<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="UTF-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
/* .show { 
	display:block;
	}
.anal-body {
	display:none;
} */
</style>
<script>
$(function(){

	/*
	* @brief 분석 페이지에서도 왼쪽 리스트 대피소 목록 보이도록
	*/
	$.ajax({
		type : 'GET',
		url : 'getShelterJson.do',
		dataType : 'json',
		success : function(d) {
			var data = d.shelter;
			selectShelter(data, data.length);
		}
	});
	
	/*
	* @brief 통합분석 탭 -> 각 heading click시 toggle 적용
	*/
	 $(".panel-heading").each(function(index){	
		$(this).click(function(){
			document.getElementsByClassName("anal-body")[index].classList.toggle('show');
		});
	});	
	
	/*
	* @brief 통합분석 탭 -> 각 heading click시 toggle 적용
	*/
	/* $("button").click(function(){
		if($(this).hasClass("turn-on"))
			$(".anal-back").css("opacity",1);
		if($(this).hasClass("turn-off"))	
			$(".anal-back").css("opacity",0.5);
	});	 */
	
	//DASHBOARD
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
   			<div class="col-lg-2 centered">
   				<div class="panel-body anal-panel panel-dash">
   					<img class="dash-img01" src="img/pulse-line.png"><br>
	   				총 지진 횟수 :
   				</div>
   			</div>
			<div class="col-lg-2 centered">
   				<div class="panel-body anal-panel panel-dash">
   					<img class="dash-img01" src="img/emergency-exit.png"><br>
	   				총 대피소 갯수 :
   				</div>
   			</div>
 			<div class="col-lg-2 centered">
   				<div class="panel-body anal-panel panel-dash">
   				<img class="dash-img01" src="img/database.png"><br>
	   				보유 지진 데이터량 :
   				</div>
   			</div>
   			<div class="col-lg-2 centered">
   				<div class="panel-body anal-panel panel-dash">
   					<div class="degree-div red"></div> 
	   				최고 진도
   				</div>
   			</div>
   			<div class="col-lg-2 centered">
   				<div class="panel-body anal-panel panel-dash">
   					<div class="degree-div green"></div> 
	   				평균 진도 
   				</div>
   			</div>
   			<div class="col-lg-2 centered">
   				<div class="panel-body anal-panel panel-dash">
   					<div class="degree-div blue"></div>
	   				최소 진도 
   				</div>
   			</div>
   		</div>
   		<div class="row">
   			<div class="col-lg-12 centered">
   				<div class="panel-body anal-panel">
	   				<span class="glyphicon glyphicon-info-sign"></span>
	   				지역 기준 분석
   				</div>
   			</div>
   		</div>
 		<div class="row">
			 <div class="col-lg-3">
			 	<jsp:include page="a04_analy_eq05.jsp" flush="false" />
    		</div>    		
   			<div class="col-lg-5" >
   			 	<jsp:include page="a04_analy_eq02.jsp" flush="false" />
   			</div>
   			<div class="col-lg-4" >
   			 	<jsp:include page="a04_analy_eq08.jsp" flush="false" />
   			</div>
   		</div>
   		<div class="row">
   			<div class="col-lg-12 centered">
   				<div class="panel-body anal-panel">
	   				<span class="glyphicon glyphicon-info-sign"></span>
	   				시간 기준 분석
   				</div>
   			</div>
   		</div>
		<div class="row">
			 <div class="col-lg-4">
			 	<jsp:include page="a04_analy_eq03.jsp" flush="false" />
    		</div>    		
   			 <div class="col-lg-4" >
   			 	<jsp:include page="a04_analy_eq04.jsp" flush="false" />	
   			</div>
   			<div class="col-lg-4">
			 	<jsp:include page="a04_analy_eq01.jsp" flush="false" />
    		</div>    		  
   		</div>
   		<div class="row">
   			<div class="col-lg-12 centered">
   				<div class="panel-body anal-panel">
   					<span class="glyphicon glyphicon-info-sign"></span>
   					대피소 기준 분석
   				</div>
   			</div>
   		</div> 
   		<div class="row">
			<div class="col-lg-6" >
   			 	<jsp:include page="a04_analy_eq06.jsp" flush="false" />	
   			</div>
			 <div class="col-lg-6">
			 	<jsp:include page="a04_analy_eq07.jsp" flush="false" />
    		</div>
   		</div>
    </div>
</div>