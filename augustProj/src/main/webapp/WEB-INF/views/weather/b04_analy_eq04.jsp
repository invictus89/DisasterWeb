<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<style>
.form-control{
 display: inline-block;
}
#comboChartArea{
width: 180px;
}
#comboChartYear, #comboChartDetailArea{
width: 120px;
}
</style>
<script type="text/javascript">
var selectCode ;
var selectYear ;
var shidoValue ;
var selectSize = 1;
$(document).ready(function(){
$(function(){
   var firstDefault = [['년', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]];
   comboChart2(firstDefault);
});   

$('#comboChartArea').on("change",function(){
   shidoValue = $('#comboChartArea option:selected').val();
   console.log(shidoValue);
   shidoValue2 = "shidoValue="+shidoValue;
   $.ajax({
      type:"GET",
      url: 'weatherCodeName.do',
      data : shidoValue2,
      dataType:"json",   
      async: false,   
      success:function(data){         
         var codeName = data.WeatherCodeName;
         for(a=1;a<=selectSize;a++){
            $("#comboChartDetailArea option:eq("+a+")").remove()
         }
         for(i in codeName){                         
            var str = "<option value='"+codeName[i].codenum+"'>"+codeName[i].code_name+"</option>";
            $("#comboChartDetailArea").append(str);
         }
         selectSize = $("#comboChartDetailArea option").size();
      }
   });
});


$('#sdfdsa').on("click", function(){
   selectYear = $('#comboChartYear option:selected').val();
   selectCode = $('#comboChartDetailArea option:selected').val();
   
   $.ajax({
      type:"post",
      url: 'rainForCombo.do',
      dataType:"json",
      data: {selectCode, selectYear},
      async: false,   
      success:function(data){
         var firstDefault = data.rainForCombo;
         comboChart2(firstDefault);
   }
   });
});//에이젝스
function comboChart2(firstDefault){
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(ComboChart);
      function ComboChart(){
         var data = new google.visualization.DataTable();
            data.addColumn('string', '지역');
         for(i=1;i<=12;i++){
            data.addColumn('number',i+'월');
         }
      if(firstDefault.length==1){
         data.addRows(firstDefault);
      }else{
         data.addRows([[   selectYear+'년',
                  parseInt(firstDefault[0].rainfall),
                  parseInt(firstDefault[1].rainfall),
                  parseInt(firstDefault[2].rainfall),
                  parseInt(firstDefault[3].rainfall),
                  parseInt(firstDefault[4].rainfall),
                  parseInt(firstDefault[5].rainfall),
                  parseInt(firstDefault[6].rainfall),
                  parseInt(firstDefault[7].rainfall),
                  parseInt(firstDefault[8].rainfall),
                  parseInt(firstDefault[9].rainfall),
                  parseInt(firstDefault[10].rainfall),
                  parseInt(firstDefault[11].rainfall)                  
                  ]]);   
      }
      var options = {
            title : '강수량',
            backgroundColor: {fill:'transparent',stroke:'#FFFFFF' ,strokeWidth:0 },
            height: 450,
            animation: { startup: true, duration: 2500, easing: 'out' },
            seriesType: 'bars'
             
           
            };
      var chart = new google.visualization.ComboChart(document.getElementById('combochart'));
      chart.draw(data, options);
         }
      }
});     
     
</script>

<body>
   <div class="panel panel-default anal-back">
      <div class="panel-heading anal-head">
         <h3 class="panel-title anal-title">
            <i class="fa fa-bar-chart-o"></i> 
            지역별 강수량
         </h3>
      </div>      
      <div class="panel-body anal-body show">
         <select id="comboChartArea"  class="form-control">
         <option value="first" selected="selected">시/도</option>
                  <option value="강원도">강원도</option>
                  <option value="경기도">경기도</option>
                  <option value="경상남도">경상남도</option>
                  <option value="경상북도">경상북도</option>
                  <option value="광주광역시">광주광역시</option>
                  <option value="대구광역시">대구광역시</option>
                  <option value="부산광역시">부산광역시</option>
                  <option value="서울특별시">서울특별시</option>
                  <option value="울산광역시">울산광역시</option>
                  <option value="인천광역시">인천광역시</option>                  
                  <option value="전라남도">전라남도</option>
                  <option value="전라북도">전라북도</option>
                  <option value="제주도">제주도</option>
                  <option value="충청남도">충청남도</option>
                  <option value="충청북도">충청북도</option>                     
         </select>
         <select id="comboChartDetailArea" class="form-control">
         <option value="first" selected="selected" >관측지점</option>                                      
         </select>
         <select id="comboChartYear"  class="form-control">
                  <option value="first" selected="selected" >년도 선택</option>
                    <%for(int i=1970; i<=2016; i++){ %>
                    <option value="<%=i%>"><%=i+"년"%></option>
                    <%} %>              
               </select>
         <input type="button" id="sdfdsa" class="btn" style="background-color:black; color:white;" value="검색" />
           <div id="combochart" style="position:relative;"></div>
      </div>
   </div>
</body>
</html>