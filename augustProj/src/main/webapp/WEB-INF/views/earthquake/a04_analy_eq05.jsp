<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<style>

</style>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://rawgit.com/jasondavies/d3-cloud/master/build/d3.layout.cloud.js" type="text/JavaScript"></script>
<script>
$(function(){

	$(".div-btn").on("click",function(){
		$.ajax({
			type:"GET",
			url:"http://192.168.0.62:503/word",
			data:{
				"type":$("input[name=wtype]").attr("value"),
				"cnt":$(this).text()
			},
			beforeSend:function(){
				$("div.loading-div").removeClass("hide-loading");
			},
			complete: function(data){
				d = new Date();
				$("div.loading-div").addClass("hide-loading");
				$("img#wordIMG").attr("src",'http://192.168.0.62:503/wordIMG?time='+d.getTime()+'&type='+$("input[name=wtype]").attr("value"));
			}
		});
	});	
});
</script>
	<div class="panel panel-default anal-back">
		<div class="panel-heading anal-head">
			<h3 class="panel-title anal-title">
				<i class="fa fa-bar-chart-o"></i> WordCloud
			</h3>
		</div>
		<!-- div class="panel-body eq05">
		</div-->
		<div class="anal-body show word-body">
			<div class="imgdiv">
				<div class="loading-div hide-loading"></div>
				<img id="wordIMG" src="http://192.168.0.62:503/wordIMG?type=지진">
			</div>
			<div class="wordMenu">
				<div class="radio-inline div-btn">
				  100
				</div>
				<div class="radio-inline div-btn">
				  200
				</div>
				<div class="radio-inline div-btn">
				  400
				</div>
				<div class="radio-inline div-btn btn-selected">
				  800
				</div>
				<input type="hidden" name="wtype" value="지진">
			</div>
		</div>
	</div>
