<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*"%>
<%!
	// 넘겨오는 값이 null인경우에는 공백넘기기
	String NLStr(String param){
		return param==null?"":param;
	}
	// 넘겨오는 값을 숫자형으로 전환 필요한 경우, null 경우는 0, 그외는 정수형 전환처리
	int NLInt(String param){
		int num=0;
		if(param!=null){
			// Integer.parseInt(param):숫자형 문자열을 숫자로 변환처리.
			num = Integer.parseInt(param);
		}
		return num;
	}
	double NLDbl(String param){
		double num=0;
		if(param!=null){
			num = Double.parseDouble(param);
		}
		return num;
	}	
	String[] NAStr(String[] param){
		String []ret = {""};
		if(param!=null&&param.length>0){
			ret = param;		
		}
		return ret;
	}
	int[] NAInt(String[] params){
		int []ret = {0};
		if(params!=null&&params.length>0){
			ret = new int[params.length];
			for(int idx=0;idx<params.length;idx++){
				ret[idx] = Integer.parseInt(params[idx]);
			}
		}
		return ret;
	}	
	double[] NADbl(String[] params){
		double []ret = {0};
		if(params!=null&&params.length>0){
			ret = new double[params.length];
			for(int idx=0;idx<params.length;idx++){
				ret[idx] = Double.parseDouble(params[idx]);
			}
		}
		return ret;
	}		
