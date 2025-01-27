<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.vo.CarVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Insert title here</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		 <link rel="stylesheet" href="/resources/demos/style.css">
		 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 
		<style type="text/css">
			.usertable{
				width: 100%;
				text-align: center;
				margin-top: 30px;
				margin-bottom: 100px;
			}
			th{
				border-top: solid 2px gray;
				border-bottom: solid 2px gray;
			}
			tr{
				border-top: solid 1px gray;
				border-bottom: solid 1px gray;
			}
			.popup{
				display: none;
		        width: 500px;
		        height: 500px;
		        position: absolute;
		        top:50%;
		        left: 50%;
		        margin: -250px 0 0 -250px;
		        background:#eee;
		        z-index: 2;
			}
			.imgbtn{
				margin-left: 10px;
				margin-top: 5px;
				margin-bottom: 5px;
				border: solid 1px #9abfd1;
				border-radius: 20px;
				color: #9abfd1;
				font-size: 10pt;
				background-color: #ffffff;
				cursor: pointer;
			}
			.contenttitle{
				font-weight: bold;
			}
			.btnbox{
				text-align: center;
				margin-top: 30px;
			}
			.btnhead{
				font-size: 18pt;
				font-weight: bold;
				color: #4b88a5;
			}
			.parkname{
				text-align: center; 
				background-color:#ffffff; 
				height: 30px; 
				width: 90px; 
				border: solid 1px #4b88a5; 
				margin:5px; 
				border-radius: 5px; 
				display:inline;
				cursor: pointer;
			}
			.parkname:focus {
 				background-color: #4b88a5;
 				color:white;
			}
			.Search{
				margin-top: 30px;
				text-align: right;				
			}
			.numText{
				margin-left: 10px;
				margin-right: 5px;
				border: solid 1px #dcdeeb;
			}
			.searchname{
				color: #737373;
				margin-left: 40px;
			}
			.numSearch{
				border: none;
				background-color: #ffffff;
				cursor: pointer;
			}
			.searchimg{
				width: 30px;
				height: 30px;
			}
			#startdate,#enddate{
				margin-right: 7px;
			}
			
		</style>
		<script type="text/javascript">

	 	function inImg(btn){
	 		var img = $("#"+btn).val();
			window.open("/Finalweb/CarInImg.mc?in_photo="+img, "", "width=600, height=400, left=500, top=200");
		}
		function outImg(btn){
			var img = $("#"+btn).val();
			window.open("/Finalweb/CarOutImg.mc?out_photo="+img, "", "width=600, height=400, left=500, top=200");
		} 
		
		function carsearch(){
			carnum =  $(".numText").val();
			//alert(carnum);
			$.ajax({
				url:"/Finalweb/CarSearch.mc",
				type:"get",
				data:{"carnum":carnum},
				success:function(data){
					alert(data);
					mydata="<tr><th>주차장 번호</th><th>ID</th><th>차량 번호</th><th>입차 시간</th><th>출차 시간</th></tr>";
					if(data.length==0){
						mydata = mydata + "<tr><td colspan='6' style='padding:10px; color:gray;'>조회된 차량이 없습니다.</td><tr>";
					}else{
						for(i=0;i<data.length;i++){
							 if(data[i].out_time==null){
								 mydata = mydata + "<tr>"+
									"<td>"+data[i].p_id+"</td>"+
									"<td>"+data[i].mem_id+"</td>"+
									"<td>"+data[i].car_num+"</td>"+
									"<td>"+data[i].in_time+"<button class='imgbtn' name ='inImg' id='inImg' value='"+data[i].in_photo+"'>조회</button></td>"+
									"<td>-<button class='imgbtn' name ='outImg' id='outImg' value='"+data[i].out_photo+"'>조회</button></td>"+
									"</tr>"	
							 }else{
								 mydata = mydata + "<tr>"+
									"<td>"+data[i].p_id+"</td>"+
									"<td>"+data[i].mem_id+"</td>"+
									"<td>"+data[i].car_num+"</td>"+
									"<td>"+data[i].in_time+"<button class='imgbtn' name ='inImg' id='inImg' value='"+data[i].in_photo+"'>조회</button></td>"+
									"<td>"+data[i].out_time+"<button class='imgbtn' name ='outImg' id='outImg' value='"+data[i].out_photo+"'>조회</button></td>"+
									"</tr>"	
							 }
						}
					}
					
					$("#usertable").empty();
					$("#usertable").append(mydata);
					$("#startdate").val("");
					$("#enddate").val("");
					$("#inImg").each(function(){
						$(this).click(function(){
							img = $(this).val();
							window.open("/Finalweb/CarInImg.mc?in_photo="+img, "", "width=600, height=400, left=500, top=200");
						});
					});
					$("#outImg").each(function(){
						$(this).click(function(){
							img = $(this).val();
							window.open("/Finalweb/CarOutImg.mc?out_photo="+img, "", "width=600, height=400, left=500, top=200");
						});
					});
					
				}
			});//end ajax
		};
		
		function parkbtn(btn){
			category = $("#"+btn).val();
			$.ajax({
				url:"/Finalweb/pkuser/ajax_list.mc",
				type:"get",
				data:{"category":category},
				success:function(data){
					mydata="<tr><th>주차장 번호</th><th>ID</th><th>차량 번호</th><th>입차 시간</th><th>출차 시간</th></tr>";
					for(i=0;i<data.length;i++){
						 if(data[i].out_time==null){
							 mydata = mydata + "<tr>"+
								"<td>"+data[i].p_id+"</td>"+
								"<td>"+data[i].mem_id+"</td>"+
								"<td>"+data[i].car_num+"</td>"+
								"<td>"+data[i].in_time+"<button class='imgbtn' name ='inImg' id='inImg' value='"+data[i].in_photo+"'>조회</button></td>"+
								"<td>-<button class='imgbtn' name ='outImg' id='outImg' value='"+data[i].out_photo+"'>조회</button></td>"+
								"</tr>"	
						 }else{
							 mydata = mydata + "<tr>"+
								"<td>"+data[i].p_id+"</td>"+
								"<td>"+data[i].mem_id+"</td>"+
								"<td>"+data[i].car_num+"</td>"+
								"<td>"+data[i].in_time+"<button class='imgbtn' name ='inImg' id='inImg' value='"+data[i].in_photo+"'>조회</button></td>"+
								"<td>"+data[i].out_time+"<button class='imgbtn' name ='outImg' id='outImg' value='"+data[i].out_photo+"'>조회</button></td>"+
								"</tr>"	
						 }
					}
					
					$("#usertable").empty();
					$("#usertable").append(mydata);
					$(".numText").val("");
					$("#startdate").val("");
					$("#enddate").val("");
					$("#inImg").each(function(){
						$(this).click(function(){
							img = $(this).val();
							window.open("/Finalweb/CarInImg.mc?in_photo="+img, "", "width=600, height=400, left=500, top=200");
						});
					});
					$("#outImg").each(function(){
						$(this).click(function(){
							img = $(this).val();
							window.open("/Finalweb/CarOutImg.mc?out_photo="+img, "", "width=600, height=400, left=500, top=200");
						});
					});
				}
			});//end ajax
		};
		
	$(function() {
			$("#startdate, #enddate").datepicker({
				   onSelect: function(dateText) {
			            var startDate = $.datepicker.formatDate("yy-mm-dd",$("#startdate").datepicker('getDate'));
			            var endDate =  $.datepicker.formatDate("yy-mm-dd",$("#enddate").datepicker('getDate'));
						$.ajax({
							url:"/Finalweb/pkuser/ajax_date.mc",
							type:"get",
							data:{"startdate":startDate, "enddate":endDate},
							success:function(data){
								mydata="<tr><th>주차장 번호</th><th>ID</th><th>차량 번호</th><th>입차 시간</th><th>출차 시간</th></tr>";
								if(data.length==0){
									mydata = mydata + "<tr><td colspan='6' style='padding:10px; color:gray;'>조회된 차량이 없습니다.</td><tr>";
								}else{
									for(i=0;i<data.length;i++){
										 if(data[i].out_time==null){
											 mydata = mydata + "<tr>"+
												"<td>"+data[i].p_id+"</td>"+
												"<td>"+data[i].mem_id+"</td>"+
												"<td>"+data[i].car_num+"</td>"+
												"<td>"+data[i].in_time+"<button class='imgbtn' name ='inImg' id='inImg' value='"+data[i].in_photo+"'>조회</button></td>"+
												"<td>-<button class='imgbtn' name ='outImg' id='outImg' value='"+data[i].out_photo+"'>조회</button></td>"+
												"</tr>"	
										 }else{
											 mydata = mydata + "<tr>"+
												"<td>"+data[i].p_id+"</td>"+
												"<td>"+data[i].mem_id+"</td>"+
												"<td>"+data[i].car_num+"</td>"+
												"<td>"+data[i].in_time+"<button class='imgbtn' name ='inImg' id='inImg' value='"+data[i].in_photo+"'>조회</button></td>"+
												"<td>"+data[i].out_time+"<button class='imgbtn' name ='outImg' id='outImg' value='"+data[i].out_photo+"'>조회</button></td>"+
												"</tr>"	
										 }
									}
								}
								$("#usertable").empty();
								$("#usertable").append(mydata);
								$(".numText").val("");
								$("#inImg").each(function(){
									$(this).click(function(){
										img = $(this).val();
										window.open("/Finalweb/CarInImg.mc?in_photo="+img, "", "width=600, height=400, left=500, top=200");
									});
								});
								$("#outImg").each(function(){
									$(this).click(function(){
										img = $(this).val();
										window.open("/Finalweb/CarOutImg.mc?out_photo="+img, "", "width=600, height=400, left=500, top=200");
									});
								});
							}
						});//end ajax
				    }
				
			});
			$.datepicker.setDefaults({
			        dateFormat: 'yy-mm-dd',
			        prevText: '이전 달',
			        nextText: '다음 달',
			        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			        showMonthAfterYear: true,
			        yearSuffix: '년',
			        showOn: "both", 
			        buttonImage:  "img/date.png",
			        buttonImageOnly: true,
			        buttonText: "선택"    
			    });
			$("#startdate").datepicker().datepicker("setDate", new Date());
			
		    $ ("#startdate").datepicker("option", "maxDate", $ ("#edate").val());
		    $ ("#startdate").datepicker("option", "onClose", function ( selectedDate ) {
		        $ ("#enddate").datepicker( "option", "minDate", selectedDate );
		    });
		 
		    $ ("#enddate").datepicker();
		    $ ("#enddate").datepicker("option", "minDate", $ ("#sdate").val());
		    $ ("#enddate").datepicker("option", "onClose", function ( selectedDate ) {
		        $ ("#startdate").datepicker( "option", "maxDate", selectedDate );
		    });
		});
		
	
		$(document).ready(function(){
			$("#numText").keyup(function(e){if(e.keyCode == 13)  carsearch(); });
		});	
	
		</script> 
	</head>
	<body>
	 <% ArrayList<CarVO> pkuserList = (ArrayList<CarVO>)request.getAttribute("pkuserList"); 
		int size = pkuserList.size();

	%>
		
		
		
		<div class="breadcrumbs" >
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1 class="contenttitle">주차장 이용 고객 현황</h1>
                    </div>
                </div>
            </div>
        </div>

		<div class="col-xl-12" >
			<div class="card" style="padding-bottom: 40px;">
				<div class="container">
					<div class="btnbox" id="btnbox">
						<span class="btnhead">주차장&nbsp;&nbsp;&nbsp;</span>
							<button class="parkname" id="parkbtnall" value="all" onclick="parkbtn('parkbtnall')">
								ALL
							</button>
						<% for(char i='A';i<='H';i++){ %>
							<button class="parkname" id="parkbtn<%=i%>" value="<%=i%>" onclick="parkbtn('parkbtn<%=i%>')">
								<%=i%>
							</button>
						<%}%>
					</div>
					<div id="datetext"></div>
					<div class="Search">
						<span class="searchname">조회 기간&nbsp;&nbsp;&nbsp;<input type="text" id="startdate"></span>
						<span>&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;<input type="text" id="enddate"></span>
						<span class="searchname">차량 번호</span>
						<input type="text" class="numText" id="numText">
						<button type="button" class="numSearch" onclick="carsearch()"><img src="img/search.png" class="searchimg"/></button>
					</div>
				</div>
			</div>
		</div>	
				
				
		<div class="col-xl-12" >
			<div class="card">	
				<div class="container">
					<table class="usertable" id="usertable">
		 				<tr>
							<!-- <th>순번</th> -->
							<th>주차장 번호</th>
							<th>ID</th>
							<th>차량 번호</th>
							<th>입차 시간</th>
							<th>출차 시간</th>
						</tr>
						<%for(int i=0;i<size;i++){ 
							CarVO mycar = pkuserList.get(i);
							Date in_time = mycar.getIn_time();
							Date out_time = mycar.getOut_time();
							SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							String outResult ="";
							if(out_time==null){
								outResult = "-";
							}else{
								outResult = format.format(out_time);
							}
							%>
						<tr id="userlist">
							<%-- <td id="car_seq"><%=mycar.getCar_seq() %></td> --%>
							<td id="p_id"><%=mycar.getP_id() %></td>
							<td id="mem_id"><%=mycar.getMem_id()%></td>
							<td id="car_num"><%=mycar.getCar_num()%></td>
							<td id="in_time"><%=format.format(in_time)%><button class="imgbtn" name ="inImg" id="inImg<%=i %>" onclick="inImg('inImg<%=i%>')" value="<%=mycar.getIn_photo()%>">조회</button></td>
							<td id="out_time"><%=outResult %><button class="imgbtn" name ="outImg" id="outImg<%=i%>" onclick="outImg('outImg<%=i%>')" value="<%=mycar.getOut_photo()%>">조회</button></td>
						</tr>
						<%} %>
					</table>
				</div>
			</div>
		</div>
	</body>
</html>

