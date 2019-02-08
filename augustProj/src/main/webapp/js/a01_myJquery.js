var map;
	var markerCluster_past;
var markerCluster;
var geocoder;
var markers = [];
var show = "";
var checkValue = 0;
var preferenceValue= 0;
var markers_past = [];
var markers_current = [];

$(function() {
	selectNotification();
		/**
		 * @name 소켓 통신
		 * @date 2017/07/21
		 * @modify
		 * @brief 소켓 통신을 통한 알림 창 받아오기
		 * @param
		 */
	 var sock = io.connect('http://192.168.0.62:503');
			sock.on('notification',function(notice){
				console.log(notice);
				selectNotification();
				
				//중앙 알림창
				alertNotification(notice);
				
				//왼쪽 메뉴 알림
				$("#tags > ul").remove();
				var tag_li = ""
				for(key in notice.wordcloud){
					for(i = 0; i < parseInt(notice.wordcloud[key]); i++)
						tag_li += "<li><a class='tag-li' href='javascript:void(0)' data-weight='"+notice.wordcloud[key]+"'>"+key+"</a></li>";
				}			 
				$("#tags").append("<ul>"+tag_li+"</ul>").css("display","none");
				
				//태그 클라우드 리로드
				$('#myCanvas').tagcanvas("reload");
			});
			
			sock.on('twitter',function(twit){
				selectTwitter(twit);
			});
			
			sock.on('official',function(data){
				selectOfficial(data);
			}); 
			sock.on('News',function(a){
				 console.log(a);
			});	
			sock.on('Key',function(n){
				keyword(n);
			});	
			sock.on('condition',function(n){
				var onClass = "glyphicon-play";
				var offClass = "glyphicon-stop";
				
				$(".ui-onoff").children().each(function(i, e){
					if(i == 0){
						if(n.twit == "on")
							$(e).children().removeClass(offClass).addClass(onClass);
						else
							$(e).children().removeClass(onClass).addClass(offClass);
					}
					else if(i == 1){
						if(n.web == "on")
							$(e).children().removeClass(offClass).addClass(onClass);
						else
							$(e).children().removeClass(onClass).addClass(offClass);
					}
					else if(i == 2){
						if(n.news == "on")
							$(e).children().removeClass(offClass).addClass(onClass);
						else
							$(e).children().removeClass(onClass).addClass(offClass);
					}
					else if(i == 3){
						if(n.key == "on")
							$(e).children().removeClass(offClass).addClass(onClass);
						else
							$(e).children().removeClass(onClass).addClass(offClass);
					}
				});
			});	
	
	  $("body").css("overflow","hidden");
	  
	  $("#tags > ul > li > a").click(function(){
			$('#myCanvas').tagcanvas("tagtofront", {id : $(this).attr("id"), active:1});
		});
	  
	  $(".dropdown-btn").click(function(){
		 if($(this).hasClass("first")){
			 document.getElementById("myDropdowon-alert").classList.toggle("show");
		 } 
		 if($(this).hasClass("second")){
			 document.getElementById("myDropdowon-shelter").classList.toggle("show");	
		 } 
		 if($(this).hasClass("third")){
			 document.getElementById("myDropdowon-word").classList.toggle("show");	
		 }
		 if($(this).hasClass("fourth")){
			 document.getElementById("myDropdowon-twit").classList.toggle("show");	
		 }
	  });
	  
	  $(".real-drop, #myDropdowon-naver").on("mouseover",function(){
		  $("#myDropdowon-naver").slideDown();
	  });
	  $("#myDropdowon-naver").on("mouseleave",function(){
		  $("#myDropdowon-naver").slideUp();
	  });
	  
	  $(".div-btn").on("click",function(){
		  $(".div-btn").each(function(){
			  $(this).removeClass("btn-selected");
		  });
		  $(this).addClass("btn-selected");
	  });
	  
	$(".a-alarm").click(function() {
				$(".dropdown-menu.alert-dropdown > ul").children().css("display", "none");
			});
	var mapCall = $("#mapCall").val();
	
	// 시계
	setInterval(function(){
		setTimeout("printClock()",0);
	},1000);

});