%>      
<%
	MembersDAO dao = new MembersDAO();
	String path = request.getContextPath();
	Members mem = null;
	boolean isLog = false;
	boolean buycong = false;
	boolean buycong22 = false;
	String name = "비회원";
	int mem_no = 0;
	int mem_cong = 0;
	String test01 = NLStr(request.getParameter("test01"));
	String pay01 = NLStr(request.getParameter("pay01"));
	if(session.getAttribute("mem") != null){
		isLog= true;
		mem = (Members)session.getAttribute("mem");
		if(mem != null){	
			mem_no = mem.getMem_no();
			name = mem.getMem_name();
			mem_cong = mem.getMem_cong();
		}
	}else{
		response.sendRedirect("mylogin.jsp?valid=N");
	}
	if(!test01.equals("") && !pay01.equals("")){
		int congcnt = NLInt(test01);
		buycong = dao.updateMembers2(mem.getMem_no(),congcnt);
		buycong22 = dao.buycong2(mem.getMem_no(), congcnt, pay01);
		session.setAttribute("mem", dao.login(new Members(mem.getMem_id(),mem.getMem_pwd())));
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=path %>/a00_com/a00_com.css">
<link href="default.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
.w3-sidebar a {
	font-family: "Roboto", sans-serif
}

body, h1, h2, h3, h4, h5, h6, .w3-wide {
	font-family: "Montserrat", sans-serif;
}
input[type=text]{width:100%;}
</style>
</head>
<body>

	<div id="header-wrapper2">
		<div id="header" class="container">
			<div id="logo">
				<h1>
					<a href="Main01.html" class="icon icon-group"><span>KGITBANK</span></a>
				</h1>
			</div>
			<div id="menu">
				<ul>
					<li><a href="Main01.html" title="">회사소개</a></li>
					<li><a href="Main02_notice.jsp" title="">공지사항</a></li>
					<li><a href="Main03_itemes.jsp" title="">아이템샵</a></li>
					<li class="current_page_item"><a href="Main04_charge.jsp"
						title="">콩알충전소</a></li>
					<li><a href="Myhome.jsp" title="">내홈피가기</a></li>
					<li id="login"><a href="mylogin.jsp" title="">로그인</a></li>
					<li id="logout"><a href="logout.jsp" title="">로그아웃</a></li>
				</ul>
			</div>
		</div>
	</div>



	<div class="w3-container w3-display-container w3-padding-16"
		style="text-align: center;">

		<br>
		<br>
		<h3 class="w3-wide">
			<b>콩알 충전하기</b>
		</h3>
		<br><br><br><br>
	<form id="form01">
			<div class="w3-large" style="font-weight: bold"><a>현재 나의 콩알 : <%=mem_cong %>개</a><br><br>
				<a onclick="myAccFunc1()" class="w3-button" id="myBtn">콩알갯수
					<i class="fa fa-caret-down"></i>
				</a>
				<div id="demoAcc1" class="w3-bar-block w3-padding-large w3-medium">
					<div style="float: left; padding-left: 750px">
						<a id="selbc1" class="w3-button"><i
							class="fa fa-caret-right w3-margin-right"><label><input
									onclick="func1()" type="radio" name="test01" value="10">10개</label></i></a>
					</div>
					<div style="float: left;">
						<a id="selbc2" class="w3-button"><i
							class="fa fa-caret-right w3-margin-right"><label><input
									onclick="func1()" type="radio" name="test01" value="30">30개</label></i></a>
					</div>
					<div style="float: left;">
						<a id="selbc3" class="w3-button"><i
							class="fa fa-caret-right w3-margin-right"><label><input
									onclick="func1()" type="radio" name="test01" value="50">50개</label></i></a>
					</div>
					<div style="float: left;">
						<a id="selbc4" class="w3-button"><i
							class="fa fa-caret-right w3-margin-right"><label><input
									onclick="func1()" type="radio" name="test01" value="100">100개</label></i></a>
					</div>
				</div>
			</div>
			<div>
				<br><br><br><br><br>
				<div class="w3-large" style="font-weight: bold">
					<a onclick="myAccFunc1()" class="w3-button" id="myBtn">결제방식
						<i class="fa fa-caret-down"></i>
					</a>
					<div id="demoAcc1" class="w3-bar-block w3-padding-large w3-medium">
						<a id="selbc5" class="w3-button"><i
							class="fa fa-caret-right w3-margin-right"><label><input
									onclick="func2()" type="radio" name="pay01" value="계좌이체"></label></i>계좌이체</a>
						<a id="selbc6" class="w3-button"><i
							class="fa fa-caret-right w3-margin-right"><label><input
									onclick="func2()" type="radio" name="pay01" value="무통장입금"></label></i>무통장입금</a>
						<a id="selbc7" class="w3-button"><i
							class="fa fa-caret-right w3-margin-right"><label><input
									onclick="func2()" type="radio" name="pay01" value="카드결제"></label></i>카드</a>
						<a id="selbc8" class="w3-button"><i
							class="fa fa-caret-right w3-margin-right"><label><input
									onclick="func2()" type="radio" name="pay01" value="문화상품권"></label></i>문화상품권</a>
					</div>
				</div>
			</div>
			<br><br><br><br>
			<p align="center">
				<input type="button" class="w3-button w3-black" value="결제하기"
					onclick="document.getElementById('contact3').style.display='block',func3()"/></p>
		</form>
	
</div>
		<!-- Contact Modal -->
		<div id="contact3" class="w3-modal">
			<div class="w3-modal-content w3-animate-zoom">
				<div class="w3-container w3-black">
					<h1>결제 하시겠습니까?</h1>
				</div>
				<div class="w3-container">
					<p id="cc1"></p>
					<p align="left" style="float: left">
						<button type="button" class="w3-button w3-black"
							onclick="document.getElementById('contact4').style.display='block',func4()">결제하기</button>
					</p>
					<p align="right">
						<button type="button" class="w3-button w3-black"
							onclick="document.getElementById('contact3').style.display='none'">취소</button>
					</p>
				</div>
			</div>
		</div>

		<div id="contact4" class="w3-modal">
			<div class="w3-modal-content w3-animate-zoom">
				<div class="w3-container w3-black">
					<h1>결제가 완료되었습니다.</h1>
				</div>
				<div class="w3-container">
					<p>결제가 정상적으로 처리되었습니다.</p>
					<p align="left">
						<button type="button" class="w3-button w3-black"
							onclick="document.getElementById('contact3').style.display='none',document.getElementById('contact4').style.display='none'">확인</button>
					</p>
				</div>
			</div>
		</div>
<script type="text/javascript">
	var isLog = <%=isLog%>;
	if(isLog){
		document.getElementById("login").style.display = "none"; 
		document.getElementById("logout").style.display = "block"; 
	}else{
		document.getElementById("logout").style.display = "none"; 
		document.getElementById("login").style.display = "block"; 
	}
	var selbc1 = document.querySelector("#selbc1");
	var selbc2 = document.querySelector("#selbc2");
	var selbc3 = document.querySelector("#selbc3");
	var selbc4 = document.querySelector("#selbc4");
	var test01 = document.querySelectorAll('input[name=test01]');
	var cong_cnt = "";

	function func1() {
		for (var i = 0; i < test01.length; i++) {
			if (test01[i].checked) {
				if (test01[0].checked) {
					selbc1.style.backgroundColor = "#eb292b";
					selbc2.style.backgroundColor = "#F8F1E9";
					selbc3.style.backgroundColor = "#F8F1E9";
					selbc4.style.backgroundColor = "#F8F1E9";
					cong_cnt = test01[i].value;
				} else if (test01[1].checked) {
					selbc2.style.backgroundColor = "#eb292b";
					selbc1.style.backgroundColor = "#F8F1E9";
					selbc3.style.backgroundColor = "#F8F1E9";
					selbc4.style.backgroundColor = "#F8F1E9";
					cong_cnt = test01[i].value;
				} else if (test01[2].checked) {
					selbc3.style.backgroundColor = "#eb292b";
					selbc1.style.backgroundColor = "#F8F1E9";
					selbc2.style.backgroundColor = "#F8F1E9";
					selbc4.style.backgroundColor = "#F8F1E9";
					cong_cnt = test01[i].value;
				} else {
					selbc4.style.backgroundColor = "#eb292b";
					selbc1.style.backgroundColor = "#F8F1E9";
					selbc2.style.backgroundColor = "#F8F1E9";
					selbc3.style.backgroundColor = "#F8F1E9";
					cong_cnt = test01[i].value;
				}
			}
			;
		}
	}
	//////////////////////// 결제방식선택
	var selbc5 = document.querySelector("#selbc5");
	var selbc6 = document.querySelector("#selbc6");
	var selbc7 = document.querySelector("#selbc7");
	var selbc8 = document.querySelector("#selbc8");
	var pay01 = document.querySelectorAll('input[name=pay01]');
	var num = "";
	function func2() {
		for (var i = 0; i < pay01.length; i++) {
			if (pay01[i].checked) {
				if (pay01[0].checked) {
					selbc5.style.backgroundColor = "#eb292b";
					selbc6.style.backgroundColor = "#F8F1E9";
					selbc7.style.backgroundColor = "#F8F1E9";
					selbc8.style.backgroundColor = "#F8F1E9";
					num = pay01[i].value;
				} else if (pay01[1].checked) {
					selbc6.style.backgroundColor = "#eb292b";
					selbc5.style.backgroundColor = "#F8F1E9";
					selbc7.style.backgroundColor = "#F8F1E9";
					selbc8.style.backgroundColor = "#F8F1E9";
					num = pay01[i].value;
				} else if (pay01[2].checked) {
					selbc7.style.backgroundColor = "#eb292b";
					selbc5.style.backgroundColor = "#F8F1E9";
					selbc6.style.backgroundColor = "#F8F1E9";
					selbc8.style.backgroundColor = "#F8F1E9";
					num = pay01[i].value;
				} else {
					selbc8.style.backgroundColor = "#eb292b";
					selbc5.style.backgroundColor = "#F8F1E9";
					selbc6.style.backgroundColor = "#F8F1E9";
					selbc7.style.backgroundColor = "#F8F1E9";
					num = pay01[i].value;
				}
			}
			;
		}
	}
	function func3(){
	var cc1 = document.querySelector("#cc1");
	cc1.innerHTML=num+"(으)로 "+cong_cnt+"개 충전하시겠습니까?";
	}
    function func4(){
    	document.querySelector("form").submit();
    }
var buycong = <%=buycong%>
    if(buycong){
    	alert("충전 완료");
    }
    	
    	
</script>
</body>
</html>