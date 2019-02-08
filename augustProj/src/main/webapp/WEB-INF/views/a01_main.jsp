<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>재난,재해</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/icono.min.css" rel="stylesheet">
<link href="css/sb-admin.css" rel="stylesheet">
<link href="./css/example.css" rel="stylesheet" type="text/css">
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<script src = "${path}/com/jquery-1.10.2.js"></script>	
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
<script src="./js/bootstrap.js"></script>
<script src="./js/a01_myJquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.14.1/moment.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/socket.io/1.4.8/socket.io.min.js"></script>
</head>
<style>
</style>
<body>
<div id="wrapper">
	<c:choose>
		<c:when test="${leftPage eq 'earthquake' || leftPage eq null }"><jsp:include page="earthquake/a02_top.jsp"/></c:when>
		<c:when test="${leftPage eq 'weather'}"><jsp:include page="weather/b02_top.jsp"/></c:when>
	</c:choose>
	<c:choose>
		<c:when test="${midPage eq 'realtime' || midPage eq null}"><jsp:include page="earthquake/a04_realTime_eq.jsp" flush="false" /></c:when>
		<c:when test="${midPage eq 'analy'}"><jsp:include page="earthquake/a04_analy_eq.jsp" flush="false" /></c:when>
		<c:when test="${midPage eq 'pred'}"><jsp:include page="earthquake/a04_pred_eq.jsp" flush="false" /></c:when>
		<c:when test="${midPage eq 'wrealtime' }"><jsp:include page="weather/b04_realTime_eq.jsp" flush="false" /></c:when>
		<c:when test="${midPage eq 'wanaly' }"><jsp:include page="weather/b04_analy_eq.jsp" flush="false" /></c:when>
		<c:when test="${midPage eq 'wpred' }"><jsp:include page="weather/b04_pred_eq.jsp" flush="false" /></c:when>
	</c:choose>
		<c:choose>
		<c:when test = "${leftPage eq 'earthquake' || leftPage eq null }"><jsp:include page="earthquake/a03_left_eq.jsp" flush="false" /></c:when>
		<c:when test = "${leftPage eq 'weather'}"><jsp:include page="weather/b03_left_eq.jsp" flush="false" /></c:when>
	</c:choose>
</div>
</body>
</html>