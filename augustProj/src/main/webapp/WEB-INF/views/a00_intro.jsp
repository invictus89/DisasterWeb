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
    <style type="text/css">
        body{
            overflow: hidden;
        }
        .main-BG{
            width: 50%;
            height: 100%;
            position: absolute;
            margin:0;
            padding:0;
            left: 0;
            background-repeat: no-repeat !important;
            background-size:cover;
            opacity:0.5;
            transition:opacity ease-in-out 0.5s;
            cursor:pointer;
        }
        .high-layer{
            z-index:10;
            top:0%;
        }
        .bottom-layer{
            z-index:10;
            top:76%;
        }
        .main-layer{
            position:absolute;
            background: gray;
            display: inline-block;
            height: 25%;
            width: 100%;
            left: 0;
        }
        .main-div-title{
            color: white;
            font-size:3em;
            font-weight: 800;
            text-align:center;
            width:100%;
            display: inline-block;
            height: 100%;
            padding-top: 46.5%;
            opacity:0.0;
        }
        .main-div-title:hover{
            opacity:1.0;
            transition:opacity ease-in-out 0.5s;
        }
        .right-layer{
            background:url('img/weather.jpg');
            background-position: center;
            left:50%;
        }
        .left-layer{
            top:40px;
            left: 0%;
            background:url('img/earth.jpg');
            background-position:center;
        }
        
        .left-layer:hover, .right-layer:hover{
            background-size:1300px;
            opacity: 1;
            transition:opacity ease-in-out 0.5s;
        }
        
    </style>

<script>
$(function(){
   $("#earthquake").click(function(){
      $(location).attr("href","${path}/mainProc.do?leftPage=earthquake&midPage=realtime");
   });
   $("#weather").click(function(){
      $(location).attr("href","${path}/mainProc.do?leftPage=weather&midPage=wrealtime");
   });
});

</script>
<body>
   <div class="main-layer high-layer"></div>
    <div class="main-BG left-layer">
        <div class="main-div-title" id="earthquake">EARTHQUAKE</div>
    </div>
    <div class="main-BG right-layer">
        <div class="main-div-title" id="weather">WEATHER</div>
    </div>
    <div class="main-layer bottom-layer"></div>

</body>
</html>