function alertNotification(_txtJSON){
	if(_txtJSON.percentage >= 50) className = "label-danger";
	else if(_txtJSON.percentage < 50 && _txtJSON.percentage >= 30) className = "label-warning";
	else if(_txtJSON.percentage < 30) className = "label-info";

	txt =  "<div class='alert emer_alarm'>"
	txt +=  "<span class='alrt-label label "+className+"'><span class='glyphicon glyphicon-alert'></span></span> ";
	txt += "["+_txtJSON.time+"] "+_txtJSON.type+" "+_txtJSON.message;
    txt += " <span class='alrt-label label "+className+"'><span class='glyphicon glyphicon-alert'></span></span></div>";
	
	$("div.alert-wrapper").prepend(txt);
	$("div.emer_alarm").fadeIn(500).delay(3000).fadeOut(500,function(){ $(this).remove(); });
}
function selectNotification(){
	$.ajax({
		type : 'GET',
		url : 'getNoticeJson.do',
		dataType : 'json',
		success : function(d) {
			$(".dropdown-menu.alert-dropdown > ul > center").html("");
			data = d.notice;
			$(".noti-cnt").html(data.length+"건");
			for (var i = 0; i < data.length; i++) {
				if(data[i].percentage >= 50) className = "label-danger";
				else if(data[i].percentage < 50 && data[i].percentage >= 30) className = "label-warning";
				else if(data[i].percentage < 30) className = "label-info";
				
				show_ul = "<li class='lnfNotiName' style='text-align:left'><table style='margin:0px 7px; width:90%;'>"
					 + "<tr><td rowspan='2' style='width:50px;'><span class='label "+className+"'>"
					 + data[i].percentage + "%</span></td><td style='font-size:12px;'>"
					 + "[" + data[i].value + "] " + data[i].content
					 + "</td></tr>"
					 + "<tr><td class='time-stamp'><u>"
					 + data[i].time + "</u></td></tr></table></li>";
				
				$(".dropdown-menu.alert-dropdown > ul > center").append(show_ul);
			}
		}
	});
}

function selectOfficial(_official){
	$(".dropdown-menu.offi-dropdown").html("")
	
	for(type in _official){
		if(_official[type].type == "국내지진") className = "fa-male fc-bgreen";
		else className = "fa-globe fc-green";
				
		off_li =  "<li class='offList'>";
		off_li += "<table style='width:98%;'>"
		off_li += "<tr><td rowspan='2' style='width:33px; font-size:30px;'><span class='fa "+className+"'></span></td>";
		off_li += "<td style='font-size:15px; font-weight:800;'>["+_official[type].type+"]</td></tr>";
		off_li += "<tr><td style='font-size:14px;'> "+_official[type].text+"</td></tr>";
		off_li += "</table></li>";
		
		$(".dropdown-menu.offi-dropdown ").prepend(off_li);
	}
}

function selectTwitter(_twit){
	var MAX = 9;
	var curLength = $(".twitList").length;

	$(".twit-cnt").html(($(".twitList").length)+" / "+(MAX+1));
	if(curLength > MAX) MAX = $(".twitList").last().remove(); 
	
	twit_li =  "<li class='twitList' _data-toggle='tooltip'>";
	twit_li += "<table style='width:98%;'><tr>"
	twit_li += "<td rowspan='4' style='width:30px; vertical-align: top; padding-top: 6px; padding-right: 3px;'><img class='img-rounded twitUrl' src='"+_twit.profileURL+"'></td>";// <span
																																													// class='loc-ico
																																													// glyphicon
																																													// glyphicon-map-marker'></span>
	twit_li += "<td colspan='2' style='color:gray;'>@"+_twit.name+"</td></tr>";
	twit_li += "<tr><td colspan='2'>"+_twit.text+"</td></tr>";
	twit_li += "<tr><td class='loc-td' colspan='2'><span style='font-size:0.3em;'>"+((_twit.timeZone == null)? "":_twit.timeZone)+"</span></td>";
	twit_li += "<tr><td class='address-td' colspan='2'><u><span>"+_twit.time+"</span></u></td></tr></table></li>";
	
	$(".dropdown-menu.twit-dropdown").prepend(twit_li);
}

