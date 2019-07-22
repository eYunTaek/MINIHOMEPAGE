<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="project03.vo.*,java.util.*,project03.dao.*"%>
<%
	String path = request.getContextPath();
%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="default.css" rel="stylesheet" type="text/css" media="all" />
<style type="text/css">
	#login {
		width: 300px;
		margin: 30px 30px;
		margin-left: auto;
		margin-right: auto;
	}
	table {
		width: 100%;
		border-collapse: collapse;
		border-top: 2px solid #444444;
		border-bottom: 2px solid #444444;
		margin-left: auto;
		margin-right: auto;
	}
	th, td {
		border-bottom: 1px solid #BDBDBD;
    	padding: 10px;
	}
	th {background-color: #EAEAEA;}
	td {background-color: #FFFFFF;}
	.btn {
		weight: 70px;
		height: 30px;
		background-color: white;
	}
	input[type=text], input[type=password] {width: 100%;}
</style>
<%
	String valid = NLStr(request.getParameter("valid"));
%>
<script type="text/javascript">
	window.onload = function(){
		var valid = "<%=valid%>";
		if(valid == "N"){
			alert("로그인 해 주세요");
		}
		if(valid == "F"){
			alert("아이디와 비밀번호를 확인 해 주세요");
		}
		if(valid == "NI"){
			alert("아이디와 비밀번호를 입력 해 주세요");
		}
		var addM = document.querySelector("#addM");
		addM.onclick = function(){
			location.href="memInsert.jsp";
		}
		var srhBtn = document.querySelector("#srhBtn");
		srhBtn.onclick = function(){
			location.href="memSearch.jsp";
		}
	}
</script>
</head>
<body>

	<div id="header-wrapper2">
		<div id="header" class="container">
			<div id="logo">
				<h1><a href="Main01.html" class="icon icon-group"><span>KGITBANK</span></a></h1>
			</div>
			<div id="menu">
				<ul>
					<li><a href="Main01.html" title="">회사소개</a></li>
					<li><a href="Main02_notice.jsp" title="">공지사항</a></li>
					<li><a href="Main03_itemes.jsp" title="">아이템샵</a></li>
					<li><a href="Main04_charge.jsp" title="">콩알충전소</a></li>
					<li><a href="Myhome.jsp" title="">내홈피가기</a></li>
					<li class="current_page_item"><a href="mylogin.jsp" title="">로그인</a></li>
				</ul>
			</div>
		</div>
	</div>
	<br><br><br>
	<div id="login">
		<h2 align="center">로그인</h2>
		<br><br>
		<form action="logincheck.jsp" method="post">
			<table align="center" style="text-align:center">
				<col width="50%"><col width="50%">
				<tr><th>아이디</th><td><input type="text" name="id"/></td></tr>
				<tr><th>비밀번호</th><td><input type="password" name="pass"/></td></tr>
			</table>
			<br>
			<div align="center">
				<input type="submit" class="btn" value="로그인"/>&nbsp;
				<input type="button" class="btn" value="회원가입" id="addM"/>&nbsp;
				<input type="button" class="btn" value="찾기" id="srhBtn"/>
			</div>
		</form>
	</div>

</body>

</html>