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
	<div class='alert-wrapper'></div>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="navbar-header">
			<div class="banner-div">
				<a class="navbar-brand" id = "topBtn-home" href="${path}/intro.do">
					<img class="main-banner" src="img/logo.png">
				</a>
			</div>
			<div class="navbar-header-main">
				<a class="navbar-brand top-Menu" href="${path}/mainProc.do?leftPage=weather&midPage=wrealtime">실시간</a>
	       		<a class="navbar-brand top-Menu" href="${path}/mainProc.do?leftPage=weather&midPage=wanaly">통합 분석</a>
				<a class="navbar-brand top-Menu" href="${path}/mainProc.do?leftPage=weather&midPage=wpred">예측</a>
			</div>
			<div class="ui-onoff">
				<div>
					<span class="glyphicon glyphicon-stop"></span> Twitter
				</div>
				<div>
					<span class="glyphicon glyphicon-stop"></span> Web
				</div>
				<div>
					<span class="glyphicon glyphicon-stop"></span> News
				</div>
				<div>
					<span class="glyphicon glyphicon-stop"></span> Naver
				</div>
			</div>
			<div class="ui-keyword">
				<a class="dropdown dropdown-btn real-drop">
					<span class="n-icon dash-ico">N</span>
					실시간 검색어
				</a>
				<ul class="dropdown-menu" id="myDropdowon-naver">
				</ul>
			</div>
			<div class="current-clock"></div>
		</div>
	</nav>