function selectShelter(_data, _cnt){
	var MAX = 30;
	$(".dropdown-menu.sht-dropdown").html("");
	$(".sht-cnt").html(_data.length + " / "+ _cnt);
	
	if(_data.length < MAX) MAX = _data.length; 
	
	for(var i=0; i < MAX; i++){
		sht_li =  "<li class='lnfShelterName nameCnt"+ i + "' _data-toggle='tooltip' title='"+_data[i].address+"'>";
		sht_li += "<table style='width:95%;'><tr>"
		sht_li += "<td rowspan='2' style='width:30px;'><span class='loc-ico glyphicon glyphicon-map-marker'></span></td>";
		sht_li += "<td colspan='2' style='font-size:10px'>"+_data[i].name+"</td>";
		sht_li += "<tr><td><span style='font-size:0.7em;'>["+_data[i].area+"㎡]</span></td>";
		sht_li += "<td class='address-td'><u><span>"+_data[i].firstAdd+" "+_data[i].secondAdd+"</span></u></td></tr></table></li>";
		
		$(".dropdown-menu.sht-dropdown").append(sht_li);
	}
}

function keyword(_data){
	$("#myDropdowon-naver").html("");
	for(k in _data.message){
		key_li = "<li><div class='nRank'>"+k+"</div><div><a>"+_data.message[k]+"</a></div></li>" 
		$("#myDropdowon-naver").append(key_li);
	}
} 

function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		zoom : 7,
		mapTypeId:"hybrid",
		labels:true,
		center : {
			lat : 36.5443,
			lng : 127.9948
		}
	});
}

function showInfor2(marker, data, i) {
	
	var infowindow = new google.maps.InfoWindow({
		content : data[i].name
	});
	marker.addListener('mouseover', function() {
		infowindow.open(map, marker);
	});
	marker.addListener('mouseout', function() {
		infowindow.close(map, marker);
	});
	marker.addListener('click', function() {
	});
}

