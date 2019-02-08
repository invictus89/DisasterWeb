<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<title>Insert title here</title>
</head>
<style>
</style>
<script src = "${path}/com/jquery-1.10.2.js"></script>

<body>
	<div class="year-container">
		<%-- <form method="post" action="${path}/getYearJson.do"> --%>
			<select id="year" name="year">
			  <option value="" selected>날짜 선택</option>		
			  <option value="2017">2017</option>
			  <option value="2016">2016</option>
			  <option value="2015">2015</option>
			  <option value="2014">2014</option>
			  <option value="2013">2013</option>
			  <option value="2012">2012</option>
			  <option value="2011">2011</option>
			  <option value="2010">2010</option>
			  <option value="2009">2009</option>
			  <option value="2008">2008</option>
			  <option value="2007">2007</option>
			  <option value="2006">2006</option>
			  <option value="2005">2005</option>
			  <option value="2004">2004</option>
			  <option value="2003">2003</option>
			  <option value="2002">2002</option>
			  <option value="2001">2001</option>
			  <option value="2000">2000</option>
			  <option value="1999">1999</option>
			  <option value="1998">1998</option>
			  <option value="1997">1997</option>
			  <option value="1996">1996</option>
			  <option value="1995">1995</option>
			  <option value="1994">1994</option>
			  <option value="1993">1993</option>
			  <option value="1992">1992</option>
			  <option value="1991">1991</option>
			  <option value="1990">1990</option>
			  <option value="1989">1989</option>
			  <option value="1988">1988</option>
			  <option value="1987">1987</option>
			  <option value="1986">1986</option>
			  <option value="1985">1985</option>
			  <option value="1984">1984</option>
			  <option value="1983">1983</option>
			  <option value="1982">1982</option>
			  <option value="1981">1981</option>
			  <option value="1980">1980</option>
			  <option value="1979">1979</option>
			  <option value="1978">1978</option>
			</select> 
		<!-- </form> -->
	</div>
</body>
</html>