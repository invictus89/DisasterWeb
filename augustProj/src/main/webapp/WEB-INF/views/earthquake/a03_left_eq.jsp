<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="UTF-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="./js/tagcloud.js"></script>

<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
%>
<script>
	function tagCloud(_url) {
		$.ajax({
			type : 'GET',
			url : _url,
			dataType : 'json',
			data : {
				"type" : 1
			},
			success : function(d) {
				var tag_li = "";
				var x = 0;
				for (var i = 0; i < d.length; i++) {
						tag_li += "<li><a id='tag" + x
								+ "' href='javascript:void(0)' data-weight='"
								+ d[i].frequency + "'>" + d[i].text
								+ "</a></li>";
						x++;
				}
				$("#tags").append("<ul>" + tag_li + "</ul>").css("display","none");

				$('#myCanvas').tagcanvas({
					textFont : 'Arial, Helvetica, sans-serif',
					reverse : true,
					hideTags: true,
					wheelZoom : false,
					shadowBlur : 2,
					shadowOffset : [ 1, 1 ],
					stretchX : 1.2,
					minBrightness : 0.2,
					textHeight: 20,
					initial : [ 0, 0.1 ],
					depth : 0.8,
					maxSpeed : 0.04,
					minSpeed : 0.01,
					weight: true,
					weightFrom:"data-weight",
					weightMode: "colour",
					weightGradient: { 0: "#f00", 0.6: "#ff0", 1: "#ffccff" },
					clickToFront : 600
				}, 'tags');

			}
		});
	}
	tagCloud("./js/test.json");
</script>
<div class="collapse navbar-collapse navbar-ex1-collapse">
	<ul class="nav navbar-nav side-nav">
		<li class="dropdown">
			<a class="dropdown-btn zero">
				<span class="glyphicon glyphicon-info-sign dash-ico"></span>
				Recently OFFICIAL
				<div class="offi-cnt"><u>@기상청</u></div>
			</a>
			<ul class="dropdown-menu offi-dropdown show" id="myDropdowon-offi">
			</ul>
		</li>
		<li class="dropdown">
			<a class="dropdown-btn first">
				<span class="glyphicon glyphicon-eye-open dash-ico"></span>
				Realtime NOTICE
				<div class="noti-cnt"></div>
				<b class="glyphicon glyphicon-chevron-down"></b>
			</a>
			<ul class="dropdown-menu alert-dropdown" id="myDropdowon-alert">
				<ul>
					<center>
					</center>
				</ul>
			</ul>
		</li>
		<li class="dropdown">
			<a class="dropdown-btn second">
				<span class="glyphicon glyphicon-flag dash-ico"></span>
				SHELTERS
				<div class="sht-cnt"></div>
				<b class="glyphicon glyphicon-chevron-down"></b>
			</a>
			<ul class="dropdown-menu sht-dropdown" id="myDropdowon-shelter">
			</ul>
		</li>
		<li class="dropdown">
			<a class="dropdown-btn fourth">
				<span class="fa fa-twitter dash-ico"></span>
				TWITTER
				<div class="twit-cnt"></div>
				<b class="glyphicon glyphicon-chevron-down"></b>
			</a>
			<ul class="dropdown-menu twit-dropdown" id="myDropdowon-twit">
			</ul>
		</li>
		<li class="dropdown">
			<a class="dropdown-btn third">
				<span class="glyphicon glyphicon-cloud dash-ico"></span>
				TAG CLOUD
				<div class="word-cnt"></div>
				<b class="glyphicon glyphicon-chevron-down"></b>
			</a>
			<ul class="dropdown-menu word-dropdown" id="myDropdowon-word">
				<div id="myCanvasContainer">
					<canvas width="240px" height="200px" id="myCanvas">
					<p>Anything in here will be replaced on browsers that support the canvas element</p>
					</canvas>
				</div>
				<div id="tags"></div>
			</ul>
		</li>
	</ul>
</div>