function showInfor(marker, title, degree, time, tag) {
	if(tag==""||tag==null){
		tag="img/no-image.jpg";
	}
	var infowindow = new google.maps.InfoWindow({
		content : '<div id="infoContent" class="infoContent">'+	
					'<div class="text-wrapper">'+
						'규모: '+degree+'<br>'+
						'발생시간: '+time+'<br>'+
						'발생지역: '+title+'<br>'+
					'</div>'+
					'<div class="img-wrapper"><img id="earthimg" src="'+tag+'"></div>'+
					'</div>'
					
	});
	
	
	marker.addListener('click',function() {
						
						var uri = $(this).data("URI");
						var tag = $(this).data("TAG");
				
					 	$.ajax({
							type:"get",
							url:"http://192.168.0.62:503/pulse",
							dataType:'json',
							data : {
								"Key":"dc6a2e5c240a60a72606bc23fe5b123c",
								"URI" : uri
							},
							beforeSend : function() {
								if (tag != "" && uri != "") {
									var show = "<div class='modal-wrapper'><p>서버로 부터 데이터를 요청중입니다</p><p>잠시만 기다려주세요</p></div>";
									$("body").prepend(show);
									$("body").css("overflow", "hidden");
								} else {
									if (tag == "")
										alert("지도 정보를 못가져옵니다.");
									if (uri == "")
										alert("그래프 URI 정보를 못가져옵니다.");
								}
							},
							success : function(jdata){
								console.log(jdata);
								$(".buttonShowGraph").html("Hide Graph"); 
								$(".buttonShowGraph").animate({bottom:'275px'},1000); 
								$(".hideShow").animate({height:["show","swing"]},1000);
								checkValue=0;// Value값 초기화
								
								$("body").css("overflow","visible");
								$(".empty-data.graph").css("display", "none");
								
								if (tag != "" && uri != "") {
									$("#earthimg").attr("src", tag);
									$(".empty-data").css("display","none");
									$(".modal-wrapper").css("display","none");
									$("body").css("overflow", "visible");
									
									google.charts.load('current', {'packages':['corechart']});
									var pubDate = new Date(parseInt(jdata[i].time));
							        var formattedDate = pubDate.getFullYear() + '년 ' + (pubDate.getMonth()+1) +'월 '+ pubDate.getDate()+'일';
									
									setTimeout(function() {
										google.charts.setOnLoadCallback(drawChart());
									}, 1000);
									
		 							
									function drawChart() {
										 var data = new google.visualization.DataTable();
									    data.addColumn('datetime', '지진 발생 시간');
									    data.addColumn('number', '지진 속력');
									    data.addRows(jdata.length);
									    for(i=0; i<jdata.length; i++){
									    	data.setCell(i,0,new Date(parseInt(jdata[i].time)));
									    	data.setCell(i,1,jdata[i].value);								    	
									    }
															   
									    var options = {
								            	title : formattedDate + " 지진 속력 그래프",
									    		width: 100 +'%',
									            height: 100 +'%',
									             
									            legend: 'none',
									            series: {
									                0: { color: '#ffffff' }									                
									              },									            
									            backgroundColor: {
									                'fill': 'black',
									                'fillOpacity': 0.8
									              },
									            hAxis : { 
									            	title: '지진 발생 시간',
									            	titleTextStyle: {
									   				 	color:'white'
										             },
									            	textStyle: {fontSize: 11 , color:'white'},
										            gridlines: {color: 'white', count:12},
									            	format:'hh:mm:ss'
									   			 },
									            vAxis: { 
									            	title : "지진 속력",
									            	titleTextStyle: {
									   				 	color:'white'
										             },
									            	textStyle: { color:'white'},
									            	gridlines: { color:'white', count: 10 } 
									   			 },
									   			 titleTextStyle: {
									   				 	color:'white',
									   				 	fontSize: 30,
										                fontName: 'Arial',										                
										                bold: true,
										                italic: true
										             }
									    };
									    
							
									  var chart = new google.visualization.LineChart(document.getElementById('placeholder'));
									  chart.draw(data, options);
									}
								}
							},
							error : function(err) {
								alert("[Error]" + err.statusText);
								$(".modal-wrapper").css("display","none");
								
							}
						}); 
						
					});
	marker.addListener('mouseover', function() {
		infowindow.open(map, marker);
	});
	marker.addListener('mouseout', function() {
		infowindow.close(map, marker);
	});
}

function infoEqForecast(marker, data, i){
	   
	   var infowindow = new google.maps.InfoWindow({
	      content : 
	      '<div class="forecastDistance">'+   
	         '<h4>시계열 거리 예측</h4>'+   
	         '<table border><tr><td>관측소</td><td>'+data[i].op_name+'</td></tr>'+
	         '<tr><td>월 단위 거리 예측</td><td>'+data[i].month_dist+'km</td></tr>'+
	         '<tr><td>일 단위 거리 예측</td><td>'+data[i].day_dist+'km</td></tr></table><h6>'+
	         data[i].date+'기준</h6>'+
	      '</div>'   
	   });
	   marker.addListener('mouseover', function() {
	      infowindow.open(map, marker);
	   });
	   marker.addListener('mouseout', function() {
	      infowindow.close(map, marker);
	   });
	};
	

