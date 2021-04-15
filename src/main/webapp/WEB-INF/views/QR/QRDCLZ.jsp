<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js">

<head>
<meta charset="utf-8">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Favicon -->
    <link rel="shortcut icon" href="${cp}/assets/img/favicon.ico" type="image/x-icon">
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="${cp}/assets/plugins/bootstrap/css/bootstrap.min.css">
    <!-- Fonts from Font Awsome -->
    <link rel="stylesheet" href="${cp}/assets/css/font-awesome.min.css">
    <!-- CSS Animate -->
    <link rel="stylesheet" href="${cp}/assets/css/animate.css">
    <!-- Custom styles for this theme -->
    <link rel="stylesheet" href="${cp}/assets/css/main.css">
    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic,600italic,700italic,900italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <!-- Feature detection -->
    <script src="${cp}/assets/js/modernizr-2.6.2.min.js"></script>
    <!-- Font Icons -->
    <link rel="stylesheet" href="${cp}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${cp}/assets/css/simple-line-icons.css">
    <!-- Switchery -->
    <link rel="stylesheet" href="${cp}/assets/plugins/switchery/switchery.min.css">
    <!-- Vector Map  -->
    <link rel="stylesheet" href="${cp}/assets/plugins/jvectormap/css/jquery-jvectormap-1.2.2.css">
    <!-- ToDos  -->
    <link rel="stylesheet" href="${cp}/assets/plugins/todo/css/todos.css">
    <!-- Morris  -->
    <link rel="stylesheet" href="${cp}/assets/plugins/morris/css/morris.css">
    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic,600italic,700italic,900italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <!-- Feature detection -->

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
</head>
<script>

	var seconds = 15;
	var interval = setInterval(count15s, 1000);	
	
	// 15초 카운트 해주는 function
	function count15s(){
		$("#15seconds").text(seconds);
		if(seconds <= 15 && seconds >= 1){
			seconds--;
		}else{
			alert("QR코드 인증시간이 초과되었습니다. \n다시 로그인 하여 주십시오.")
			clearInterval(interval)
			location.href="/QR/loginView"
		}	
	}
	
	$(document).ready(function(){

    	url = "/QR/CreateQRCode";
        var content = $("#content").val();
                
        $("#img").attr("src", url+"?content="+content);
			
    });
</script>

<body class="animated fadeIn">
    <section id="login-container">
	
        <div class="row"> 
            <div class="col-md-4" id="login-wrapper">
                <div class="panel panel-primary animated flipInY">
                    <div class="panel-heading" style="text-align:center;">
                        <h3 class="panel-title">     
                         ${QR_USER.ko_nm }님 출퇴근 QR코드
                        </h3>      
                    </div>
                    <div class="panel-body" style="text-align : center;">
                       <div class="row">
			
						<!-- QR생성되는 div -->
						<div class="setTime" style="text-align:center;">
					        <input id="content" type="hidden" name="content" value="${url }?emp_no=${QR_empno}"/>
										        <img id="img" style="display:none; width:400px; height:360px; " onload="this.style.display='block'"/>
					    </div>
					    
					    <!-- 15초카운트 -->
						<div id="15seconds" onload="count15s()">
							
						</div>
						
						</div>
                        
                    </div>
                </div>
            </div>
        </div>

    </section>
    
    <!--Global JS-->
    <script src="${cp}/assets/js/jquery-1.10.2.min.js"></script>
    <script src="${cp}/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="${cp}/assets/plugins/waypoints/waypoints.min.js"></script>
    <script src="${cp}/assets/js/application.js"></script>

</body>
</html>