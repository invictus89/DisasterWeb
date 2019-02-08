<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="UTF-8"/>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("UTF-8");
String path = request.getContextPath();
%>
<style>
</style>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
$(function() {
	
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
   
   var umbrella = "<img src='./img/umbrella.png'>";
   var hourList= [];
   var log_regList= [];
   var svmList= [];
   var RForestList= [];
   $.ajax({
      type : 'GET',
      url : 'forecastweather.do',
      dataType : 'json',
      success : function(data) {
         var data = data.forecastweatherData;
         
         for (var i = 0; i < data.length; i++) {
            
            hourList.push(data[i].hour);
   
            if (data[i].log_reg == 0) {
               log_regList.push(" ");
            } else {
               log_regList.push(umbrella);
            }
            
            if (data[i].svm == 0) {
               svmList.push(" ");
            } else {
               svmList.push(umbrella);
            }
            
            if (data[i].rforest == 0) {
               RForestList.push(" ");
            } else {
               RForestList.push(umbrella);
            }
   
            if (i == 7 || i % 8 == 7){
               if (data[i].rainMarker == 1){

                  var marker = new google.maps.Marker({
                     map : map,
                     position : {
                        lat : parseFloat(data[i].lat),
                        lng : parseFloat(data[i].lng)
                     },
                     title : data[i].loc,
                     hour : hourList, 
                     log_reg : log_regList,
                     log_reg_ac : (data[i].log_reg_ac).toFixed(2),
                     svm : svmList,
                     svm_ac : (data[i].svm_ac).toFixed(2),
                     RForest : RForestList,
                     RForest_ac : (data[i].rforest_ac).toFixed(2),
                     date : data[i].date,
                     icon :'./img/rain.png'
                  });
                  infoWeatherForecast(marker);
               } // if1문 끝
               hourList= [];
               log_regList= [];
               svmList= [];
               RForestList= [];
            }// if2문 끝
         } // for문 끝
      } // success 끝
   }); // ajax 끝   
});
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
   <h4><span class="glyphicon glyphicon-dashboard"></span> 지역별 날씨 예측 </h4>
   각 지역별  '운량, 중하운량, 기온, 이슬점 온도, 습도, 픙속' 데이터를  이용하여 해당 지역에 비가 오는지를 예측합니다.
   예측을 위한 모델로는 로지스틱 회귀, SVM, 랜덤포레스트를 이용하고 있고 정확도가 높은 모델의 결과값이 선택되어 비가 오는 지역에 표시가 됩니다.
</div>