function infoWeatherForecast(marker){
   var infowindow = new google.maps.InfoWindow({
      content : 
      '<div style= width:400px; height:200px>'+   
         '<h4>오늘 '+marker.title+'에 비가 올까요?</h4><span>'+marker.date+'</span>기준<br><br>'+
         '<table border style="padding: 15px; text-align:center;"><tr style="background-color:#C3CDD4"><td style="background-color:#C3CDD4"></td><td>로지스틱회귀('+marker.log_reg_ac+'%)</td><td>서포트벡터머신('+marker.svm_ac+'%)</td><td>랜덤포레스트('+marker.log_reg_ac+'%)</td></tr>'+
         '<tr><td style="background-color:#C3CDD4">00:00</td><td>'+marker.log_reg[0]+'</td><td>'+marker.svm[0]+'</td><td>'+marker.RForest[0]+'</td></tr>'+
         '<tr><td style="background-color:#C3CDD4">03:00</td><td>'+marker.log_reg[1]+'</td><td>'+marker.svm[1]+'</td><td>'+marker.RForest[1]+'</td></tr>'+
         '<tr><td style="background-color:#C3CDD4">06:00</td><td>'+marker.log_reg[2]+'</td><td>'+marker.svm[2]+'</td><td>'+marker.RForest[2]+'</td></tr>'+
         '<tr><td style="background-color:#C3CDD4">09:00</td><td>'+marker.log_reg[3]+'</td><td>'+marker.svm[3]+'</td><td>'+marker.RForest[3]+'</td></tr>'+
         '<tr><td style="background-color:#C3CDD4">12:00</td><td>'+marker.log_reg[4]+'</td><td>'+marker.svm[4]+'</td><td>'+marker.RForest[4]+'</td></tr>'+
         '<tr><td style="background-color:#C3CDD4">15:00</td><td>'+marker.log_reg[5]+'</td><td>'+marker.svm[5]+'</td><td>'+marker.RForest[5]+'</td></tr>'+
         '<tr><td style="background-color:#C3CDD4">18:00</td><td>'+marker.log_reg[6]+'</td><td>'+marker.svm[6]+'</td><td>'+marker.RForest[6]+'</td></tr>'+
         '<tr><td style="background-color:#C3CDD4">21:00</td><td>'+marker.log_reg[7]+'</td><td>'+marker.svm[7]+'</td><td>'+marker.RForest[7]+'</td></tr></table>'+
      '</div>'   
   });
   marker.addListener('mouseover', function() {
      infowindow.open(map, marker);
   });
   marker.addListener('mouseout', function() {
      infowindow.close(map, marker);
   });
};	
	
function makerToMapOnYear(year, mcOptions){
   initMap();
   sendYear = "time="+year;
   
   $.ajax({
      type : 'GET',
      url : 'getMapJson.do',
      data: sendYear,
      dataType : 'json',   
      success : function(d) {
         var data = d.realtime;
         console.log(data);
         for (var i = 0; i < data.length; i++) {
            var latLng = new google.maps.LatLng(
                  parseFloat(data[i].lat),
                  parseFloat(data[i].lng));
            
            var marker = new google.maps.Marker({
               position : latLng,
               map : map,
               icon : './img/placeholder_past.png'
            });
            $(marker).data("URI", data[i].url);
            $(marker).data("TAG", data[i].tag);
            markers_past[i] = marker;
            showInfor(marker, data[i].title, data[i].degree, data[i].time, data[i].tag);
         }
         markerCluster_past = new MarkerClusterer(map, markers_past,   {
             imagePath : 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
         });
         markerCluster = new MarkerClusterer(map,markers, mcOptions);
      }
   });
}
// 특정 위치의 경계 좌표 구하는 함수
function pixelToLatlng(xcoor, ycoor) {
	
	  var ne = map.getBounds().getNorthEast();
	  var sw = map.getBounds().getSouthWest();
	  var projection = map.getProjection();
	  var topRight = projection.fromLatLngToPoint(ne);
	  var bottomLeft = projection.fromLatLngToPoint(sw);
	    
	  // var scale = Math.pow(2, map.getZoom());
	  var scale = 1 << map.getZoom();

	  var newLatlng = projection.fromPointToLatLng(new google.maps.Point( ( xcoor/scale ) + bottomLeft.x, (ycoor/scale) + topRight.y));
	  return newLatlng;
};

// zoom할 시, 보이는 화면에만 마커 보이게
function viewMarkerOnEvent(map, total){
	var cnt = 0; // 마커 갯수 확인 용
	var tmpArr = Array();
    for (var i = 0; i < markers.length; i++){
		if (parseFloat(startLat) <= parseFloat(markers[i].getPosition().lat()) && parseFloat(startLng) <= parseFloat(markers[i].getPosition().lng()) && parseFloat(endLat) >= parseFloat(markers[i].getPosition().lat()) && parseFloat(endLng) >= parseFloat(markers[i].getPosition().lng()))
		{
			tmpArr[cnt] = markers[i];
			markers[i].setMap(map);
			cnt++;	
		}
	}
    console.log(tmpArr);	
    selectShelter(tmpArr, markers.length);
}

function showSelectShelter(){
	$.ajax({
		type : 'GET',
		url : 'getShelterJson.do',
		dataType : 'json',
		success : function(d) {
			var data = d.shelter;
			selectShelter(data, data.length);
		}
	});
}



function geoCenter(geocoder, address, resultsMap) {
	geocoder.geocode({
		'address' : address
	}, function(results, status) {
		if (status === 'OK') {
			resultsMap.setCenter(results[0].geometry.location);
			map.setZoom(15);
		}
	});
}


function printClock() {
    var currentDate = new Date();
	var dateString = dateFormat(currentDate);
	var icon = "<span class='glyphicon glyphicon-time'></span>";
    var amPm = 'AM'; 
    var currentHours = addZeros(currentDate.getHours(),2); 
    var currentMinute = addZeros(currentDate.getMinutes() ,2);
    var currentSeconds =  addZeros(currentDate.getSeconds(),2);
    
    if(currentHours >= 12){
    	amPm = 'PM';
    	currentHours = addZeros(currentHours - 12,2);
    }

    if(currentSeconds >= 50){
       currentSeconds = '<span style="color:#de1951;">'+currentSeconds+'</span>'
    }
    $(".current-clock").html(icon+" "+dateString+" "+currentHours+":"+currentMinute+":"+currentSeconds +" "+ amPm);
    
}

function addZeros(num, digit) { 
	  var zero = '';
	  num = num.toString();
	  if (num.length < digit) {
	    for (i = 0; i < digit - num.length; i++) {
	      zero += '0';
	    }
	  }
	  return zero + num;
}

function dateFormat(d){
	var year = d.getFullYear().toString();
	var month = (d.getMonth()+1).toString();
	var day = d.getDate().toString();
	var dateString = "";
	
	if(month < 10){
		month = "0"+month;
	}
	if(day < 10){
		day = "0"+day;
	}
	dateString = year+"년 "+month+"월 "+day+"일";
	return dateString;
}

function drawGraph(drawdata){
	function weekendAreas(axes) {

		var markings = [], d = new Date(axes.xaxis.min);
		// go to the first Saturday
		d.setUTCDate(d.getUTCDate() - ((d.getUTCDay() + 1) % 7))
		d.setUTCSeconds(0);
		d.setUTCMinutes(0);
		d.setUTCHours(0);

		var i = d.getTime();

		do {
			markings.push({
				xaxis : {
					from : i,
					to : i + 2 * 24 * 60 * 60 * 1000
				}
			});
			i += 7 * 24 * 60 * 60 * 1000;
		} while (i < axes.xaxis.max);

		return markings;
	}

	var options = {
		xaxis : {
			mode : "time",
			tickLength : 5
		},
		selection : {
			mode : "x"
		},
		grid : {
			markings : weekendAreas
		}
	};

	var plot = $.plot("#placeholder", [ drawdata ], options);
	
	var overview = $.plot("#overview", [ drawdata ], {
		series : {
			lines : {
				show : true,
				lineWidth : 1
			},
			shadowSize : 0
		},
		xaxis : {
			ticks : [],
			mode : "time"
		},
		yaxis : {
			ticks : [],
			min : null,
			autoscaleMargin : 0.1
		},
		selection : {
			mode : "x"
		}
	});
	// now connect the two

	$("#placeholder").bind("plotselected", function(event, ranges) {
		// do the zooming
		$.each(plot.getXAxes(), function(_, axis) {
			var opts = axis.options;
			opts.min = ranges.xaxis.from;
			opts.max = ranges.xaxis.to;
		});
		plot.setupGrid();
		plot.draw();
		plot.clearSelection();

		// don't fire event on the overview to prevent eternal loop

		overview.setSelection(ranges, true);
	});

	$("#overview").bind("plotselected", function(event, ranges) {
		plot.setSelection(ranges);
	});

}

